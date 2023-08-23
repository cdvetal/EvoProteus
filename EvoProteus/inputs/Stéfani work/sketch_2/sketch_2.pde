/*
  Second Sketch is reference about soup of Cantina of University of Coimbra
  Name: Soup
  Created by : Stéfani Diniz
*/

int __bg1= 17; //min:0 max:255
int __bg2= 50; //min:0 max:255
int __bg3= 70; //min:0 max:255
int __color1= 255; //min:15 max:255
int __color2= 165; //min:15 max:255
int __color3= 0; //min:15 max:255
int __color4= 128; //min:0 max:255
int __color5= 128; //min:0 max:255
float __rectQty= 50; //min:1 max:50

void setup() {
  size(500, 500, P3D);
  background(__bg1, __bg2, __bg3);
}

void draw() {
  noStroke();
  smooth();
  lights();
  ambientLight(102, 102, 200);
  fill(255);
  
  circle(250, 250, 450);
  
  fill(__color1, __color2, __color3);
  circle(250, 250, 400);
  float x, y;
  
  for(int i = 0; i < __rectQty; i++) {
    x = random(110, 380);
    y = random(110, 380);
    vegetables(x, y);
  }
  delay(1000);
}

void vegetables(float x, float y) {
  fill(0, __color4, 0);
  rect(x, y, 10, 30);
  fill(__color5, 0, 0);
  ellipse(y, x, 10, 10);
}
