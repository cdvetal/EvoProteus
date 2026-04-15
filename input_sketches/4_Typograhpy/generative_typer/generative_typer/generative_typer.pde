/*
Generative typer
 Created by Ricardo Sacadura
 **/

PFont typer;

int cols = 25;
int rows = 25;

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
float __x16 = 14;  // min:0 max:300
float __y16 = 146;  // min:0 max:300
float __x17 = 190; // min:0 max:300
float __y17 = 62;  // min:0 max:300
float __x18 = 56;  // min:0 max:300
float __y18 = 90;  // min:0 max:300
float __x19 = 220; // min:0 max:300
float __y19 = 50;  // min:0 max:300
float __x20 = 12;  // min:0 max:300
float __y20 = 65;  // min:0 max:300
float __x21 = 34;  // min:0 max:300
float __y21 = 129; // min:0 max:300
float __x22 = 198; // min:0 max:300
float __y22 = 234; // min:0 max:300
float __x23 = 81;  // min:0 max:300
float __y23 = 43;   // min:0 max:300
float __x24 = 16;  // min:0 max:300
float __y24 = 29;  // min:0 max:300
float __x25 = 269; // min:0 max:300
float __y25 = 209;   // min:0 max:300
float __x26  = 5;   // min:0 max:300
float __y26  = 95;   // min:0 max:300
float __x27  = 25;  // min:0 max:300
float __y27 = 27;  // min:0 max:300
float __x28 = 200; // min:0 max:300
float __y28 = 40;  // min:0 max:300
float __x29 = 10;  // min:0 max:300
float __y29 = 200; // min:0 max:300
float __x30 = 225; // min:0 max:300
float __y30 = 75;   // min:0 max:300
float __x31 = 20;  // min:0 max:300
float __y31 = 98;  // min:0 max:300
float __x32 = 32;  // min:0 max:300
float __y32 = 182;  // min:0 max:300
float __x33 = 123; // min:0 max:300
float __y33 = 241; // min:0 max:300
float __x34 = 19;   // min:0 max:300
float __y34 = 78;  // min:0 max:300
float __x35 = 56;  // min:0 max:300
float __y35 = 300; // min:0 max:300
float __x36 = 125; // min:0 max:300
float __y36 = 167; // min:0 max:300
float __x37 = 34;  // min:0 max:300
float __y37 = 143;  // min:0 max:300
float __x38 = 89;  // min:0 max:300
float __y38 = 234; // min:0 max:300
float __x39 = 156; // min:0 max:300
float __y39 = 81;  // min:0 max:300
float __x40 = 85;  // min:0 max:300
float __y40 = 178; // min:0 max:300
float __x41 = 14;  // min:0 max:300
float __y41 = 146;  // min:0 max:300
float __x42 = 190; // min:0 max:300
float __y42 = 62;  // min:0 max:300
float __x43 = 56;  // min:0 max:300
float __y43 = 90;  // min:0 max:300
float __x44 = 220; // min:0 max:300
float __y44 = 50;  // min:0 max:300
float __x45 = 12;  // min:0 max:300
float __y45 = 65;  // min:0 max:300
float __x46 = 34;  // min:0 max:300
float __y46 = 129; // min:0 max:300
float __x47 = 198; // min:0 max:300
float __y47 = 234; // min:0 max:300
float __x48 = 81;  // min:0 max:300
float __y48 = 43;   // min:0 max:300
float __x49 = 16;  // min:0 max:300
float __y49 = 29;  // min:0 max:300
float __x50 = 269; // min:0 max:300
float __y50 = 209;   // min:0 max:300

float __randomInc = 0.9; // min:0.1 max:2

char [] art = {'a', 'r', 't', 's'};

float [][] pos = {{__x1, __y1}, {__x2, __y2}, {__x3, __y3}, {__x4, __y4},
  {__x5, __y5}, {__x6, __y6}, {__x7, __y7}, {__x8, __y8},
  {__x9, __y9}, {__x10, __y10}, {__x11, __y11}, {__x12, __y12},
  {__x13, __y13}, {__x14, __y14}, {__x15, __y15}, {__x16, __y16},
  {__x17, __y17}, {__x18, __y18}, {__x19, __y19}, {__x20, __y20},
  {__x21, __y21}, {__x22, __y22}, {__x23, __y23}, {__x24, __y25},
  {__x25, __y25}
};

float [][] pos2 = {{__x26, __y26}, {__x27, __y27}, {__x28, __y28}, {__x29, __y29},
  {__x30, __y30}, {__x31, __y31}, {__x32, __y32}, {__x33, __y33},
  {__x34, __y34}, {__x35, __y35}, {__x36, __y36}, {__x37, __y37},
  {__x38, __y38}, {__x39, __y39}, {__x40, __y40}, {__x41, __y41},
  {__x42, __y42}, {__x43, __y43}, {__x44, __y44}, {__x45, __y45},
  {__x46, __y46}, {__x47, __y47}, {__x48, __y48}, {__x49, __y49},
  {__x50, __y50}
};

void setup() {
  size(300, 300);
  background(0);
  typer = createFont("Courier.ttf", 24);

  blendMode(SCREEN);
  textFont(typer);
  textSize(20);
  fill(255);
  for (int i = 0; i < pos.length; ++i) {
    char c = art[int(random(4))];
    text(c, pos[i][0], pos[i][1]);
    char c2 = art[int(random(4))];
    text(c2, pos2[i][0], pos2[i][1]);
  }
}

void draw() {
}
