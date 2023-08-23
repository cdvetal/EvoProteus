/*
  Eleventh Sketch is reference about rainbow
  Name: Colored lines
  Created by : Stéfani Diniz
*/

 int __bg= 0; //min:0 max:255
 int __lineColor1= 155; //min:0 max:255
 int __lineColor2= 156; //min:0 max:255
 int __lineColor3= 0; //min:0 max:255
 int __gap= 46; //min:1 max:300

void setup() {
  size(640, 580);
  background(__bg);
}

void draw() {  
  int margin = 10;
  translate(margin * 4, margin);
  
  for (int y = 0; y < height - __gap; y += __gap) {
    for (int x = 0; x < width - __gap; x += __gap) {
        stroke(__lineColor1 - y, __lineColor2 - x, __lineColor3 + __gap);
        line(x, y, y, x); 
    }
  }  
}
