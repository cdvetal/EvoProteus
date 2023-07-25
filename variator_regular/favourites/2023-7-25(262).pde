/**
 * Functions.
 *
 * The drawTarget() function makes it easy to draw many distinct targets.
 * Each call to drawTarget() specifies the position, size, and number of
 * rings for each target.
 */

boolean __bg =true; //min:0 max:1
float __h =214.8899; //min:0 max:360
float __s =2.6246846; //min:0 max:100
float __b =94.86554; //min:0 max:100
float __op =53.563606; //min:0 max:100

int __num_circles =2; //min:1 max:6
int __num_min =3; //min:2 max:10
int __num_max =25; //min:10 max:30

float __pos =0.23727602; //min:0.1 max:0.4
float __size =191.77397; //min:20 max:200

color c;
ArrayList <Target> t = new ArrayList<Target>();


void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 2);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(669,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");textType = fontList[chooseType("SpaceGrotesk-Regular")];font = createFont(textType, 12);

  size(300, 200);

  colorMode(HSB, 360, 100, 100);
  noStroke();

  c = __bg ? color(0, 0, 0) : color(0, 0, 100);

  for (int i = 0; i < __num_circles; i++) {
    t.add(new Target(width * __pos * i, height * random(1), __size, int(random(__num_min, __num_max))));
  }
}

void draw() {
  background(c);
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}if (pressed) {if (startTime == 0) startTime = millis();favComponent();}
  for (int i = 0; i < __num_circles; i++) t.get(i).create();
}

class Target {

  float xloc;
  float yloc;
  float size;
  int num;

  Target (float x, float y, float s, int n) {
    xloc = x;
    yloc = y;
    size = s;
    num = n;
  }

  void create() {
    float steps = size/num;
    for (int i = 0; i < num; i++) {
      fill(__h+(5*i), __s+(5*i), __b+(5*i), __op);
      ellipse(xloc, yloc, size - i*steps, size - i*steps);
    }
  }
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit() { windowOpen = false; thread("exitDelay");}boolean windowOpen = true;void exitDelay(){delay(1500); System.exit(0);}String input; int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {pressed = true;opacity = 0;startTime = 0;String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/";String filename = year()+"-"+month()+"-"+day()+"("+frameCount+").pde";boolean success = copyFile(source, destination, filename);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e){println("Error copying file: " + e.getMessage());return false;}}void heart(float x, float y, float size) {beginShape();vertex(x, y);bezierVertex(x - size / 2, y - size / 3, x - size, y + size / 3, x, y + size);bezierVertex(x + size, y + size / 3, x + size / 2, y - size / 3, x, y);endShape(CLOSE);}void favComponent () {int maxOpacity = 200;if (opacity <= maxOpacity && millis() - startTime < interval) {opacity += 10;} else if (opacity >= 0) {opacity -= 10;}push();blendMode(DIFFERENCE);fill(0, opacity);translate(width/2, height/2);textAlign(CENTER);textFont(font);fill(255, opacity);String t = "Added to 'favourites' folder";textLeading(14);text(t, 0, height/10);noStroke();heart(0, -height/5, 40);pop();}int chooseType(String t) {int i = 0;for (String type : fontList) {if (type.equals(t)) break;if (i >= fontList.length-1){i = 1;break;}i++;}return i;}PFont font;String[] fontList = PFont.list();String textType;boolean pressed = false;int opacity = 0;int startTime = 0;int interval = 1500;
