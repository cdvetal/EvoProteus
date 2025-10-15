//rect-1
float __xr1 = 250; //min:0 max:300
float __yr1 = 20; //min:0 max:300
float __dr1 = 30; //min:0 max:100
//rect-2
float __xr2 = 50; //min:0 max:300
float __yr2 = 100; //min:0 max:300
float __dr2 = 60; //min:0 max:100
//rect-3
float __xr3 = 150; //min:0 max:300
float __yr3 = 200; //min:0 max:300
float __dr3 = 100; //min:0 max:100
//ellipse
float __xc = 300; //min:0 max:300
float __yc = 175; //min:0 max:300
float __r = 105; //min:80 max:200

float xc, yc, xr1, yr1, xr2, yr2, xr3, yr3;

int sw = 10;

void setup() {
  size(300, 300);
}

void draw() {
  background(#F2F2F2);
  stroke(0);
  strokeWeight(sw);
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);

  xc = constrain(__xc, __r + sw, width - (__r + sw));
  yc = constrain(__yc, __r + sw, height - (__r + sw));
  ellipse(xc, yc, __r*2, __r*2);

  fill(0);
  noStroke();

  xr1 = constrain(__xr1, __dr1/2, width - __dr1/2);
  yr1 = constrain(__yr1, __dr1/2, height - __dr1/2);
  rect(xr1, yr1, __dr1, __dr1);

  xr2 = constrain(__xr2, __dr2/2, width - __dr2/2);
  yr2 = constrain(__yr2, __dr2/2, height - __dr2/2);
  rect(xr2, yr2, __dr2, __dr2);

  xr3 = constrain(__xr3, __dr3/2, width - __dr3/2);
  yr3 = constrain(__yr3, __dr3/2, height - __dr3/2);
  rect(xr3, yr3, __dr3, __dr3);
}

void drawRectangle(float x, float y, float w, float h, float ang) {
  rectMode(CENTER);
  fill(#252422);
  pushMatrix();
  translate(x, y);
  rotate(radians(ang));
  rect(0, 0, w, h);
  popMatrix();
}
