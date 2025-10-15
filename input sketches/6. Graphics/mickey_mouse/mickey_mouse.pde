//mickey mouse
PImage bg, m;
PFont futura;

int __fs1 = 28; //min:64 max:128
int __fs2 = 28; //min:44 max:94
int __fs3 = 28; //min:44 max:94
int __fs4 = 28; //min:44 max:94
int __fs5 = 28; //min:44 max:94
int __fs6 = 28; //min:44 max:94

int __x1 = 28; //min:0 max:300
int __x2 = 28; //min:0 max:300
int __x3 = 28; //min:0 max:300
int __x4 = 28; //min:0 max:300
int __x5 = 28; //min:0 max:300
int __x6 = 28; //min:0 max:300

int __y1 = 28; //min:0 max:300
int __y2 = 28; //min:0 max:300
int __y3 = 28; //min:0 max:300
int __y4 = 28; //min:0 max:300
int __y5 = 28; //min:0 max:300
int __y6 = 28; //min:0 max:300

float __r = 255; //min:0 max:255
float __g = 0; //min:0 max:255
float __b = 0; //min:0 max:255

void setup() {
  size(300, 300);
  bg = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\mickey_mouse\\data\\1-expanded.png");
  m = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\mickey_mouse\\data\\m.png");
  futura = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\mickey_mouse\\data\\FuturaStd-Bold.otf", 128);
}

void draw() {

  background(255);
  image(bg, 0, 0, width, height);
  pushStyle();
  tint(__r, __g, __b);
  blendMode(SCREEN);
  image(m, 132, 162, 90.25, 146);
  popStyle();
  noTint();

  pushStyle();
  blendMode(DIFFERENCE);
  textFont(futura);
  textSize(__fs1);
  fill(255);
  text("M", __x1, __y1);
  textSize(__fs2);
  text("i", __x2, __y2);
  textSize(__fs3);
  text("c", __x3, __y3);
  textSize(__fs4);
  text("k", __x4, __y4);
  textSize(__fs5);
  text("e", __x5, __y5);
  textSize(__fs6);
  text("y", __x6, __y6);
  popStyle();
}
