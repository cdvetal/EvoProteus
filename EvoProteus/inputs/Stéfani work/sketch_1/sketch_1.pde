/* 
  First Sketch is reference about M13 Star Cluster Constellation 
  Name: Constellations
  Created by : Stéfani Diniz
*/

int __bg1= 16; //min:0 max:255
int __bg2= 16; //min:0 max:255
int __bg3= 16; //min:0 max:255
int __sparklyQty= 200; //min:2 max:5000
int __color1= 255; //min:15 max:255
int __color2= 255; //min:15 max:255
int __color3= 255; //min:15 max:255
int __radius= 200; //min:-100 max:360
int __x= 250; //min:0 max:500
int __y= 250; //min:0 max:500

void setup() {
  size(500, 500, P3D);
  background(__bg1, __bg2, __bg3);
}

void draw() {
  shapeMode(CENTER);
  noStroke();
  lights();
  ambientLight(102, 102, 126);
  fill(__color1, __color2, __color3);
  
  star(__x, __y, __radius, __sparklyQty);
}

void star(int x, int y, float radius, int sparklyQty) {
  float delta = 2 * PI / sparklyQty;
  float idelta = delta / 2;
  float iRadius = radius / 2;
  float theta = 0.0;

  beginShape();
  for (float i = 0; i < sparklyQty; i++ ) {
    vertex(x + radius * cos(theta), y + radius * sin(theta));
    vertex(x + iRadius * cos(theta + idelta), y + iRadius * sin(theta + idelta));
    theta += delta;
  }
  endShape(CLOSE);
}
