ArrayList<Particle> particles;
int[] list;

PVector axis;
PFont font;
String[] fontList = PFont.list();
String roboto = fontList[1957];
int __fontSize =145; // min:100 max:350

int count;
int __max =320; // min:100 max:750
char typedKey = 'R';

int __fg =255; // min:100 max:255
int bg = 0;

float __scaleFactorA =0.12721162; // min:0.1 max:0.6
float __scaleFactorB =0.53592634; // min:0.35 max:1


void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 11);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,392);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);

  frameRate(24);

  noStroke();

  font = createFont(roboto, __fontSize);
  textFont(font);
  fill(bg);

  count = 0;
  textAlign(CENTER, CENTER);
  text(typedKey, width / 2, height / 2);

  list = new int[width * height];

  loadPixels();
  for (int y = 0; y <= height - 1; y++) {
    for (int x = 0; x <= width - 1; x++) {
      color pb = pixels[y * width + x];
      if (red(pb) < 5) {
        list[y * width + x] = 0;
      } else {
        list[y * width + x] = 1;
      }
    }
  }
  updatePixels();

  particles = new ArrayList<Particle>();
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}

  if (count < __max) {
    int i = 0;
    while (i < 3) {
      axis = new PVector(int(random(100, width - 100)), int(random(100, height - 100)));
      if (list[int(axis.y * width + axis.x)] == 0) {
        particles.add(new Particle(axis.x, axis.y));
        i++;
        count++;
      }
    }
  }

  background(bg);

  for (int i = 0; i < particles.size(); i++) {
    Particle f = particles.get(i);
    fill(bg);
    f.display();
    f.update();
  }
  for (int j = 0; j < particles.size(); j++) {
    Particle l = particles.get(j);
    fill(__fg);
    l.display2();
    l.update();
  }
}

class Particle {
  PVector location;
  PVector velocity;
  float scale = random(__scaleFactorA, __scaleFactorB);
  int radius = int(scale * 40);

  Particle(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(random(1), random(1));
  }

  void update() {
    location.add(velocity);
    if ((list[int(location.y) * width + int(location.x + velocity.x)] == 1) || (list[int(location.y) * width + int(location.x - velocity.x)] == 1)) {
      velocity.x *= -1;
    }
    if ((list[int(location.y + velocity.y) * width + int(location.x)] == 1) || (list[int(location.y - velocity.y) * width + int(location.x)] == 1)) {
      velocity.y *= -1;
    }
  }

  void display() {
    ellipse(location.x, location.y, radius, radius);
  }

  void display2() {
    ellipse(location.x, location.y, radius - 10, radius - 10);
  }
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
