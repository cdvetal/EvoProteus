float __x =118.252; //min:0 max:200
float __y =164.83957; //min:0 max:200
float __width =124.48249; //min:70 max:200
float __height =159.41074; //min:70 max:200

float __r =76.934975; //min:1 max:255
float __g =89.67655; //min:1 max:255
float __b =122.875145; //min:1 max:255


void setup() {
/*Injected line, you may delete it*/ clientSketches = new Client(this, "localhost", 3000 + 45);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  background(255);
  pixelDensity(2);

  rectMode(CENTER);

  fill(__r, __g, __b);
  rect(__x, __y, __width, __height); //--> Building
}

void draw() {
/*Injected line, you may delete it*/  java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();} if (flag) { save("/Users/ricardosacadura/Research/Towards-Automated-Generative-Design/EvoProteus/snapshots/pop_009/indiv_000.png"); flag = false;}
  
}
/*Injected line, you may delete it*/ import processing.net.*;import processing.awt.PSurfaceAWT;boolean flag = true;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;
