/*
 First Sketch is reference about M13 Star Cluster Constellation
 Name: Constellations
 Created by : Stéfani Diniz
 */

int __bg1=253; //min:0 max:360
int __bg2=248; //min:0 max:360
int __bg3=77; //min:0 max:100
int __sparklyQty=92; //min:2 max:300
int __color1=296; //min:15 max:360
int __color2=80; //min:15 max:360
int __color3=34; //min:15 max:360
int __transp =34; //min:0 max:100
int __radius=128; //min:20 max:300
int __x=37; //min:0 max:300
int __y=3; //min:0 max:300

int x2, y2;
float radius2;

void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 15);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,1084);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  colorMode(HSB);
  background(__bg1, __bg2, __bg3);

  x2 = int(random(__x));
  y2 = int(random(__y/2));
  radius2 = random(__radius*0.7);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
  shapeMode(CENTER);
  noStroke();
  fill(__color1, __color2, __color3, __transp);

  star(__x, __y, __radius, __sparklyQty);
  star(x2, y2, radius2, __sparklyQty);
}

void star(int x, int y, float radius, int sparklyQty) {
  float delta = 2 * PI / sparklyQty;
  float idelta = delta / 2;
  float iRadius = radius / 2;
  float theta = 0.0;

  beginShape();
  for (float i = 0; i < sparklyQty; i++ ) {
    vertex(x + radius * cos(theta), y + radius * sin(theta));
    vertex(x + iRadius * cos(theta + idelta), y + iRadius * sin(theta + idelta));
    theta += delta;
  }
  endShape(CLOSE);
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
