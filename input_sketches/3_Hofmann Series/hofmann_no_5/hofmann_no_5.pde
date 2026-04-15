/*
 Series of computational abstractions of artefacts depicted
 in Armin Hofmann's "Methodik Der Form - Und Bildgestaltung"
 
 No.5 The Line (From the book - figure 193)
 
 Ricardo Sacadura (2024)
 */

float __x1 = 0; //min:20 max:280
float __x2 = 0; //min:20 max:280
float __x3 = 0; //min:20 max:280
float __x4 = 0; //min:20 max:280
float __x5 = 0; //min:20 max:280
float __x6 = 0; //min:20 max:280
float __x7 = 0; //min:20 max:280
float __x8 = 0; //min:20 max:280
float __x9 = 0; //min:20 max:280
float __x10 = 0; //min:20 max:280
float __x11 = 0; //min:20 max:280
float __x12 = 0; //min:20 max:280
float __x13 = 0; //min:20 max:280
float __x14 = 0; //min:20 max:280
float __x15 = 0; //min:20 max:280
float __x16 = 0; //min:20 max:280
float __x17 = 0; //min:20 max:280
float __x18 = 0; //min:20 max:280
float __x19 = 0; //min:20 max:280
float __x20 = 0; //min:20 max:280

float __y1 = 0; //min:20 max:280
float __y2 = 0; //min:20 max:280
float __y3 = 0; //min:20 max:280
float __y4 = 0; //min:20 max:280
float __y5 = 0; //min:20 max:280
float __y6 = 0; //min:20 max:280
float __y7 = 0; //min:20 max:280
float __y8 = 0; //min:20 max:280
float __y9 = 0; //min:20 max:280
float __y10 = 0; //min:20 max:280
float __y11 = 0; //min:20 max:280
float __y12 = 0; //min:20 max:280
float __y13 = 0; //min:20 max:280
float __y14 = 0; //min:20 max:280
float __y15 = 0; //min:20 max:280
float __y16 = 0; //min:20 max:280
float __y17 = 0; //min:20 max:280
float __y18 = 0; //min:20 max:280
float __y19 = 0; //min:20 max:280
float __y20 = 0; //min:20 max:280


float __a1 = 45; //min:0 max:360
float __a2 = 45; //min:0 max:360
float __a3 = 45; //min:0 max:360
float __a4 = 45; //min:0 max:360
float __a5 = 45; //min:0 max:360
float __a6 = 45; //min:0 max:360
float __a7 = 45; //min:0 max:360
float __a8 = 45; //min:0 max:360
float __a9 = 45; //min:0 max:360
float __a10 = 45; //min:0 max:360
float __a11 = 45; //min:0 max:360
float __a12 = 45; //min:0 max:360
float __a13 = 45; //min:0 max:360
float __a14 = 45; //min:0 max:360
float __a15 = 45; //min:0 max:360
float __a16 = 45; //min:0 max:360
float __a17 = 45; //min:0 max:360
float __a18 = 45; //min:0 max:360
float __a19 = 45; //min:0 max:360
float __a20 = 45; //min:0 max:360




void setup() {
  size(300, 300);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  background(255);
  fill(0);

  //drawNeedle(width/2, height/2, 90);
  drawNeedle(__x1, __y1, __a1);
  drawNeedle(__x2, __y2, __a2);
  drawNeedle(__x3, __y3, __a3);
  drawNeedle(__x4, __y4, __a4);
  drawNeedle(__x5, __y5, __a5);
  drawNeedle(__x6, __y6, __a6);
  drawNeedle(__x7, __y7, __a7);
  drawNeedle(__x8, __y8, __a8);
  drawNeedle(__x9, __y9, __a9);
  drawNeedle(__x10, __y10, __a10);
  drawNeedle(__x11, __y11, __a11);
  drawNeedle(__x12, __y12, __a12);
  drawNeedle(__x13, __y13, __a13);
  drawNeedle(__x14, __y14, __a14);
  drawNeedle(__x15, __y15, __a15);
  drawNeedle(__x16, __y16, __a16);
  drawNeedle(__x17, __y17, __a17);
  drawNeedle(__x18, __y18, __a18);
  drawNeedle(__x19, __y19, __a19);
  drawNeedle(__x20, __y20, __a20);
}

void drawNeedle(float x, float y, float ang) {
  pushMatrix();
  translate(x, y);
  rotate(radians(ang));
  rect(0, 0, 90, 1);
  ellipse(45, 0, 7, 7);
  popMatrix();
  ellipseMode(CENTER);
}
