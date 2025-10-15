/*
 |  Experimental setup, input #1
 |  Sketch 'Connected Lines' by Ricardo Sacadura
 |  (November, 2023)
 **/

float __x1  = 5;    // min:0 max:300
float __y1  = 95;   // min:0 max:300
float __x2  = 25;   // min:0 max:300
float __y2  = 27;   // min:0 max:300
float __x3  = 200;  // min:0 max:300
float __y3  = 40;   // min:0 max:300
float __x4  = 10;   // min:0 max:300
float __y4  = 200;  // min:0 max:300
float __x5  = 225;  // min:0 max:300
float __y5  = 75;   // min:0 max:300
float __x6  = 20;   // min:0 max:300
float __y6  = 98;   // min:0 max:300
float __x7  = 32;   // min:0 max:300
float __y7  = 182;  // min:0 max:300
float __x8  = 123;  // min:0 max:300
float __y8  = 241;  // min:0 max:300
float __x9  = 19;   // min:0 max:300
float __y9  = 78;   // min:0 max:300
float __x10 = 56;   // min:0 max:300
float __y10 = 300;  // min:0 max:300


float [][] pos = {{__x1, __y1}, {__x2, __y2}, {__x3, __y3}, {__x4, __y4},
  {__x5, __y5}, {__x6, __y6}, {__x7, __y7}, {__x8, __y8},
  {__x9, __y9}, {__x10, __y10}
};

void setup() {
  size(250, 250);
  background(250);
  blendMode(MULTIPLY);

  createNet();
}

void draw() {
}

void createNet() {

  fill(0);
  stroke(0, 175);
  strokeWeight(4);

  for (int i = 0; i < pos.length; ++i) {
    ellipse(pos[i][0], pos[i][1], 3, 3);
    if (i < pos.length - 1) line(pos[i][0], pos[i][1], pos[i+1][0], pos[i+1][1]);
  }
}
