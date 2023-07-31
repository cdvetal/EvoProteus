float theta = 0;
float __xNoise = 1; //min:1 max:20
float __yNoise = 2; //min:1 max:20
float __xMove = 100; //min:0 max:100
float __yMove = 100; //min:0 max:100
float scaler = 1;

float __minScale = 25; //min:10 max:50
float __maxScale = 200; //min:50 max:300
float __decrement = 0.006; //min:0.0001 max:0.01
float __colorFill = 0; //min:0 max:150
float __colorStroke = 255; //min:100 max:255

void setup() {
  size(300, 300);
  background(0);
}

void draw() {
  if (scaler > 0) {
    fill(__colorFill, 100);
    stroke(__colorStroke);
    push();
    __xMove += 0.001;
    __yMove += 0.001;
    float xMover = map(noise(__xMove, frameCount / 1000.0), 0, 1, -width / 3, width / 3);
    float yMover = map(noise(__yMove, frameCount / 1000.0), 0, 1, -height / 3, height / 3);
    translate(width / 2 + xMover, height / 2 + yMover);
    beginShape();
    scale(scaler);
    for (float i = 0; i <= TWO_PI; i += TWO_PI / 100) {
      float x = cos(i) * value(__xNoise, i);
      float y = sin(i) * value(__yNoise, i);
      curveVertex(x, y);
    }
    endShape(CLOSE);
    pop();
    //scaler -= 0.0004;
    scaler -= __decrement;
  }
}

float value(float diameter, float theta) {
  float xoff = map(cos(theta), -1, 1, 0, diameter);
  float yoff = map(sin(theta), -1, 1, 0, diameter);
  float r = noise(xoff, yoff, frameCount / 100.0);
  return map(r, 0, 1, __minScale, __maxScale);
}
