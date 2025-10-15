float __h1 = 255; // min:0 max:360
float __s1 = 23; // min:0 max:100
float __b1 = 40; // min:0 max:100

float __h2 = 10; // min:0 max:360
float __s2 = 100; // min:0 max:100
float __b2 = 100; // min:0 max:100

float __h3 = 100; // min:0 max:360
float __s3 = 200; // min:0 max:100
float __b3 = 200; // min:0 max:100

float __h4 = 0; // min:0 max:360
float __s4 = 50; // min:0 max:100
float __b4 = 0; // min:0 max:100

color c1, c2, c3, c4;

float __xpos1 = 40; //min:25 max:150
float __ypos1 = 20; //min:25 max:150
float __xpos2 = 24; //min:25 max:150
float __ypos2 = 25; //min:25 max:150

void setup() {
  
  size(300, 300);
  pixelDensity(2);
  colorMode(HSB, 360, 100, 100);

  c1 = color(__h1, __s1, __b1);
  c2 = color(__h2, __s2, __b2);
  c3 = color(__h3, __s3, __b3);
  c4 = color(__h4, __s4, __b4);
}

void draw() {
  
  background(#fdfdfd);
  setGradient(width/2 - 80, 30, 150, 200, c1, c2);
  setGradient(width/2 - 55, 50, 150, 200, c3, c4);
}

void setGradient(float x, float y, float w, float h, color c1, color c2) {

  noFill();
  for (int i = int(y); i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c, 200);
    line(x, i, x+w, i);
  }
}
