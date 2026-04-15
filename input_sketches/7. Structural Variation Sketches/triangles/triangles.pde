float __x1 = 50; //min:25 max:275
float __y1 = 150; //min:25 max:275

float __x2 = 100; //min:25 max:275
float __y2 = 150; //min:25 max:275

float __w1 = 30; //min:30 max:100
float __h1 = 150; //min:20 max:200

float __w2 = 30; //min:30 max:100
float __h2 = 50; //min:20 max:200

float __a1 = 0; //min:-45 max:45
float __a2 = 0; //min:-45 max:45

void setup() {
  size(300, 300);
}

void draw() {
  background(255);
  noStroke();
  fill(0);
  
  pushMatrix();
  translate(75, __y1);
  rotate(__a1);
  drawTriangleCentered(0, 0, __w1, __h1);
  popMatrix();
  
  pushMatrix();
  translate(225, __y2);
  rotate(__a2);
  drawTriangleCentered(0, 0, __w2, __h2);
  popMatrix();
}

void drawTriangleCentered(float x, float y, float w, float h) {
  beginShape();
  vertex(x, y-h/2);
  vertex(x + w/2, y+h/2);
  vertex(x-w/2, y+h/2);
  endShape(CLOSE);
}
