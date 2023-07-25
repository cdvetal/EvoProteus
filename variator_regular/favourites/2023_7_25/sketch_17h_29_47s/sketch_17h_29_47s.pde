
/**
 * Bouncy Bubbles
 * based on code from Keith Peters.
 *
 * Multiple-object collision.
 */

int __c1 =75;//min:0 max:255
int __c2 =68;  //min:0 max:255
int __c3=99; //min:0 max:255

boolean __teste =false; //min:true max:false



int __numBalls =16;// min:0 max:25
int __diameter =62; //min:10 max:80
float spring = 0.05;
float __gravity =0.021846548; //min:0.01 max:0.05
float friction = -0.9;
Ball[] balls = new Ball[__numBalls];

void setup() {
/*Injected line, you may delete it*/clientSketches = new Client(this, "localhost", 3000 + 0);pid = int(ProcessHandle.current().pid());pidT = str(pid);clientSketches.write("0" + " " + sketch + " " + pidT);surface.setLocation(23,46);PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println("[Client] Client connected");textType = fontList[chooseType("SpaceGrotesk-Regular")];font = createFont(textType, 12);

  size(440, 160);

  float __debugSetup =55.3891; //min:10 max:100
  for (int i = 0; i < __numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), __diameter, i, balls);
  }
  noStroke();
  fill(__c1, __c2, __c3);
}

void draw() {
  background(__c2, __c3, __c1);
/*Injected line, you may delete it*/java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write("1" + " " + sketch + " " + listener + " " + p.x + " " + p.y + " ");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}if (pressed) {if (startTime == 0) startTime = millis();favComponent();}
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
}

class Ball {

  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
  float __debugDraw =39.83838; //min:10 max:100

  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  }

  void collide() {
    for (int i = id + 1; i < __numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) {
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }
  }

  void move() {
    vy += __gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    } else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction;
    } else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }

  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
/*Injected line, you may delete it*/import java.io.File;import java.io.IOException;import java.nio.file.Files;import java.nio.file.Path;import java.nio.file.Paths;import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit() { windowOpen = false; thread("exitDelay");}boolean windowOpen = true;void exitDelay(){delay(1500); System.exit(0);}String input; int exitValue;final String sketch = getClass().getName();int pid;String pidT;void mouseReleased() {pressed = true;opacity = 0;startTime = 0;String source = sketchPath(sketch + ".pde");String str = sketchPath();int tabIndex;tabIndex = matcher(str, "variations");String destination = str.substring(0, tabIndex) + "favourites/"+year()+"_"+month()+"_"+day()+"/sketch_"+hour()+"h_"+minute()+"_"+second()+"s";String filename = "/sketch_"+hour()+"h_"+minute()+"_"+second()+"s.pde";boolean success = copyFile(source, destination, filename);}int matcher(String in, String find) {int index = 0;int last = -1;while (index != -1) {index = in.indexOf(find, last+1);if ( index != -1 ) last = index;}return last;}boolean copyFile(String sourceFilePath, String destinationFolderPath, String desiredFilename) {try {File sourceFile = new File(sourceFilePath);File destinationFolder = new File(destinationFolderPath);if (!sourceFile.exists()) {println("Source file does not exist.");return false;}if (!destinationFolder.exists()) {destinationFolder.mkdirs();} else if (!destinationFolder.isDirectory()) {println("Destination is not a valid folder.");return false;}Path sourcePath = Paths.get(sourceFilePath);Path destinationPath = Paths.get(destinationFolderPath + desiredFilename);Files.copy(sourcePath, destinationPath);return true;}catch (IOException e){println("Error copying file: " + e.getMessage());return false;}}void heart(float x, float y, float size) {beginShape();vertex(x, y);bezierVertex(x - size / 2, y - size / 3, x - size, y + size / 3, x, y + size);bezierVertex(x + size, y + size / 3, x + size / 2, y - size / 3, x, y);endShape(CLOSE);}void favComponent () {int maxOpacity = 200;if (opacity <= maxOpacity && millis() - startTime < interval) {opacity += 10;} else if (opacity >= 0) {opacity -= 10;}push();blendMode(DIFFERENCE);fill(0, opacity);translate(width/2, height/2);textAlign(CENTER);textFont(font);fill(255, opacity);String t = "Added to 'favourites' folder";textLeading(14);text(t, 0, height/10);noStroke();heart(0, -height/5, 40);pop();}int chooseType(String t) {int i = 0;for (String type : fontList) {if (type.equals(t)) break;if (i >= fontList.length-1){i = 1;break;}i++;}return i;}PFont font;String[] fontList = PFont.list();String textType;boolean pressed = false;int opacity = 0;int startTime = 0;int interval = 1500;
