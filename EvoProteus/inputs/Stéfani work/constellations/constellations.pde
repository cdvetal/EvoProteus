/*
 First Sketch is reference about M13 Star Cluster Constellation
 Name: Constellations
 Created by : Stéfani Diniz
 */

int __bg1= 16; //min:0 max:360
int __bg2= 16; //min:0 max:360
int __bg3= 16; //min:0 max:100
int __sparklyQty= 200; //min:2 max:300
int __color1= 255; //min:15 max:360
int __color2= 255; //min:15 max:360
int __color3= 255; //min:15 max:360
int __transp = 100; //min:0 max:100
int __radius= 100; //min:20 max:300
int __x= 150; //min:0 max:300
int __y= 150; //min:0 max:300

int x2, y2;
float radius2;

void setup() {
  size(300, 300);
  colorMode(HSB);
  background(__bg1, __bg2, __bg3);

  x2 = int(random(__x));
  y2 = int(random(__y/2));
  radius2 = random(__radius*0.7);
}

void draw() {
  shapeMode(CENTER);
  noStroke();
  fill(__color1, __color2, __color3, __transp);

  star(__x, __y, __radius, __sparklyQty);
  star(x2, y2, radius2, __sparklyQty);
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
