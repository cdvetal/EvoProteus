/*
  Seventh Sketch is reference about terrestrial surface
  Name: Relief
  Created by : Stéfani Diniz
*/

int __bg= 109; //min:0 max:255
int __squareQty= 100; //min:0 max:50
int __color1= 150; //min:0 max:255
int __color2= 75; //min:0 max:255
int __color3= 0; //min:0 max:255
int __strokeColor= 100; //min:0 max:255
int __curveX= 100; //min:10 max:700
int __curveY= 200; //min:10 max:900

void setup() {
  size(900, 900, P3D);
  background(__bg);
}

void draw() {  
  float t = map(mouseX, mouseY, width, -5, 5);
  curveTightness(t);
  fill(__color1, __color2, __color3);
  stroke(__strokeColor);
    
  beginShape();
    curveVertex(__curveX * 3, __curveY * 4.25);
    curveVertex(__curveX * 2, __curveY * 3);
    curveVertex(__curveX, __curveY * 2);
    curveVertex(__curveX * 5, __curveY * 2);
    curveVertex(__curveX * 6, __curveY * 2.5); 
    curveVertex(__curveX * 7, __curveY * 1.5);
  endShape();
}
