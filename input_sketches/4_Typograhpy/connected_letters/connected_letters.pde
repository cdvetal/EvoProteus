/*
 |  EvoProteus sketch [5]
 |  Sketch 'TypeNet' by Ricardo Sacadura
 |  (November, 2023)
 **/

PFont typer;

float __x1  = 5;   // min:0 max:300
float __y1  = 95;   // min:0 max:300
float __x2  = 25;  // min:0 max:300
float __y2  = 27;  // min:0 max:300
float __x3  = 200; // min:0 max:300
float __y3  = 40;  // min:0 max:300
float __x4  = 10;  // min:0 max:300
float __y4  = 200; // min:0 max:300
float __x5  = 225; // min:0 max:300
float __y5  = 75;   // min:0 max:300
float __x6  = 20;  // min:0 max:300
float __y6  = 98;  // min:0 max:300
float __x7  = 32;  // min:0 max:300
float __y7  = 182;  // min:0 max:300
float __x8  = 123; // min:0 max:300
float __y8  = 241; // min:0 max:300
float __x9  = 19;   // min:0 max:300
float __y9  = 78;  // min:0 max:300
float __x10 = 56;  // min:0 max:300
float __y10 = 300; // min:0 max:300
float __x11 = 125; // min:0 max:300
float __y11 = 167; // min:0 max:300
float __x12 = 34;  // min:0 max:300
float __y12 = 143;  // min:0 max:300
float __x13 = 89;  // min:0 max:300
float __y13 = 234; // min:0 max:300
float __x14 = 156; // min:0 max:300
float __y14 = 81;  // min:0 max:300
float __x15 = 85;  // min:0 max:300
float __y15 = 178; // min:0 max:300

float __randomInc = 0.9; // min:0.1 max:2
float wordProb = 0.4; //min:0 max:1
float __even = 0.8; //min:0 max:6
float __odd = 2.8; //min:0 max:6

String [] art = {"c", "d", "v"};

float [][] pos = {{__x1, __y1}, {__x2, __y2}, {__x3, __y3}, {__x4, __y4},
  {__x5, __y5}, {__x6, __y6}, {__x7, __y7}, {__x8, __y8},
  {__x9, __y9}, {__x10, __y10}, {__x11, __y11}, {__x12, __y12},
  {__x13, __y13}, {__x14, __y14}, {__x15, __y15}
};

void setup() {
  size(300, 300);
  background(250);

  blendMode(MULTIPLY);
  typer = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\input sketches\\4. Typograhpy\\connected_letters\\data\\Courier.ttf", 24);
  createTypeNet();
}

void draw() {
}

void keyPressed() {
  if (key == ' ') {
    save("evoproteus_5.jpg");
  }
}

void createTypeNet() {

  textFont(typer);
  textSize(24);

  fill(40);
  stroke(0);

  int counter = 0;

  for (int i = 0; i < pos.length; ++i) {
    if (random(1) < wordProb) {
      String c = art[int(random(3))];
      text(c, pos[i][0], pos[i][1]);
    }
    ellipse(pos[i][0], pos[i][1], 3, 3);
    ++ counter;
    if (i % 2 == 0) {
      strokeWeight(__even);
    } else {
      strokeWeight(__odd);
    }
    if (counter < pos.length) line(pos[i][0], pos[i][1], pos[i+1][0], pos[i+1][1]);
  }
}
