/**
 * Functions.
 *
 * The drawTarget() function makes it easy to draw many distinct targets.
 * Each call to drawTarget() specifies the position, __size, and number of
 * rings for each target.
 */

boolean bg= true; //min:0 max:1
float h= 200; //min:0 max:360
float s = 40; //min:0 max:100
float b = 80; //min:0 max:100
float __op = 100; //min:0 max:100

int num_circles= 2; //min:1 max:6
int num_min= 4; //min:2 max:10
int num_max= 20; //min:10 max:30

float __pos= 0.25; //min:0.1 max:0.4
float __size= 100; //min:20 max:200

void setup() {
  size(300, 200);

  if (bg)   background(0);
  if (bg ==false) background(255);

  colorMode(HSB, 360, 100, 100);
  noStroke();


  for (int i = 0; i < num_circles; i++) {
    drawTarget(width * __pos * i, height * random(1), __size, int(random(num_min, num_max)));
  }
}

void draw() {
}

void drawTarget(float xloc, float yloc, float __size, int num) {
  float steps = __size/num;
  for (int i = 0; i < num; i++) {
    fill(h+(5*i), s+(5*i), b+(5*i), __op);
    ellipse(xloc, yloc, __size - i*steps, __size - i*steps);
  }
}
