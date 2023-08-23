/* 
  Fifth Sketch is about bouncy squares
  Name: Bouncy squares
  Created by : Stéfani Diniz
*/

float __x= 150; //min:1 max:300
float __y= 300; //min:1 max:300
float __xSpeed1= 0; //min:0 max:300
float __xSpeed2= 300; //min:0 max:300
float __ySpeed1= 10; //min:0 max:300
float __ySpeed2= 300; //min:1 max:300
int __squareQty= 50; //min:1 max:500
int __bg= 200; //min:0 max:255
int __color1= 255; //min:0 max:255
int __color2= 255; //min:0 max:255
int __color3= 255; //min:0 max:255

void setup() {
  size(300, 300);
}

void draw() {
  background(__bg);
  
  for(int i = 0; i < __squareQty; i++) {
    fill(random(__color1), random(__color2), random(__color3));
    square(); 
  }
}

void square() {
  square(random(__xSpeed1, __xSpeed2), random(__ySpeed1, __ySpeed2), 25);

  __x += random(__xSpeed1, __xSpeed2);
  __y += random(__ySpeed1, __ySpeed2);
  
  if (__x < 0 || __x > width) {
    __xSpeed1 *= -1;
  }

  if (__y < 0  || __y > height) {
    __ySpeed1 *= -1;
  }
}
