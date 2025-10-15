/*

 Processing adaptation of '200823' by Sayama (22nd August, 2020)
 https://openprocessing.org/sketch/948311
 CreativeCommons Attribution NonCommercial ShareAlike
 
 Ricardo Sacadura (November, 2023)
 
 **/


float __a = 1.2; //min:0 max:4
float __b = 1.924; //min:0 max:4
float __c = 1.226; //min:0 max:4
float __d = 1.832; //min:0 max:4
float scale;

float __scaleFactor = 0.8; //min:0.5 max:3
float __numPoints = 20000; //min:10000 max:40000

void setup() {
  size(300, 300);
  //background(200);
  scale = min(width, height) / 4 * 0.8;


  background(255);
  strokeWeight(1);
  stroke(0, 0, 200, random(50, 100));
  __a += pow(-1, int(frameCount / 400)) * 0.01;
  __b += pow(-1, int(frameCount / 300)) * 0.001;
  __c += pow(-1, int(frameCount / 600)) * 0.002;
  __d += pow(-1, int(frameCount / 400)) * 0.001;

  float x = 0;
  float y = 0;

  for (int i = 0; i < __numPoints; i++) {
    float nx = sin(__a * y) - cos(__b * x);
    float ny = sin(__c * x) - cos(__d * y);
    point(width/2 + nx * scale, height/2 + ny * scale);
    x = nx;
    y = ny;
  }
}

void draw() {

}
