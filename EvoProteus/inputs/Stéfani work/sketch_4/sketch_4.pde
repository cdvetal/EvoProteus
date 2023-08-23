/* 
  Third Sketch is reference about clutter
  Name: Disorder of objects
  Created by : Stéfani Diniz
*/

int __bg1= 0; //min:0 max:255
int __bg2= 17; //min:0 max:255
int __bg3= 70; //min:0 max:255
int __color1= 80; //min:15 max:255
int __color2= 17; //min:15 max:255
int __color3= 100; //min:15 max:255
int __numberOfItens= 10;  //min:5 max:60
float __itemSize= 20;  //min:2 max:50

void setup() {
 size(500, 500);
 background(__bg1, __bg2, __bg3);
}

void draw() {
 noStroke();
 for(int i = 0; i < __numberOfItens; i++) {
   forms();
 }
}

void forms() {
  fill(__color1, __color2, __color3);
  square(mouseX, mouseY, __itemSize);
  fill(__color1 * 4, __color2, __color3);
  circle(mouseX, mouseY * 3, __itemSize);
  fill(__color1, __color2, __color3 * 3);
  rect(mouseX, mouseY * 4, __itemSize, __itemSize - 5);
}
