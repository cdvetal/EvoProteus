float __x =124.375175; //min:0 max:200
float __y =185.37997; //min:0 max:200
float __width =142.67012; //min:70 max:200
float __height =142.01933; //min:70 max:200

float __r =177.05914; //min:1 max:255
float __g =115.58278; //min:1 max:255
float __b =33.55159; //min:1 max:255


void setup() {
/*Injected line, you may delete it*/ clientSketches = new Client(this, "localhost", 3000 + 58);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(992,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  background(255);
  pixelDensity(2);

  rectMode(CENTER);

  fill(__r, __g, __b);
  rect(__x, __y, __width, __height); //--> Building
}

void draw() {
/*Injected line, you may delete it*/  java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();} if (flag) { save("/Users/ricardosacadura/Research/Towards-Automated-Generative-Design/EvoProteus/snapshots/pop_011/indiv_003.png"); flag = false;}
  
}
/*Injected line, you may delete it*/ import processing.net.*;import processing.awt.PSurfaceAWT;boolean flag = true;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;
