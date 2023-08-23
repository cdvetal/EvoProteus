/*
  Eighth Sketch is about letters
  Name: Letters
  Created by : Stéfani Diniz
 */

int __bg= 0; //min:0 max:255
int __color1= 0; //min:0 max:255
int __color2= 0; //min:0 max:255
int __color3= 0; //min:0 max:255
int counter= 36; //min:33 max:382

void setup() {
  size(400, 400);
  background(__bg);
}

void draw() {
  textAlign(CENTER, CENTER);
  textSize(250);
  color a = color(0, 45, 255);
  color b = color(255, 98, 0);
  int x = 200;
  int y = 150;
  
    for (int i = x; i <= x + width; i++) {
      float inter = map(x, 0, x + width, 0, 1);
      color interA = lerpColor(a, b, inter);
      color interB = lerpColor(a, b, inter);
      stroke(interB);
      fill(interA);
    
      char letter = char(counter);
      text(letter, x, y);
    }
}
