/*
 |  EvoProteus sketch [6]
 |  Sketch 'Evomusart poster' by Ricardo Sacadura
 |  (November, 2023)
 **/

float __x1 =226.97923; //min:0 max:350
float __y1 =174.0051; //min:0 max:350
float __x2 =110.38238; //min:0 max:350
float __y2 =177.74873; //min:0 max:350
float __x3 =12.461704; //min:0 max:350
float __y3 =27.56576; //min:0 max:350
float __x4 =131.19316; //min:0 max:350
float __y4 =277.96133; //min:0 max:350
float __x5 =17.596024; //min:0 max:350
float __y5 =169.65942; //min:0 max:350
float __x6 =108.81556; //min:0 max:350
float __y6 =248.97499; //min:0 max:350
float __x7 =246.13644; //min:0 max:350
float __y7 =5.621481; //min:0 max:350
float __x8 =235.74864; //min:0 max:350
float __y8 =170.79208; //min:0 max:350

float __h1 =21.405508; //min:0 max:360
float __s1 =50.204063; //min:0 max:100
float __b1 =68.785095; //min:20 max:100
float __h2 =251.71417; //min:0 max:360
float __s2 =48.863907; //min:0 max:100
float __b2 =61.03245; //min:20 max:100
float __h3 =245.25198; //min:0 max:360
float __s3 =66.12495; //min:0 max:100
float __b3 =65.4977; //min:20 max:100
float __h4 =245.25198; //min:0 max:360
float __s4 =66.12495; //min:0 max:100
float __b4 =65.4977; //min:20 max:100

float __sw1 =2.2898097; //min:2 max:7
float __sw2 =4.739241; //min:2 max:7
float __sw3 =3.8557878; //min:2 max:7
float __sw4 =5; //min:2 max:7

PFont font;


void setup() {
  size(300, 300);

  colorMode(HSB, 360, 100, 100, 200);
  background(0, 0, 5);

  //font = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\inputs\\projects for evomusart\\FINAL SELECTION\\evoproteus_6\\data\\SpaceMono-Regular.ttf", 48);
  //textFont(font);
  blendMode(ADD);

  noFill();
  strokeWeight(__sw1);
  stroke(__h1, __s1, __b1, 200);
  
  bezier(__x1, __y1, __x2, __y2, __x3, __y3, __x4, __y4);
  bezier(__x5, __y5, __x6, __y6, __x7, __y7, __x8, __y8);
  
  strokeWeight(__sw2);
  stroke(__h2, __s2, __b2, 150);

  /*push();
  blendMode(SCREEN);
  textAlign(CENTER);
  fill(255, 120);
  String s = "{Evo}\nDesign\nPoster";
  textLeading(100);
  text(s, width/2 , 60);
  pop();*/

  bezier(__x1, __y1, __x6, __y6, __x3, __y3, __x8, __y8);
  bezier(__x5, __y5, __x2, __y2, __x7, __y7, __x4, __y4);
  
  strokeWeight(__sw3);
  stroke(__h3, __s3, __b3, 100);
  
  bezier(__x2, __y2, __x5, __y5, __x4, __y4, __x6, __y6);
  bezier(__x3, __y3, __x8, __y8, __x2, __y2, __x1, __y1);

  strokeWeight(__sw4);
  stroke(__h4, __s4, __b4, 100);
  
  bezier(__x8, __y8, __x4, __y4, __x1, __y1, __x6, __y6);
  bezier(__x1, __y1, __x3, __y3, __x7, __y7, __x5, __y5);
}

void draw() {
}

void keyPressed() {
  if (key == ' ') {
    save("evoproteus_6.jpg");
  }
}
