
/**
 * Bouncy Bubbles
 * based on code from Keith Peters.
 *
 * Multiple-object collision.
 */

int __c1 = 250;//min:0 max:255
int __c2 = 150;  //min:0 max:255
int __c3= 0; //min:0 max:255

boolean __teste = true; //min:true max:false



int __numBalls = 12;// min:0 max:25
int __diameter =30; //min:10 max:80
float spring = 0.05;
float __gravity = 0.03; //min:0.01 max:0.05
float friction = -0.9;
Ball[] balls = new Ball[__numBalls];

void setup() {

  size(440, 160);

  float __debugSetup = 50; //min:10 max:100
  for (int i = 0; i < __numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), __diameter, i, balls);
  }
  noStroke();
  fill(__c1, __c2, __c3);
}

void draw() {
  background(__c2, __c3, __c1);
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
}

class Ball {

  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
  float __debugDraw = 50; //min:10 max:100

  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  }

  void collide() {
    for (int i = id + 1; i < __numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) {
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }
  }

  void move() {
    vy += __gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    } else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction;
    } else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }

  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
