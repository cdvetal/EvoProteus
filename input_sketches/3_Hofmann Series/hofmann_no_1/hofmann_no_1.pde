/*
 Series of computational abstractions of artefacts depicted
 in Armin Hofmann's "Methodik Der Form - Und Bildgestaltung"
 
 No.1 The Circle (From the book - figures 65 to 69)
 
 Ricardo Sacadura
 */

float __x1 = 50; //min:10 max:390
float __y1 = 50; //min:10 max:390
float __x2 = 200; //min:10 max:390
float __y2 = 50; //min:10 max:390
float __x3 = 50; //min:10 max:390
float __y3 = 200; //min:10 max:390
float __x4 = 200; //min:10 max:390
float __y4 = 200; //min:10 max:390
float __x5 = 300; //min:10 max:390
float __y5 = 300; //min:10 max:390

int __sW1 = 8; //min:1 max:100
int __sW2 = 3; //min:1 max:100
int __sW3 = 50; //min:1 max:100
int __sW4 = 5; //min:1 max:100
int __sW5 = 10; //min:1 max:100

float __r1 = 80; //min:10 max:80
float __r2 = 10; //min:10 max:80
float __r3 = 40; //min:10 max:80
float __r4 = 20; //min:10 max:80
float __r5 = 90; //min:10 max:80

float adjustX (float x, float r, int sw) {
  while (x < r + sw) ++x;
  while (x > width - (r + sw)) --x;
  return x;
}

float adjustY (float y, float r, int sw) {
  while (y < r + sw) ++y;
  while (y > width - (r + sw)) --y;
  return y;
}


void setup() {

  size(300, 300);
  noFill();
  __x1 = adjustX(__x1, __r1, __sW1);
  __y1 = adjustX(__y1, __r1, __sW1);
  __x2 = adjustX(__x2, __r2, __sW2);
  __y2 = adjustX(__y2, __r2, __sW2);
  __x3 = adjustX(__x3, __r3, __sW3);
  __y3 = adjustX(__y3, __r3, __sW3);
  __x4 = adjustX(__x4, __r4, __sW4);
  __y4 = adjustX(__y4, __r4, __sW4);
  __x5 = adjustX(__x5, __r5, __sW5);
  __y5 = adjustX(__y5, __r5, __sW5);
}

void draw() {

  background(#f1f1f1);

  strokeWeight(__sW1);
  ellipse(__x1, __y1, __r1*2, __r1*2);

  strokeWeight(__sW2);
  ellipse(__x2, __y2, __r2*2, __r2*2);

  strokeWeight(__sW3);
  ellipse(__x3, __y3, __r3*2, __r3*2);

  strokeWeight(__sW4);
  ellipse(__x4, __y4, __r4*2, __r4*2);

  strokeWeight(__sW5);
  ellipse(__x5, __y5, __r5*2, __r5*2);
}
