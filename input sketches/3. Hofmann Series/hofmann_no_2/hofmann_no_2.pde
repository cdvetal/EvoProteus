/*
 Series of computational abstractions of artefacts depicted
 in Armin Hofmann's "Methodik Der Form - Und Bildgestaltung"
 
 No.2 The Line (From the book - figure 163)
 
 Ricardo Sacadura (2024)
 */

int __x1 = 50; //min:0 max:300
int __x2 = 40; //min:0 max:450
int __x3 = 123; //min:0 max:450
int __x4 = 0; //min:0 max:450
int __x5 = 0; //min:0 max:350
int __x6 = 0; //min:0 max:350
int __x7 = 0; //min:0 max:450
int __x8 = 0; //min:0 max:450
int __x9 = 0; //min:0 max:350
int __x10 = 0; //min:0 max:450
int __x11 = 0; //min:0 max:450

int __y1 = 50; //min:0 max:350
int __y2 = 23; //min:0 max:300
int __y3 = 0; //min:0 max:350
int __y4 = 0; //min:0 max:350
int __y5 = 0; //min:0 max:400
int __y6 = 0; //min:0 max:400
int __y7 = 0; //min:0 max:300
int __y8 = 0; //min:0 max:300
int __y9 = 0; //min:0 max:400
int __y10 = 0; //min:0 max:350
int __y11 = 0; //min:0 max:350

float __lw1 = 110; //min:60 max:520
float __lw2 = 240; //min:60 max:520
float __lw3 = 34; //min:60 max:520
float __lw4 = 45; //min:60 max:520
float __lw5 = 0; //min:60 max:520
float __lw6 = 0; //min:60 max:520
float __lw7 = 0; //min:60 max:520
float __lw8 = 0; //min:60 max:520
float __lw9 = 0; //min:60 max:520
float __lw10 = 0; //min:60 max:520
float __lw11 = 0; //min:60 max:520

int __nl1 = 20; //min:5 max:45
int __nl2 = 26; //min:5 max:45
int __nl3 = 26; //min:5 max:45
int __nl4 = 26; //min:5 max:45
int __nl5 = 26; //min:5 max:45
int __nl6 = 26; //min:5 max:45
int __nl7 = 26; //min:5 max:45
int __nl8 = 26; //min:5 max:45
int __nl9 = 26; //min:5 max:45
int __nl10 = 26; //min:5 max:45
int __nl11 = 26; //min:5 max:45

float __sw1 = 0.8; //min:0.8 max:3.5
float __sw2 = 0.5; //min:0.5 max:3.5
float __sw3 = 0.5; //min:0.5 max:3.5
float __sw4 = 1.5; //min:0.5 max:3.5
float __sw5 = 0; //min:0.5 max:4.5
float __sw6 = 0; //min:0.5 max:2.5
float __sw7 = 0; //min:0.5 max:2.5
float __sw8 = 0; //min:0.5 max:4.5
float __sw9 = 0; //min:0.5 max:2.5
float __sw10 = 0; //min:0.5 max:4.5
float __sw11 = 0; //min:0.8 max:2.5


void setup() {

  size(400, 400);
  background(255);
  stroke(0);
  strokeWeight(1);

  //Draws composition skeleton
  drawBase(0, 0, 4, 26, 90, 0, 0);
  drawBase(0, 0, 3, 26, 90, 10, 0);

  //Adds lines
  strokeWeight(__sw1);
  drawLines(__x1, __y1, __lw1, __nl1);
  strokeWeight(__sw2);
  drawLines(__x2, __y2, __lw2, __nl2);
  strokeWeight(__sw3);
  drawLines(__x3, __y3, __lw3, __nl3);
  strokeWeight(__sw4);
  drawLines(__x4, __y4, __lw4, __nl4);
  strokeWeight(__sw5);
  drawLines(__x5, __y5, __lw5, __nl5);
  strokeWeight(__sw6);
  drawLines(__x6, __y6, __lw6, __nl6);
  strokeWeight(__sw7);
  drawLines(__x7, __y7, __lw7, __nl7);
  strokeWeight(__sw8);
  drawLines(__x8, __y8, __lw8, __nl8);
  strokeWeight(__sw9);
  drawLines(__x9, __y9, __lw9, __nl9);
  strokeWeight(__sw10);
  drawLines(__x10, __y10, __lw10, __nl10);
  strokeWeight(__sw11);
  drawLines(__x11, __y11, __lw11, __nl11);
}

void draw() {
}

void drawBase(int xStart, int yStart, int numColumns, int numLines, float lineWidth, float inc, float lineInc) {
  float gap = (width - (lineWidth * numColumns)) / (numColumns - 1);
  float pseudoGap;
  if (gap == 15) {
    pseudoGap = 0;
  } else {
    pseudoGap = gap - 15;
  }

  for (int c= xStart; c < numColumns; ++c) {
    for (int l = yStart; l < numLines; ++l) {
      // first x-coordinate
      float x1 = c * (lineWidth + 15) + pseudoGap;
      // second x-ccordinate
      float x2 = ((c * (lineWidth + 15)) + pseudoGap) + lineWidth + random(lineInc);
      // y-coordinate
      float y = 20 * l + inc;

      line(x1, y, x2, y);
    }
  }
}

void drawLines(float xPos, float yPos, float lineWidth, float numLines) {

  for (int i = 0; i < numLines; ++i) {
    line(xPos, yPos, xPos + lineWidth, yPos);
    yPos += 10;
  }
}
