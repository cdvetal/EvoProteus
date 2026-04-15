import sys

import requests
import json
import cv2

addr = 'http://127.0.0.1:5000'
test_url = addr + '/images/clip_aesthetic'

assert len(sys.argv) == 3

# Get image path and prompt
image_path = sys.argv[1]
prompt = sys.argv[2]

# prepare headers for http request
content_type = 'image/jpeg'
headers = {'content-type': content_type}

img = cv2.imread(image_path)
if img is None:
	print(json.dumps({"error": f"failed to read image: {image_path}"}))
	sys.exit(1)

# encode image as jpeg
_, img_encoded = cv2.imencode('.jpg', img)

try:
	# send http request with image and receive response
	response = requests.post(
		test_url,
		data=img_encoded.tobytes(),
		headers=headers,
		params={'prompt': prompt},
		timeout=120,
	)
except requests.RequestException as exc:
	print(json.dumps({"error": f"request failed: {exc}"}))
	sys.exit(1)

if not response.ok:
	body = response.text.strip()
	print(json.dumps({
		"error": "metric api returned non-200",
		"status": response.status_code,
		"body": body[:500],
	}))
	sys.exit(1)

try:
	payload = response.json()
except ValueError:
	print(json.dumps({
		"error": "metric api returned invalid JSON",
		"status": response.status_code,
		"body": response.text.strip()[:500],
	}))
	sys.exit(1)

# Print strict JSON so Processing JSONObject.parse can decode it.
print(json.dumps(payload))
