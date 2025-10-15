//Sketch "Chaotic bezier curves" by Ricardo Sacadura
// @ February 6th 2024

float __x1 = 332; // min:0 max:300
float __x2 = 25; // min:0 max:300
float __x3 = 192; // min:0 max:300
float __x4 = 123; // min:0 max:300
float __x5 = 56; // min:0 max:300
float __x6 = 325; // min:0 max:300
float __x7 = 291; // min:0 max:300
float __x8 = 10; // min:0 max:300
float __x9 = 15; // min:0 max:300
float __x10 = 76; // min:0 max:300
float __x11 = 9; // min:0 max:300
float __x12 = 200; // min:0 max:300
float __x13 = 192; // min:0 max:300
float __x14 = 34; // min:0 max:300
float __x15 = 100; // min:0 max:300
float __x16 = 189; // min:0 max:300

float __y1 = 12; // min:0 max:300
float __y2 = 123; // min:0 max:300
float __y3 = 329; // min:0 max:300
float __y4 = 87; // min:0 max:300
float __y5 = 246; // min:0 max:300
float __y6 = 9; // min:0 max:300
float __y7 = 89; // min:0 max:300
float __y8 = 76; // min:0 max:300
float __y9 = 192; // min:0 max:300
float __y10 = 273; // min:0 max:300
float __y11 = 12; // min:0 max:300
float __y12 = 81; // min:0 max:300
float __y13 = 52; // min:0 max:300
float __y14 = 289; // min:0 max:300
float __y15 = 172; // min:0 max:300
float __y16 = 9; // min:0 max:300

int __sW1 = 2; //min:2 max:9
int __sW2 = 3; //min:2 max:9
int __sW3 = 2; //min:2 max:9
int __sW4 = 5; //min:2 max:9
int __sW5 = 3; //min:2 max:9
int __sW6 = 8; //min:2 max:9

int __s1 = 45; //min:0 max:360
int __s2 = 123; //min:0 max:360
int __s3 = 5; //min:0 max:360
int __s4 = 45; //min:0 max:360
int __s5 = 145; //min:0 max:360
int __s6 = 245; //min:0 max:360

void setup() {
  size(300, 300);

  background(255);
  colorMode(HSB, 360, 100, 100);

  stroke(0);
  noFill();

  strokeWeight(__sW1);
  //stroke(__s1, 100 , 50);
  bezier(__x1, __y1, __x2, __y2, __x3, __y3, __x4, __y4);

  strokeWeight(__sW2);
  //stroke(__s2, 100 , 50);
  bezier(__x5, __y5, __x6, __y6, __x7, __y7, __x8, __y8);

  strokeWeight(__sW3);
  //stroke(__s3, 100 , 50);
  bezier(__x9, __y9, __x10, __y10, __x11, __y11, __x12, __y12);

  strokeWeight(__sW4);
  //stroke(__s4, 100 , 50);
  bezier(__x13, __y13, __x14, __y14, __x15, __y15, __x16, __y16);

  strokeWeight(__sW5);
  //stroke(__s5, 100 , 50);
  bezier(__x5, __y5, __x2, __y2, __x7, __y7, __x4, __y4);

  strokeWeight(__sW6);
  //stroke(__s6, 100 , 50);
  bezier(__x1, __y1, __x6, __y6, __x3, __y3, __x8, __y8);
}

void draw() {
}
