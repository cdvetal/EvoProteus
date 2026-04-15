/**
 'Bauhaus Generative Logo'
 Created by Ricardo Sacadura
 */

float x1 = 150;
float __x2 = 180; //min:0 max:200
float __x3 = 75; //min:0 max:150
float __x4 = 70; //min:0 max:100
float __y1 = 150; //min:0 max:200
float __y2 = 53; //min:0 max:200
float __y3 = 215; //min:0 max:300
float __y4 = 285; //min:50 max:300
float __width1 = 160; //min:70 max:200
float __width2 = 75; //min:10 max:130
float __width3 = 60; //min:10 max:100
float __height1 = 250; //min:120 max:300
float __height2 = 30; //min:5 max:60
float   height3 = 5;

float __inc = 65; //min:20 max:100


void setup() {

  size(300, 300);
  background(255);
  //pixelDensity(2);

  rectMode(CENTER);
  strokeWeight(3);
  stroke(0);

  rect(x1, __y1, __width1, __height1); //--> Building
  
  fill(0);
  for (int i = 0; i < 4; ++i) {
    rect(__x2, __y2, __width2, __height2); //--> Windows
    __y2 += __inc;
  }
  rect(__x3, __y3, __width3, height3); //--> Awning
  strokeWeight(2);
  line(__x4, __y4, __x4 + __width1, __y4);
}

void draw() {
}
