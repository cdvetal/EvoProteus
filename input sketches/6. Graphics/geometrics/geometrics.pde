float __x1 = 100; //min:10 max:300
float __x2 = 300; //min:10 max:300
float __x3 = 15; //min:10 max:300

float __y1 = 100; //min:10 max:300
float __y2 = 200; //min:10 max:300
float __y3 = 100; //min:10 max:300

float __h1 = 100; //min:20 max:200
float __h2 = 150; //min:20 max:200
float __h3 = 75; //min:20 max:200

float __a1 = 0; //min:-45 max:45
float __a2 = -20; //min:0 max:180
float __a3 = 20; //min:0 max:180

float __x4 = 175; //min:0 max:300
float __y4 = 175; //min:0 max:300
float __d = 105; //min:80 max:200

void setup() {
  size(350, 350);
}

void draw() {
  background(#F2F2F2);

  noStroke();
  ellipseMode(CENTER);

  fill(#252422);
  ellipse(__x4, __y4, __d, __d);


  drawRectangle(__x1, __y1, 25, __h1, __a1);
  drawRectangle(__x2, __y2, 25, __h2, __a2);
  drawRectangle(__x3, __y3, 25, __h3, __a3);
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
