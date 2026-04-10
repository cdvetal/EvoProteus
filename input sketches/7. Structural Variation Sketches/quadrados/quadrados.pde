float __x1 = 30; //min:15 max:285
float __y1 = 30; //min:15 max:285

float __x2 = 80; //min:15 max:285
float __y2 = 30; //min:15 max:285

float __x3 = 120; //min:15 max:285
float __y3 = 30; //min:15 max:285

float __x4 = 170; //min:15 max:285
float __y4 = 30; //min:15 max:285


void setup() {
  size(300, 300);
}

void draw() {
  background(255);
  noStroke();
  fill(0);
  rectMode(CENTER);

  rect(__x1, __y1, 30, 30);
  rect(__x2, __y2, 30, 30);
  rect(__x3, __y3, 30, 30);
  rect(__x4, __y4, 30, 30);
}
