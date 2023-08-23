/* 
  Third Sketch is reference about jellyfish moviment
  Name: Jellyfish bouncy
  Created by : Stéfani Diniz
*/

float __arcQty= 30; //min:1 max:30
float __x= 400; //min:0 max:400
float __y= 400; //min:0 max:400
int __strokeColor= 255; //min:0 max:255
int __bg1= 13; //min:0 max:255
int __bg2= 33; //min:0 max:255
int __bg3= 79; //min:0 max:255


void setup() {
 size(400, 400);
}

void draw() {
  background(__bg1, __bg2, __bg3);
  stroke(255);
  for(int i = 0; i < __arcQty; i++) {
    float x = random(__x);
    float y = random(__y);
    createArc(x, y);
  }
  delay(1000);
}

void createArc(float __x, float __y) {
  noFill();
  arc(__x, __y, 50, 50, 0, HALF_PI);
  arc(__x, __y, 60, 60, HALF_PI, PI);
  arc(__x, __y, 70, 70, PI, PI + QUARTER_PI);
  arc(__x, __y, 80, 80, PI + QUARTER_PI, TWO_PI);
}
