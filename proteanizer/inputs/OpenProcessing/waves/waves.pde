/**
 Input sketch 04
 
 This code is a processing-java version of Teng Robin's "Waves" (November 18th 2018)
 Available here: https://openprocessing.org/sketch/1744608
 */

int __nmobiles = 4000; // min:1000 max:20000
Mobile[] mobiles;

float __noisescale = 0.08; // min:0.05 max:0.1

float a1, a2, a3, a4, a5;
float __amax = 2; // min:0.5 max:3
int __colorMin = 50; // min:0 max:50
int __colorMax = 360; // min:50 max:360

void setup() {
  size(800, 800);
  background(0);
  noFill();
  colorMode(HSB, 360, 255, 255, 255);
  strokeWeight(0.1);
  reset();
}

void reset() {
  noiseDetail(int(random(1, 5)));
  a1 = random(1, __amax);
  a2 = random(1, __amax);
  a3 = random(1, __amax);
  a4 = random(1, __amax);
  a5 = 10;
  mobiles = new Mobile[__nmobiles];
  for (int i = 0; i < __nmobiles; i++) {
    mobiles[i] = new Mobile(i);
  }
}

void draw() {
  for (int i = 0; i < __nmobiles; i++) {
    mobiles[i].run();
  }
}

class Mobile {
  int index;
  PVector velocity;
  PVector acceleration;
  PVector position0;
  PVector position;
  float trans;
  float hu;
  float sat;
  float bri;

  Mobile(int index) {
    this.index = index;
    this.velocity = new PVector(200, 200, 200);
    this.acceleration = new PVector(200, 200, 200);
    this.position0 = new PVector(random(0, width), random(0, height), random(0, sin(height)));
    this.position = this.position0.copy();
    this.trans = random(__colorMin, __colorMax);
    this.hu = (noise(a1*cos(PI*this.position.x/width), a1*sin(PI*this.position.y/height)) * 720) % random(360);
    this.sat = noise(a2*sin(PI*this.position.x/width), a2*sin(PI*this.position.y/height)) * 255;
    this.bri = noise(a3*cos(PI*this.position.x/width), a3*cos(PI*this.position.y/height)) * 255;
  }

  void run() {
    update();
    display();
  }

  void update() {
    this.velocity.set(1 - 2 * noise(a4 + a2 * sin(TWO_PI * this.position.x / width),
      a4 + a2 * sin(TWO_PI * this.position.y / height)),
      1 - 2 * noise(a2 + a3 * cos(TWO_PI * this.position.x / width),
      a4 + a3 * cos(TWO_PI * this.position.y / height)));
    this.velocity.mult(a5);
    this.velocity.rotate(sin(100) * noise(a4 + a3 * sin(TWO_PI * this.position.x / width)));
    this.position0 = this.position.copy();
    this.position.add(this.velocity);
  }

  void display() {
    
    stroke((frameCount * 1.8) % this.trans, millis() % this.trans, frameCount % this.trans, this.trans % 255);
    line(this.position0.x, this.position0.y, this.position.x, this.position.y);

    if (this.position.x > width || this.position.x < 0 || this.position.y > height || this.position.y < 0) {
      this.position0 = new PVector(random(0, width), random(0, height), random(0, height*width));
      this.position = this.position0.copy();
    }
  }
}
