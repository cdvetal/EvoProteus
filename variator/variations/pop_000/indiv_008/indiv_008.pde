/**
 * Functions.
 *
 * The drawTarget() function makes it easy to draw many distinct targets.
 * Each call to drawTarget() specifies the position, size, and number of
 * rings for each target.
 */

boolean __bg=true; //min:0 max:1
float __h=238.62791; //min:0 max:360
float __s =54.173424; //min:0 max:100
float __b =32.1899; //min:0 max:100
float __op =11.715221; //min:0 max:100

int __num_circles=5; //min:1 max:6
int __num_min=6; //min:2 max:10
int __num_max=13; //min:10 max:30

float __pos=0.2623809; //min:0.1 max:0.4
float __size=80.684814; //min:20 max:200

void setup() {
surface.setLocation(669,538); //variator
PSurfaceAWT awtSurface = (PSurfaceAWT)surface; //variator
smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative(); //variator
println("[Client] Client connected"); //variator
v_m = new Client(this, "localhost", 3000 + 8); //variator
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
final String sketch = getClass().getName();//variator
java.awt.Point p = new java.awt.Point();//variator
smoothCanvas.getFrame().getLocation(p);//variator
if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;} //variator
v_m.write(sketch + " " + listener + " "); //variator
if (v_m.available() > 0) {input = v_m.readString(); exitValue = int(input); if (exitValue == 2) exit();}
}

void drawTarget(float xloc, float yloc, float size, int num) {
  float steps = size/num;
  for (int i = 0; i < num; i++) {
    fill(__h+(5*i), __s+(5*i), __b+(5*i), __op);
    ellipse(xloc, yloc, size - i*steps, size - i*steps);
  }
}
import processing.net.*; //variator
import processing.awt.PSurfaceAWT; //variator
PSurfaceAWT.SmoothCanvas smoothCanvas; //variator
Client v_m; //variator
int listener = 0; //variator
void exit() { windowOpen = false; thread("exitDelay");}
boolean windowOpen = true;
void exitDelay(){delay(1500); System.exit(0);}
String input; int exitValue;
