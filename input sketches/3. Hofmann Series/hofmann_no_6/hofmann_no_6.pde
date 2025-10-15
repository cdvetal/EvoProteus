/*
 Series of computational abstractions of artefacts depicted
 in Armin Hofmann's "Methodik Der Form - Und Bildgestaltung"
 
 No.6 Letters and Signs (From the book - figure 263)
 
 Ricardo Sacadura (2024)
 */

// Black squares
float __x1 = 5;   //min:1 max:10
float __y1 = 154; //min:130 max:180
float __w1 = 66;  //min:33 max:99
float __h1 = 241; //min:200 max:260

float __x2 = 48;  //min:1 max:57
float __y2 = 164; //min:130 max:180
float __w2 = 64;  //min:33 max:99
float __h2 = 78;  //min:200 max:260

float __x3 = 5;   //min:1 max:10
float __y3 = 64;  //min:10 max:114
float __w3 = 83;  //min:33 max:99
float __h3 = 106; //min:80 max:140

float __x4 = 84;  //min:10 max:94
float __y4 = 64;  //min:10 max:114
float __w4 = 28;  //min:20 max:99
float __h4 = 41;  //min:30 max:130

float __x5 = 113; //min:10 max:113
float __y5 = 24;  //min:10 max:134
float __w5 = 99;  //min:20 max:200
float __h5 = 218; //min:160 max:260

float __x6 = 113; //min:10 max:113
float __y6 = 213; //min:100 max:270
float __w6 = 84;  //min:20 max:130
float __h6 = 183; //min:120 max:280

float __x7 = 190; //min:10 max:300
float __y7 = 104; //min:90 max:200
float __w7 = 63;  //min:20 max:130
float __h7 = 190; //min:130 max:240

float __x8 = 252; //min:20 max:290
float __y8 = 104; //min:80 max:140
float __w8 = 27;  //min:10 max:80
float __h8 = 141; //min:110 max:160

float __x9 = 280; //min:40 max:290
float __y9 = 5;   //min:0 max:110
float __w9 = 68;  //min:40 max:200
float __h9 = 390; //min:200 max:490

float __x10 = 336; //min:50 max:400
float __y10 = 5;   //min:0 max:100
float __w10 = 58;  //min:20 max:90
float __h10 = 76;  //min:40 max:120

float __x11 = 345; //min:60 max:410
float __y11 = 120; //min:80 max:190
float __w11 = 48;  //min:20 max:80
float __h11 = 107; //min:80 max:160

// White squares

float __x12 = 258; //min:50 max:280
float __y12 = 143; //min:130 max:180
float __w12 = 21;  //min:10 max:50
float __h12 = 21;  //min:10 max:50

float __x13 = 153; //min:50 max:220
float __y13 = 156; //min:130 max:180
float __w13 = 50;  //min:33 max:99
float __h13 = 50;  //min:33 max:99



void setup() {
  size(400, 400);
}

void draw() {
  background(255);
  fill(0);
  stroke(0);

  // Black squares
  fill(0);
  stroke(0);
  // 1
  rect(__x1, __y1, __w1, __h1);
  // 2
  rect(__x2, __y2, __w2, __h2);
  // 3
  rect(__x3, __y3, __w3, __h3);
  // 4
  rect(__x4, __y4, __w4, __h4);
  // 5
  rect(__x5, __y5, __w5, __h5);
  // 6
  rect(__x6, __y6, __w6, __h6);
  // 7
  rect(__x7, __y7, __w7, __h7);
  // 8
  rect(__x8, __y8, __w8, __h8);
  // 9
  rect(__x9, __y9, __w9, __h9);
  // 10
  rect(__x10, __y10, __w10, __h10);
  // 11
  rect(__x11, __y11, __w11, __h11);

  // White squares
  fill(255);
  stroke(255);
  // 12
  rect(__x12, __y12, __w12, __h12);
  // 13
  rect(__x13, __y13, __w13, __h13);
}
