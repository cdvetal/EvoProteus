float __x =198.91205; //min:0 max:200
float __y =193.8513; //min:0 max:200
float __width =91.13324; //min:70 max:200
float __height =187.84827; //min:70 max:200

float __r =206.21086; //min:1 max:255
float __g =114.91683; //min:1 max:255
float __b =217.17064; //min:1 max:255


void setup() {
/*Injected line, you may delete it*/ clientSketches = new Client(this, "localhost", 3000 + 2);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(669,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  background(255);
  pixelDensity(2);

  rectMode(CENTER);

  fill(__r, __g, __b);
  rect(__x, __y, __width, __height); //--> Building
}

void draw() {
/*Injected line, you may delete it*/  java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();} if (flag) { save("/Users/ricardosacadura/Research/Towards-Automated-Generative-Design/EvoProteus/snapshots/pop_000/indiv_002.png"); flag = false;}
  
}
/*Injected line, you may delete it*/ import processing.net.*;import processing.awt.PSurfaceAWT;boolean flag = true;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;
