PImage bg, mblack;
PFont futura;

float __tx = 18; //min:0 max:300
float __ty = 280; //min:90 max:300

float __mx = 50; //min:0 max:250

float __leX= 5;  //min:0 max:150
float __reX= 191; //min:150 max:300
float __leY= 97; //min:0 max:250
float __reY= 15; //min:0 max:250

int __t1 = 0; //min:-10 max:20
int __t2 = 0; //min:-10 max:20
int __t3 = 0; //min:-10 max:20

float __r = 253; //min:200 max:255
float __g = 197; //min:180 max:215
float __b = 0; //min:0 max:20

void setup() {
  size(300, 300);
  //pixelDensity(2);
  bg = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\mickey_poster\\mickey_poster\\data\\1-expanded.png");
  mblack = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\mickey_poster\\mickey_poster\\data\\m_black.png");

  futura  = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\mickey_poster\\mickey_poster\\data\\FuturaStd-Bold.otf", 120);
}

void draw() {
  background(255);

  blendMode(BLEND);
  image(bg, 0, 0, width, height);

  //image(mblack, width/2 - 10, height - 120, 90, 120);
  //left eye
  copy(mblack, 108, 88, 150, 300, 5, 97, 50, 100 + __t1);
  //right eye
  copy(mblack, 327, 88, 150, 300, 191, 15, 50, 100 + __t2);
  //mouth
  copy(mblack, 0, 500, 600, 300, int(__mx), 218, 150 + __t3, 75);

  textFont(futura);
  textSize(120);
  fill(__r,__g, __b);
  text("M", __tx, __ty);
}
