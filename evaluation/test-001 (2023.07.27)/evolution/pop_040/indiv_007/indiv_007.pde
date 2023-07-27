/**
  'Maurer Rose' -> (adapted from p5.js to processing)
  Created by Stefan Nicov
  Available here: https://openprocessing.org/sketch/1673672
*/

int d;
int n;

float __x =293.26837; //min:30 max:300
float __y =300.0; //min:30 max:300

float __hue =302.08762; //min:0 max:360
float __sat =360.0; //min:0 max:360

void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 607);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(669,392);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  colorMode(HSB);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
  background(0);
 
  d = (int)(180 * __x / width);
  n = (int)(10 * __y / height);
  
  translate(width/2, height/2);
  stroke(255);
  noFill();
  
  beginShape();
  strokeWeight(1);
  for (int i = 0; i < 361; i++) {
    float k = i * d;
    float r = 150 * sin(degrees(n*k));
    float x = r * cos(degrees(k));
    float y = r * sin(degrees(k));
    vertex(x, y);    
  }
  endShape();
  
  noFill();
  stroke(__hue, __sat, 100, 100);
  strokeWeight(4);
  beginShape();
  for (int i = 0; i < 361; i++) {
    float k = i;
    float r = 150 * sin(degrees(n*k));
    float x = r * cos(degrees(k));
    float y = r * sin(degrees(k));
    vertex(x, y);    
  }
  endShape();
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
