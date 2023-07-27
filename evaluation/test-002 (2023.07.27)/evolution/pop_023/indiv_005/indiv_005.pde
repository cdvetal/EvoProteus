float theta = 0;
float __xNoise =10.359652; //min:1 max:20
float __yNoise =3.8861628; //min:1 max:20
float __xMove =98.95294; //min:0 max:100
float __yMove =100.0; //min:0 max:100
float scaler = 1;

float __minScale =49.42551; //min:10 max:50
float __maxScale =132.56824; //min:50 max:300
float __decrement =0.008768017; //min:0.0001 max:0.01
float __colorFill =23.790667; //min:0 max:150
float __colorStroke =232.61847; //min:100 max:255

void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 350);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,392);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  background(0);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
  if (scaler > 0) {
    fill(__colorFill, 100);
    stroke(__colorStroke);
    push();
    __xMove += 0.001;
    __yMove += 0.001;
    float xMover = map(noise(__xMove, frameCount / 1000.0), 0, 1, -width / 3, width / 3);
    float yMover = map(noise(__yMove, frameCount / 1000.0), 0, 1, -height / 3, height / 3);
    translate(width / 2 + xMover, height / 2 + yMover);
    beginShape();
    scale(scaler);
    for (float i = 0; i <= TWO_PI; i += TWO_PI / 100) {
      float x = cos(i) * value(__xNoise, i);
      float y = sin(i) * value(__yNoise, i);
      curveVertex(x, y);
    }
    endShape(CLOSE);
    pop();
    //scaler -= 0.0004;
    scaler -= __decrement;
  }
}

float value(float diameter, float theta) {
  float xoff = map(cos(theta), -1, 1, 0, diameter);
  float yoff = map(sin(theta), -1, 1, 0, diameter);
  float r = noise(xoff, yoff, frameCount / 100.0);
  return map(r, 0, 1, __minScale, __maxScale);
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
