/*
  Sixth Sketch is reference about sound waves
  Name: Sound waves
  Created by : Stéfani Diniz
*/

int __bg= 0; //min:0 max:255
int __color= 255; //min:0 max:255
float __x= 50; //min:50 max:100
float __y1= 100; //min:0 max:350
float __y2= 300; //min:0 max:600
float __numberOfTrackers= 23; //min:1 max:23
float __strokeWeight= 10; //min:1 max:10

void setup() {
  size(1200, 700);
  background(__bg);
  strokeWeight(__strokeWeight);
}

void draw() {
  stroke(__color);
  float x1, y1, y2;
  for(int i = 1; i <= __numberOfTrackers; i++) {
    x1 = __x * i;  
    y2 = __y2 + x1;
    y1 = __y1 * y2;  
    
    if(y1 >= 350) {
      y1 = y1 / x1;
    }
    else if (y2 >= 600) {
      y2 = y2 / 2;
    }
    createSoundtracker(x1, y1, x1, y2);
    System.out.println(y1);
  }
}

void createSoundtracker(float __x1, float __y1, float __x2, float __y2) {
  line(__x1, __y1, __x2, __y2);
}
