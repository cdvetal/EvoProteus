//ballet
PImage bg, bg_2, tutu, graca, sign, sign_2;
PFont f, f2;

int __b = 1; //min:0 max:100

// pink 246, 83, 166 #F653A6
// violet 138, 43, 226 #8A2BE2
// orange 255, 79, 0 #FF4F00
// blue 0, 0, 156 #00009C

int __tColour = 2; //min:1 max:5
int __textColour = 1; //min:1 max:12

float __t1xpos = 5; //min:0 max:220
float __t1ypos = 149; //min:5 max:150

float __t2xpos = 63; //min:0 max:220
float __t2ypos = 211; //min:150 max:270

//float __sxpos = 24; //min:10 max:180

float __tSize = 56; //min:48 max:94
int __tFont = 1; //min:0 max:1

void setup() {

  size(350, 350);
  pixelDensity(2);

  bg = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\bg.png");
  bg_2= loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\bg-2.png");
  tutu = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\tutu.png");
  graca = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\graca.png");
  sign = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\signage.png");
  sign_2 = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\signage-2.png");

  f = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\GrotesqueMTStd-LightItalic.otf", 128);
  f2 = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\ballet\\data\\Gwendolyn-Bold.otf", 128);
}

void draw() {
  background(__b);

  noTint();
  if (__b >= 50)image(bg, 0, 0, width, height);
  if (__b <= 50)image(bg_2, 0, 0, width, height);

  if (__tColour == 1) {
    //pink
    tint(246, 83, 166, 200);
  } else if (__tColour == 2) {
    //violet
    tint(138, 43, 226, 200);
  } else if (__tColour == 3) {
    //blue
    tint(0, 0, 156, 200);
  } else if (__tColour == 4) {
    noTint();
  } else {
    tint(225, 79, 0, 200);
  }

  image(graca, 126, 23, 110.46, 87.36);
  image(tutu, 11, -3, 323.55, 324);
  
  noTint();
  //if (__b >= 50) image(sign, __sxpos, 266, 103.088, 50.048);
  //if (__b <= 50) image(sign_2, __sxpos, 266, 103.088, 50.048);

  if (__b >= 50) fill(0);
  if (__b <= 50) fill(255);

  if (__textColour == 1) {
    //pink
    fill(246, 83, 166, 200);
  } else if (__textColour == 2) {
    //violet
    fill(138, 43, 226, 200);
  } else if (__textColour == 3) {
    //blue
    fill(0, 0, 156, 200);
  } else if (__textColour == 4) {
    fill(225, 79, 0, 200);
  } else {
    if (__b >= 50) fill(0);
    if (__b <= 50) fill(255);
  }

  if (__tFont == 0) textFont(f);
  if (__tFont == 1) textFont(f2);

  textSize(__tSize);
  text("Ballet", __t1xpos, __t1ypos);
  text("Gulbenkian", __t2xpos, __t2ypos);
}
