// Sketch "This is not typography" by ricardo sacadura


float __x1 = 50; //min:20 max:150
float __x2 = 100; //min:20 max:150
float __x3 = 200; //min:20 max:150
float __x4 = 200; //min:20 max:150
float __x5 = 200; //min:20 max:150

float __y1 = 150; //min:50 max:250
float __y2 = 100; //min:50 max:250
float __y3 = 150; //min:50 max:250
float __y4 = 200; //min:50 max:250
float __y5 = 200; //min:50 max:250



int __ts1 = 150; //min:40 max:250
int __ts2 = 100; //min:40 max:250
int __ts3 = 150; //min:40 max:250
int __ts4 = 200; //min:40 max:250
int __ts5 = 200; //min:40 max:250


float __a1 = 0; //min:0 max:360
float __a2 = 10; //min:0 max:360
float __a3 = 180; //min:0 max:360
float __a4 = -90; //min:0 max:360
float __a5 = 300; //min:0 max:360


PFont font;

void setup() {
  size(300, 300);
  font = createFont("GaramondPremrPro-Med.otf", 150);

  background(255);
  fill(0);

  textFont(font);

  pushMatrix();
  textSize(__ts1);
  translate(__x1, __y1);
  rotate(radians(__a1));
  text("O", 0, 0);
  popMatrix();

  pushMatrix();
  textSize(__ts2);
  translate(__x2, __y2);
  rotate(radians(__a2));
  text("{", 0, 0);
  popMatrix();

  pushMatrix();
  textSize(__ts3);
  translate(__x3, __y3);
  rotate(radians(__a3));
  text("!", 0, 0);
  popMatrix();

  pushMatrix();
  textSize(__ts4);
  translate(__x4, __y4);
  rotate(radians(__a4));
  text("{", 0, 0);
  popMatrix();

  pushMatrix();
  textSize(__ts5);
  translate(__x5, __y5);
  rotate(radians(__a5));
  text("!", 0, 0);
  popMatrix();
}

void draw() {
}
