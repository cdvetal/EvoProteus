/**
 * Functions.
 *
 * The drawTarget() function makes it easy to draw many distinct targets.
 * Each call to drawTarget() specifies the position, size, and number of
 * rings for each target.
 */

boolean __bg=true; //min:0 max:1
float __h=68.11141; //min:0 max:360
float __s =12.144852; //min:0 max:100
float __b =59.929962; //min:0 max:100
float __op =46.01437; //min:0 max:100

int __num_circles=3; //min:1 max:6
int __num_min=7; //min:2 max:10
int __num_max=28; //min:10 max:30

float __pos=0.30077964; //min:0.1 max:0.4
float __size=195.9929; //min:20 max:200

void setup() {
surface.setLocation(669,292); //INJECTED LINE
PSurfaceAWT awtSurface = (PSurfaceAWT)surface; //INJECTED LINE
smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative(); //INJECTED LINE
println("[Client] Client connected"); //INJECTED LINE
v_m = new Client(this, "localhost", 3000 + 5); //INJECTED LINE
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
final String sketch = getClass().getName();//INJECTED LINE
java.awt.Point p = new java.awt.Point();//INJECTED LINE
smoothCanvas.getFrame().getLocation(p);//INJECTED LINE
if (windowOpen==true) {listener=1; } else {  listener=0;} //INJECTED LINE
v_m.write(sketch + " " + listener + " "); //INJECTED LINE
}

void drawTarget(float xloc, float yloc, float size, int num) {
  float steps = size/num;
  for (int i = 0; i < num; i++) {
    fill(__h+(5*i), __s+(5*i), __b+(5*i), __op);
    ellipse(xloc, yloc, size - i*steps, size - i*steps);
  }
}
import processing.net.*; //INJECTED LINE
import processing.awt.PSurfaceAWT; //INJECTED LINE
PSurfaceAWT.SmoothCanvas smoothCanvas; //INJECTED LINE
Client v_m; //INJECTED LINE
int listener = 0; //INJECTED LINE
void exit() { windowOpen = false; thread("exitDelay");}
boolean windowOpen = true;
void exitDelay(){delay(1000); System.exit(0);}
