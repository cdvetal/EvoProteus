float __r1 =226.34877; // min:0 max:255
float __g1 =81.74456; // min:0 max:255
float __b1 =77.92905; // min:0 max:255

float __r2 =33.659233; // min:0 max:255
float __g2 =185.90233; // min:0 max:255
float __b2 =2.6720166; // min:0 max:255

float __r3 =225.09576; // min:0 max:255
float __g3 =5.269314; // min:0 max:255
float __b3 =106.29606; // min:0 max:255

float __r4 =203.80287; // min:0 max:255
float __g4 =47.947803; // min:0 max:255
float __b4 =17.61511; // min:0 max:255

color c1, c2, c3, c4;

float __xpos1 =126.180664; //min:0 max:300
float __ypos1 =121.16109; //min:0 max:300
float __xpos2 =278.5045; //min:0 max:300
float __ypos2 =222.03304; //min:0 max:300

void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 9);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(1315,392);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  
  size(300, 300);

  c1 = color(__r1, __g1, __b1);
  c2 = color(__r2, __g2, __b2);
  c3 = color(__r3, __g3, __b3);
  c4 = color(__r4, __g4, __b4);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
  
  background(230);
  setGradient(__xpos1, __ypos1, 120, 160, c1, c2);
  setGradient(__xpos2, __ypos2, 120, 160, c3, c4);
}

void setGradient(float x, float y, float w, float h, color c1, color c2) {

  noFill();
  for (int i = int(y); i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c, 200);
    line(x, i, x+w, i);
  }
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
