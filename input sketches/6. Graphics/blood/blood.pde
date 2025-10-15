/*
 |  EvoProteus sketch [8]
 |  Sketch 'The Silence of the Lambs' by Zaron Chen
 |  Available here: https://openprocessing.org/sketch/2046520
 |  Processing adaptation by Luís Gonçalo and Ricardo Sacadura (November, 2023)
 **/

boolean finish = false;
String [] colors = {"#FF0000", "#FFFF00", "#00FF00", "#00FFFF", "#0000FF", "#000000", "#FFFFFF"};

color bgColor, bloodColor;

int totalFrame = 100;

float lifeStep = 0.05;
float __wOff = 200; //min:10 max:1000
float __hOff = 200; //min:10 max:1000
int __cols = 100; //min:10 max:500
int __rows = 100; //min:10 max:500

float __r1 = 200; //min:0 max:255
float __g1 = 0; //min:0 max:255
float __b1 = 0; //min:0 max:255

float __r2 = 0; //min:0 max:255
float __g2 = 0; //min:0 max:255
float __b2 = 0; //min:0 max:255

float xoff, yoff;

Node[][] nodes;

float __noiseScale = 0.01; //min:0 max:0.3
float __weiRangeMax = 50; //min:0 max:200
float __maxSide = 300; //min:10 max:500

float t;
float weiCtrl;
int counter= 1;

void setup() {

  size(300, 300);

  //float[] tone = {random(225, 255), random(225, 255), random(225, 255)};
  //bgColor = color(tone[0], tone[1], tone[2]);

  background(250);
  bloodColor = color(__r1, __g1, __b1);
  noFill();

  //__noiseScale = random(0.005, 0.01);
  //__weiRangeMax = pow(2, floor(random(3, 9)));
  //__maxSide = max(width, height);

  //__cols = int(random(1, 11)) * 10;

  xoff = (width - __wOff) / __cols;
  yoff = (height - __hOff) / __rows;

  nodes = new Node[__rows][__cols];
  for (int col = 0; col < __cols; col++) {
    for (int row = 0; row < __rows; row++) {
      nodes[row][col] = new Node(col * xoff, row * yoff);
    }
  }

  for (int i = 0; i < 50; i++) {
    drawArtefact();
  }
  
  finish = true;
  print(finish);
  
}

void draw() {
}

void nodeUpdate(DotFunction display) {
  float nz = frameCount * __noiseScale;
  for (int col = 0; col < __cols; col++) {
    for (int row = 0; row < __rows; row++) {
      Node node = nodes[row][col];
      float nx = node.x * __noiseScale;
      float ny = node.y * __noiseScale;
      float dx = noise(nx + 300, ny + 500, nx + ny + nz) * 2 - 1;
      float dy = noise(nx + 100, ny + 300, nx + ny + nz) * 2 - 1;
      int range = int(random(1, random(2, __weiRangeMax)));
      float wei = map(weiCtrl, 0, __maxSide, -range, range) * (1 - t);

      display.display(node, dx, dy * (1 - abs(wei) / range) * 20, wei);
    }
  }
}

void static_dots (Node node, float dx, float dy, float wei) {
  node.mx = node.x + dx * wei * 100 * sin(t);
  node.my = node.y + dy * wei * 210 * sin(t);
  point(node.mx, node.my);
}

void motion_dots(Node node, float dx, float dy, float wei) {
  node.x = node.x + dx * wei;
  node.y = node.y + dy * wei;
  node.life -= lifeStep;
  if (node.life < 0) {
    node.reset();
  }
  point(node.x, node.y);
}


class Node {
  float x, y, mx, my, life;

  Node(float x, float y) {
    this.x = x;
    this.y = y;
    this.mx = x;
    this.my = y;
    this.life = random(3);
  }

  void reset() {
    x = mx;
    y = my;
    life = random(3);
  }
}

interface DotFunction {
  void display(Node node, float dx, float dy, float wei);
}

void drawArtefact() {
  
  t = float(counter) / totalFrame;
  weiCtrl = lerp(noise(t, t) * width, width / 2, t);

  pushMatrix();
  translate((__wOff + xoff) / 2, (__hOff + yoff) / 2);

  color dotColor = lerpColor(color(__r2, __g2, __b2), bloodColor, 0.5 - 0.5 * cos(2 * t));
  dotColor = color(red(dotColor), green(dotColor), blue(dotColor), 50);
  stroke(dotColor);
  nodeUpdate(this::static_dots);
  nodeUpdate(this::motion_dots);
  popMatrix();

  push();
  stroke(bgColor);
  strokeWeight(25);
  rect(0, 0, width, height);
  pop();

  ++counter;
}
