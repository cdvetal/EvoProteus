ArrayList<Rectangle> rectangles;

float __fillProb =0.9941904; //min:0.05 max:1
float __splitProbX =0.6171765; //min:0.1 max:0.8
float __splitProbY =0.40347755; //min:0.1 max:0.8

void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 10);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(669,738);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(300, 300);
  //pixelDensity(2);
  background(255);
  //colorMode(HSB);
  rectangles = new ArrayList<Rectangle>();
  int x = 30;
  int y = 30;
  int w = 240;
  int h = 240;
  int step = 240 / 6;
  
  Rectangle rectStart = new Rectangle(x, y, w, h);
  rectangles.add(rectStart);

  for (int i = 0; i < 240; i += step) {
    splitSquaresWith(new PVector(x + i, y));
    splitSquaresWith(new PVector(x, y + i));
  }

  for (int i = rectangles.size() - 1; i >= 0; i--) {
    rectangles.get(i).show();
  }
}

void splitSquaresWith(PVector point) {
  for (int i = rectangles.size() - 1; i >= 0; i--) {
    Rectangle square = rectangles.get(i);

    if (point.x != 0 && point.x > square.x && point.x < (square.x + square.w)) {
      if (random(1) > __splitProbX) {
        rectangles.remove(i);
        splitOnX(square, (int) point.x);
      }
    }

    if (point.y != 0 && point.y > square.y && point.y < (square.y + square.h)) {
      if (random(1) > __splitProbY) {
        rectangles.remove(i);
        splitOnY(square, (int) point.y);
      }
    }
  }
}

void splitOnX(Rectangle square, int cx) {
  int newX = square.x;
  int newY = square.y;
  int newW = square.w - (square.w - cx + square.x);
  int newH = square.h;
  Rectangle squareA = new Rectangle(newX, newY, newW, newH);

  int newX2 = cx;
  int newY2 = square.y;
  int newW2 = square.w - cx + square.x;
  int newH2 = square.h;
  Rectangle squareB = new Rectangle(newX2, newY2, newW2, newH2);

  rectangles.add(squareA);
  rectangles.add(squareB);
}

void splitOnY(Rectangle square, int cy) {
  int newX = square.x;
  int newY = square.y;
  int newW = square.w;
  int newH = square.h - (square.h - cy + square.y);
  Rectangle squareA = new Rectangle(newX, newY, newW, newH);

  int newX2 = square.x;
  int newY2 = cy;
  int newW2 = square.w;
  int newH2 = square.h - cy + square.y;
  Rectangle squareB = new Rectangle(newX2, newY2, newW2, newH2);

  rectangles.add(squareA);
  rectangles.add(squareB);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
}

class Rectangle {
  int x, y, w, h;

  Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void show() {
    stroke(0);
    strokeWeight(4);

    if (random(1) < __fillProb) {
      int c = int(random(3));
      if (c == 0) fill(#fff001);
      if (c == 1) fill(#ff0101);
      if (c == 2) fill(#0101fd);
    } else {
      fill(255);
    }
    rect(x, y, w, h);
  }
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
