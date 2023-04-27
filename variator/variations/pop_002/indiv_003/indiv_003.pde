
/**
 * Bouncy Bubbles
 * based on code from Keith Peters.
 *
 * Multiple-object collision.
 */

int __c1 =79; // min:0 max:255
int __c2 =255; // min:0 max:255
int __c3 =117; //min:0 max:255

boolean __teste =true; //min:true max:false



int __numBalls =13; // min:0 max:25
int __diameter =67; // min:10 max:80
float __spring =NaN;
float __gravity =0.03731861; // min:0.01 max:0.05
float __friction =NaN;
Ball[] balls = new Ball[__numBalls];

void setup() {
surface.setLocation(23,252);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");v_m = new Client(this, "localhost", 3000 + 3);//variator

  size(440, 160);

  for (int i = 0; i < __numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), __diameter, i, balls);
  }
  noStroke();
  fill(__c1, __c2, __c3);
}

void draw() {
final String sketch = getClass().getName();java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}v_m.write(sketch + " " + listener + " ");if (v_m.available() > 0) {input = v_m.readString(); exitValue = int(input); if (exitValue == 2) exit();}//variator
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
        float ax = (targetX - others[i].x) * __spring;
        float ay = (targetY - others[i].y) * __spring;
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
      vx *= __friction;
    } else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= __friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= __friction;
    } else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= __friction;
    }
  }

  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client v_m;int listener = 0;void exit() { windowOpen = false; thread("exitDelay");}boolean windowOpen = true;void exitDelay(){delay(1500); System.exit(0);}String input; int exitValue;//Injected line
