ArrayList<Rectangle> rectangles;

float __fillProb = 0.3; //min:0.05 max:1
float __splitProbX = 0.5; //min:0.1 max:0.8
float __splitProbY = 0.5; //min:0.1 max:0.8


void setup() {
  size(200, 200);
  background(255);
  colorMode(HSB);

  rectangles = new ArrayList<Rectangle>();

  int x = 15;
  int y = 15;
  int w = 170;
  int h = 170;
  int step = 170 / 6;
  Rectangle rectStart = new Rectangle(x, y, w, h);
  rectangles.add(rectStart);

  for (int i = 0; i < 170; i += step) {
    splitSquaresWith(new PVector(x + i, y));
    splitSquaresWith(new PVector(x, y + i));
  }

  for (int i = rectangles.size() - 1; i >= 0; i--) {
    rectangles.get(i).show();
  }
}

void splitSquaresWith(PVector point) {
  for (int i = rectangles.size() - 1; i >= 0; i--) {
    Rectangle square = rectangles.get(i);

    if (point.x != 0 && point.x > square.x && point.x < (square.x + square.w)) {
      if (random(1) > __splitProbX) {
        rectangles.remove(i);
        splitOnX(square, (int) point.x);
      }
    }

    if (point.y != 0 && point.y > square.y && point.y < (square.y + square.h)) {
      if (random(1) > __splitProbY) {
        rectangles.remove(i);
        splitOnY(square, (int) point.y);
      }
    }
  }
}

void splitOnX(Rectangle square, int cx) {
  int newX = square.x;
  int newY = square.y;
  int newW = square.w - (square.w - cx + square.x);
  int newH = square.h;
  Rectangle squareA = new Rectangle(newX, newY, newW, newH);

  int newX2 = cx;
  int newY2 = square.y;
  int newW2 = square.w - cx + square.x;
  int newH2 = square.h;
  Rectangle squareB = new Rectangle(newX2, newY2, newW2, newH2);

  rectangles.add(squareA);
  rectangles.add(squareB);
}

void splitOnY(Rectangle square, int cy) {
  int newX = square.x;
  int newY = square.y;
  int newW = square.w;
  int newH = square.h - (square.h - cy + square.y);
  Rectangle squareA = new Rectangle(newX, newY, newW, newH);

  int newX2 = square.x;
  int newY2 = cy;
  int newW2 = square.w;
  int newH2 = square.h - cy + square.y;
  Rectangle squareB = new Rectangle(newX2, newY2, newW2, newH2);

  rectangles.add(squareA);
  rectangles.add(squareB);
}

void keyPressed() {
  if (key == 's') {
    save("mondrian.png");
  }
}

void draw() {
}

class Rectangle {
  int x, y, w, h;

  Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void show() {
    stroke(0);
    strokeWeight(3);
    if (random(1) < __fillProb) {
      int c = int(random(3));
      if (c == 0) fill(#fff001);
      if (c == 1) fill(#ff0101);
      if (c == 2) fill(#0101fd);
    } else {
      fill(255);
    }
    rect(x, y, w, h);
  }
}
