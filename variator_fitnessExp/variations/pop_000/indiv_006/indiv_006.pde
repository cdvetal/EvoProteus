/**
 * Functions.
 *
 * The drawTarget() function makes it easy to draw many distinct targets.
 * Each call to drawTarget() specifies the position, size, and number of
 * rings for each target.
 */

boolean __bg=true; //min:0 max:1
float __h=329.96716; //min:0 max:360
float __s =35.515404; //min:0 max:100
float __b =18.911625; //min:0 max:100
float __op =83.68681; //min:0 max:100

int __num_circles=1; //min:1 max:6
int __num_min=10; //min:2 max:10
int __num_max=21; //min:10 max:30

float __pos=0.18709566; //min:0.1 max:0.4
float __size=41.68403; //min:20 max:200

void setup() {
clientSketches = new Client(this, "localhost", 3000 + 6);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,538);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");//Injected line
  size(300, 200);

  if (__bg)   background(0);
  if (__bg ==false) background(255);

  colorMode(HSB, 360, 100, 100);
  noStroke();


  for (int i = 0; i < __num_circles; i++) {
    drawTarget(width * __pos * i, height * random(1), __size, int(random(__num_min, __num_max)));
  }
}

void draw() {
java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y);if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}//Injected line
}

void drawTarget(float xloc, float yloc, float size, int num) {
  float steps = size/num;
  for (int i = 0; i < num; i++) {
    fill(__h+(5*i), __s+(5*i), __b+(5*i), __op);
    ellipse(xloc, yloc, size - i*steps, size - i*steps);
  }
}
import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit() { windowOpen = false; thread("exitDelay");}boolean windowOpen = true;void exitDelay(){delay(1500); System.exit(0);}String input; int exitValue;final String sketch = getClass().getName();int pid;String pidT;//Injected line
