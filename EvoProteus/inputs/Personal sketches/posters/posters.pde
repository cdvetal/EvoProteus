float __r1 = 255; // min:0 max:255
float __g1 = 23; // min:0 max:255
float __b1 = 40; // min:0 max:255

float __r2 = 10; // min:0 max:255
float __g2 = 100; // min:0 max:255
float __b2 = 100; // min:0 max:255

float __r3 = 100; // min:0 max:255
float __g3 = 200; // min:0 max:255
float __b3 = 200; // min:0 max:255

float __r4 = 0; // min:0 max:255
float __g4 = 50; // min:0 max:255
float __b4 = 0; // min:0 max:255

color c1, c2, c3, c4;

float __xpos1 = 40; //min:0 max:300
float __ypos1 = 20; //min:0 max:300
float __xpos2 = 0; //min:0 max:300
float __ypos2 = 0; //min:0 max:300

void setup() {
  
  size(300, 300);

  c1 = color(__r1, __g1, __b1);
  c2 = color(__r2, __g2, __b2);
  c3 = color(__r3, __g3, __b3);
  c4 = color(__r4, __g4, __b4);
}

void draw() {
  
  background(230);
  setGradient(__xpos1, __ypos1, 120, 160, c1, c2);
  setGradient(__xpos2, __ypos2, 120, 160, c3, c4);
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
