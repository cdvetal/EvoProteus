float __x = 150; //min:0 max:200
float __y = 53; //min:0 max:200
float __width = 100; //min:70 max:200
float __height = 100; //min:70 max:200

float __r = 128; //min:1 max:255
float __g = 128; //min:1 max:255
float __b = 128; //min:1 max:255


void setup() {
  size(300, 300);
  background(255);
  pixelDensity(2);

  rectMode(CENTER);

  fill(__r, __g, __b);
  rect(__x, __y, __width, __height); //--> Building
}

void draw() {
  
}
