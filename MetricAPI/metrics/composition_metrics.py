import cv2
import numpy as np
import torch

from .loss_interface import LossInterface


def _to_bgr_uint8(img_tensor: torch.Tensor) -> np.ndarray:
    """
    Converts a BCHW tensor in [-1,1] or [0,1] to uint8 BGR image for OpenCV.
    Expects batch size 1.
    """
    if img_tensor.ndim != 4 or img_tensor.shape[0] != 1:
        raise ValueError(f"Expected tensor shape [1,C,H,W], got {tuple(img_tensor.shape)}")

    x = img_tensor.detach().cpu().float()[0]

    # Handle [-1,1] or [0,1]
    if x.min() < 0:
        x = (x + 1.0) / 2.0

    x = x.clamp(0, 1)
    x = x.permute(1, 2, 0).numpy()  # HWC, RGB
    x = (x * 255.0).astype(np.uint8)

    # RGB -> BGR for cv2
    return cv2.cvtColor(x, cv2.COLOR_RGB2BGR)


def _to_gray_uint8(img_tensor: torch.Tensor) -> np.ndarray:
    bgr = _to_bgr_uint8(img_tensor)
    return cv2.cvtColor(bgr, cv2.COLOR_BGR2GRAY)


class YAxisSymmetryLoss(LossInterface):
    """
    Left-right symmetry around the vertical center line.
    Returns higher score for stronger symmetry.
    """

    def evaluate(self, img: torch.Tensor) -> torch.Tensor:
        gray = _to_gray_uint8(img).astype(np.float32) / 255.0

        h, w = gray.shape
        mid = w // 2

        left = gray[:, :mid]
        right = gray[:, w - mid:]
        right_flipped = np.fliplr(right)

        diff = np.abs(left - right_flipped)
        score = 1.0 - float(diff.mean())
        score = max(0.0, min(1.0, score))

        return torch.tensor(score, device=self.device, dtype=torch.float32)


class VerticalDirectionLoss(LossInterface):
    """
    Measures dominance of vertical lines using Hough transform.
    Returns higher score for stronger vertical direction.
    """

    def __init__(self, angle_tolerance_deg: float = 15.0):
        super().__init__()
        self.angle_tolerance_deg = angle_tolerance_deg

    def evaluate(self, img: torch.Tensor) -> torch.Tensor:
        gray = _to_gray_uint8(img)
        edges = cv2.Canny(gray, 50, 150)

        lines = cv2.HoughLinesP(
            edges,
            rho=1,
            theta=np.pi / 180.0,
            threshold=30,
            minLineLength=20,
            maxLineGap=10
        )

        if lines is None:
            return torch.tensor(0.0, device=self.device, dtype=torch.float32)

        vertical_length = 0.0
        total_length = 0.0

        for line in lines[:, 0]:
            x1, y1, x2, y2 = line
            dx = x2 - x1
            dy = y2 - y1
            length = float(np.hypot(dx, dy))
            if length <= 0:
                continue

            angle = abs(np.degrees(np.arctan2(dy, dx)))
            if angle > 90:
                angle = 180 - angle

            total_length += length
            if abs(angle - 90.0) <= self.angle_tolerance_deg:
                vertical_length += length

        score = 0.0 if total_length == 0 else vertical_length / total_length
        score = max(0.0, min(1.0, score))

        return torch.tensor(score, device=self.device, dtype=torch.float32)


class DiagonalDirectionLoss(LossInterface):
    """
    Measures dominance of diagonal lines.
    By default targets both 45° and 135°.
    """

    def __init__(self, angle_tolerance_deg: float = 15.0, target_angles=(45.0, 135.0)):
        super().__init__()
        self.angle_tolerance_deg = angle_tolerance_deg
        self.target_angles = tuple(float(a) for a in target_angles)

    def evaluate(self, img: torch.Tensor) -> torch.Tensor:
        gray = _to_gray_uint8(img)
        edges = cv2.Canny(gray, 50, 150)

        lines = cv2.HoughLinesP(
            edges,
            rho=1,
            theta=np.pi / 180.0,
            threshold=30,
            minLineLength=20,
            maxLineGap=10
        )

        if lines is None:
            return torch.tensor(0.0, device=self.device, dtype=torch.float32)

        diagonal_length = 0.0
        total_length = 0.0

        for line in lines[:, 0]:
            x1, y1, x2, y2 = line
            dx = x2 - x1
            dy = y2 - y1
            length = float(np.hypot(dx, dy))
            if length <= 0:
                continue

            angle = float(np.degrees(np.arctan2(dy, dx)) % 180.0)
            total_length += length

            if any(abs(angle - target) <= self.angle_tolerance_deg for target in self.target_angles):
                diagonal_length += length

        score = 0.0 if total_length == 0 else diagonal_length / total_length
        score = max(0.0, min(1.0, score))

        return torch.tensor(score, device=self.device, dtype=torch.float32)


class SpiralArrangementLoss(LossInterface):
    """
    Heuristic spiral score based on contour centroids.
    Best for images with discrete geometric elements.
    """

    def __init__(self, min_area: float = 50.0, binary_threshold: int = 0):
        super().__init__()
        self.min_area = min_area
        self.binary_threshold = binary_threshold

    def _extract_points(self, gray: np.ndarray) -> np.ndarray:
        # Otsu if threshold <= 0
        if self.binary_threshold <= 0:
            _, thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
        else:
            _, thresh = cv2.threshold(gray, self.binary_threshold, 255, cv2.THRESH_BINARY)

        contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        points = []
        for cnt in contours:
            area = cv2.contourArea(cnt)
            if area < self.min_area:
                continue

            m = cv2.moments(cnt)
            if m["m00"] == 0:
                continue

            cx = m["m10"] / m["m00"]
            cy = m["m01"] / m["m00"]
            points.append((cx, cy))

        if len(points) == 0:
            return np.zeros((0, 2), dtype=np.float32)

        return np.array(points, dtype=np.float32)

    def evaluate(self, img: torch.Tensor) -> torch.Tensor:
        gray = _to_gray_uint8(img)
        h, w = gray.shape[:2]
        points = self._extract_points(gray)

        if len(points) < 4:
            return torch.tensor(0.0, device=self.device, dtype=torch.float32)

        cx, cy = w / 2.0, h / 2.0
        rel = points - np.array([cx, cy], dtype=np.float32)

        x = rel[:, 0]
        y = rel[:, 1]

        r = np.sqrt(x ** 2 + y ** 2)
        theta = np.arctan2(y, x)

        order = np.argsort(theta)
        theta = theta[order]
        r = r[order]

        theta = np.unwrap(theta)

        A = np.vstack([np.ones_like(theta), theta]).T
        coeffs, _, _, _ = np.linalg.lstsq(A, r, rcond=None)
        r_pred = A @ coeffs

        rmse = float(np.sqrt(np.mean((r - r_pred) ** 2)))
        scale = max(float(r.max()), 1e-6)

        score = 1.0 - (rmse / scale)
        score = max(0.0, min(1.0, score))

        return torch.tensor(score, device=self.device, dtype=torch.float32)
