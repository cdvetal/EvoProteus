ArrayList<Flocker> flock = new ArrayList<Flocker>();

int __bg =117; // min:0 max:255


void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 0);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");
  size(200, 200);
}

void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}

  background(__bg);

  for (Flocker f : flock) {
    f.step();
    f.draw();
  }
}

void mouseDragged() {
  flock.add(new Flocker(mouseX, mouseY));
}

class Flocker {

  float x;
  float y;
  float heading =1.0157609;
  float __speed =18.028507; // min:1 max:3
  float __radius = 10; // min:10 max:20

  public Flocker(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void step() {

    //we need more than one Flocker for this to work
    if (flock.size() > 1) {

      //find the closest Flocker
      float closestDistance = 100000;
      Flocker closestFlocker = null;
      for (Flocker f : flock) {

        //make sure not to check against yourself
        if (f != this) {
          float distance = dist(x, y, f.x, f.y);
          if (distance < closestDistance) {
            closestDistance = distance;
            closestFlocker = f;
          }
        }
      }

      float angleToClosest = atan2(closestFlocker.y-y, closestFlocker.x-x);

      //prevent case where heading is 350 and angleToClosest is 10
      if (heading-angleToClosest > PI) {
        angleToClosest += TWO_PI;
      } else if (angleToClosest-heading > PI) {
        angleToClosest -= TWO_PI;
      }

      //turn towards closest
      if (heading < angleToClosest) {
        heading+=PI/40;
      } else {
        heading-=PI/40;
      }

      //move in direction
      x += cos(heading)*__speed;
      y += sin(heading)*__speed;

      //wrap around edges
      if (x < 0) {
        x = width;
      }
      if (x > width) {
        x = 0;
      }

      if (y < 0) {
        y = height;
      }
      if (y > height) {
        y = 0;
      }
    }
  }

  void draw() {
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}
    ellipse(x, y, __radius, __radius);
  }
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit(){windowOpen = false;thread("exitDelay");}boolean windowOpen = true;void exitDelay() {delay(1500);System.exit(0);}String input;int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"m_"+second()+"s.pde";copyFile(source, destination, filename);clientSketches.write("2" + " " + sketch);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if(!destinationFolder.exists()) {destinationFolder.mkdirs();}else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e) {println("Error copying file: " + e.getMessage());return false;}}
