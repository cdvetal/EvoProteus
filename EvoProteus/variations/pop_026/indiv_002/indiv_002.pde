/**
 'Bauhaus Generative Logo'
 Created by Ricardo Sacadura
 */

float x1 = 150;
float __x2 =180.59052; //min:0 max:200
float __x3 =150.0; //min:0 max:150
float __x4 =0.0; //min:0 max:100
float __y1 =0.0; //min:0 max:200
float __y2 =131.63225; //min:0 max:200
float __y3 =211.86931; //min:0 max:300
float __y4 =222.93188; //min:50 max:300
float __width1 =70.0; //min:70 max:200
float __width2 =130.0; //min:10 max:130
float __width3 =100.0; //min:10 max:100
float __height1 =288.19257; //min:120 max:300
float __height2 =19.762968; //min:5 max:60
float   height3 = 5;

float __inc =97.16187; //min:20 max:100


void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 422);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(669,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");

  size(300, 300);
  background(255);
  pixelDensity(2);

  rectMode(CENTER);
  strokeWeight(3);
  stroke(0);

  rect(x1, __y1, __width1, __height1); //--> Building
  
  fill(0);
  for (int i = 0; i < 4; ++i) {
    rect(__x2, __y2, __width2, __height2); //--> Windows
    __y2 += __inc;
  }
  rect(__x3, __y3, __width3, height3); //--> Awning
  strokeWeight(2);
  line(__x4, __y4, __x4 + __width1, __y4);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
