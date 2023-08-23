/*
  Eighth Sketch is about morse code
  Name: Morse Code
  Created by : Stéfani Diniz
 */
 
 int __bg= 0; //min:0 max:255
 int __lineColor1= 255; //min:0 max:255
 int __lineColor2= 255; //min:0 max:255
 int __lineColor3= 255; //min:0 max:255
 int __pointColor1= 255; //min:0 max:255
 int __pointColor2= 255; //min:0 max:255
 int __pointColor3= 255; //min:0 max:255
 int __pointQty= 700; //min:1 max:422500

void setup() {
  size(700, 700);
  background(__bg);
}

void draw() {
  int margin = 7;
  translate(margin * 3, margin * 3);

  int gap = 46;
  
  for (int y = 0; y < height - gap; y += gap) {
    for (int x = 0; x < width - gap; x += gap) {
        
        stroke(__pointColor1, __pointColor2, __pointColor3);
        point(x - 15, y);
        
        stroke(__lineColor1, __lineColor2, __lineColor3);
        line(x, y, x + 5, y);  
        
        stroke(__pointColor1, __pointColor2, __pointColor3);
        point(x + 15, y);
      
    }
  }  
}
