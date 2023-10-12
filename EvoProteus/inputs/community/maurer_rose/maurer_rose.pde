/**
  'Maurer Rose' -> (adapted from p5.js to processing)
  Created by Stefan Nicov
  Available here: https://openprocessing.org/sketch/1673672
*/

int d;
int n;

float __x = 60; //min:30 max:300
float __y = 60; //min:30 max:300

float __hue = 150; //min:0 max:360
float __sat = 200; //min:0 max:360

void setup() {
  size(300, 300);
  colorMode(HSB);
}

void draw() {
  background(0);
 
  d = (int)(180 * __x / width);
  n = (int)(10 * __y / height);
  
  translate(width/2, height/2);
  stroke(255);
  noFill();
  
  beginShape();
  strokeWeight(1);
  for (int i = 0; i < 361; i++) {
    float k = i * d;
    float r = 150 * sin(degrees(n*k));
    float x = r * cos(degrees(k));
    float y = r * sin(degrees(k));
    vertex(x, y);    
  }
  endShape();
  
  noFill();
  stroke(__hue, __sat, 100, 100);
  strokeWeight(4);
  beginShape();
  for (int i = 0; i < 361; i++) {
    float k = i;
    float r = 150 * sin(degrees(n*k));
    float x = r * cos(degrees(k));
    float y = r * sin(degrees(k));
    vertex(x, y);    
  }
  endShape();
}
