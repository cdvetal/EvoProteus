/*
 Series of computational abstractions of artefacts depicted
 in Armin Hofmann's "Methodik Der Form - Und Bildgestaltung"
 
 No.2 The Dot (From the book, page 55, figures 14 to 18)
 
 Ricardo Sacadura (2024)
 */


int cols = 22, rows = 22;

int __colorX1 = 1; //min:0 max:1
int __colorX2 = 1; //min:0 max:1
int __colorX3 = 0; //min:0 max:1
int __colorX4 = 0; //min:0 max:1
int __colorX5 = 0; //min:0 max:1
int __colorX6 = 0; //min:0 max:1
int __colorX7 = 1; //min:0 max:1
int __colorX8 = 0; //min:0 max:1
int __colorX9 = 0; //min:0 max:1
int __colorX10 = 0; //min:0 max:1
int __colorX11 = 0; //min:0 max:1
int __colorX12 = 0; //min:0 max:1
int __colorX13 = 0; //min:0 max:1
int __colorX14 = 0; //min:0 max:1
int __colorX15 = 0; //min:0 max:1
int __colorX16 = 0; //min:0 max:1
int __colorX17 = 0; //min:0 max:1
int __colorX18 = 0; //min:0 max:1
int __colorX19 = 0; //min:0 max:1
int __colorX20 = 0; //min:0 max:1
int __colorX21 = 0; //min:0 max:1
int __colorX22 = 0; //min:0 max:1



int __colorY1 = 1; //min:0 max:1
int __colorY2 = 1; //min:0 max:1
int __colorY3 = 0; //min:0 max:1
int __colorY4 = 0; //min:0 max:1
int __colorY5 = 0; //min:0 max:1
int __colorY6 = 0; //min:0 max:1
int __colorY7 = 1; //min:0 max:1
int __colorY8 = 0; //min:0 max:1
int __colorY9 = 0; //min:0 max:1
int __colorY10 = 0; //min:0 max:1
int __colorY11 = 0; //min:0 max:1
int __colorY12 = 0; //min:0 max:1
int __colorY13 = 0; //min:0 max:1
int __colorY14 = 0; //min:0 max:1
int __colorY15 = 0; //min:0 max:1
int __colorY16 = 0; //min:0 max:1
int __colorY17 = 0; //min:0 max:1
int __colorY18 = 0; //min:0 max:1
int __colorY19 = 0; //min:0 max:1
int __colorY20 = 0; //min:0 max:1
int __colorY21 = 0; //min:0 max:1
int __colorY22 = 0; //min:0 max:1


float[] colorsX = {
  __colorX1, __colorX2, __colorX3, __colorX4, __colorX5, __colorX6, __colorX7, __colorX8, __colorX9, __colorX10,
  __colorX11, __colorX12, __colorX13, __colorX14, __colorX15, __colorX16, __colorX17, __colorX18, __colorX19, __colorX20,
  __colorX21, __colorX22
};


float[] colorsY = {
  __colorY1, __colorY2, __colorY3, __colorY4, __colorY5, __colorY6, __colorY7, __colorY8, __colorY9, __colorY10,
  __colorY11, __colorY12, __colorY13, __colorY14, __colorY15, __colorY16, __colorY17, __colorY18, __colorY19, __colorY20,
  __colorY21, __colorY22
};



void setup() {

  size(205, 205);
  background(0);
  noStroke();


  float tileX = (width) / cols;
  float tileY = (height) / rows;

  for (int x = 0; x < cols; ++x) {
    for (int y = 0; y < rows; ++y) {
      float sx = tileX * x;
      float sy = tileY * y;
      float sw = tileX;
      float sh = tileY;

      if (x != 0 && x != cols && y !=0 && y != rows) {
        if (x%2 == 0  || y%2 == 0) {
          if (colorsX[int(x)] == 1 && colorsY[int(y)] == 1) {
            fill(255);
          } else {
            fill(0);
          }
        } else {
          fill(255);
        }
      } else {
        fill(0);
      }

      rect(sx, sy, sw, sh, 1);


      /* if (x != cols - 1 && y != rows-1) {
       if (x%2==0 && y%2==0) {
       fill(255);
       } else if (x%2!=0 && y%2==0) {
       if (colorsX[int(x)] == 1) {
       fill(255);
       } else {
       fill(0);
       }
       } else if (y%2!=0 && x%2==0) {
       if (colorsY[int(y)] == 1) {
       fill(255);
       } else {
       fill(0);
       }
       } else if (y%2!=0 && x%2!=0) {
       if (colorsY[int(y)] == 1 && colorsX[int(x)] == 1) {
       fill(255);
       } else {
       fill(0);
       }
       } else {
       fill(0);
       }
       } else {
       fill(0);
       }*/
    }
  }
}

void draw() {
}
