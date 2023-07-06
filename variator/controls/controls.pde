/**
 
 Towards Automated Generative Design, Variator version 1.4
 Ricardo Sacadura advised by Penousal Machado and Tiago Martins (july 2023)
 ----------------------------------
 B. Parametrization panel component
 
 */

import processing.net.*;
import processing.awt.PSurfaceAWT;
PSurfaceAWT.SmoothCanvas smoothCanvas;

Client v_c;

String input;
String operatorValue;
int exitValue;

PFont font;
String[] fontList = PFont.list();
String SGrotesk_Regular  = fontList[2581];

boolean firstMousePress = false;

Slider [] hs = new Slider [5];

void setup() {

  size(800, 130);
  surface.setLocation(displayWidth/2 - (displayWidth/3), displayHeight/2 + int(displayHeight*0.222));
  surface.setTitle("Parametrization");
  surface.setResizable(true);

  PSurfaceAWT awtSurface = (PSurfaceAWT)surface;
  smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();

  v_c = new Client(this, "localhost", 8000);

  font = createFont(SGrotesk_Regular, 100);
  noStroke();

  for (int i = 0; i < hs.length; i++) {
    float min = 0, max = 0;
    String operator = "";
    boolean type = true;

    if (i == 0) {
      min = 0;
      max = 16;
      operator = "Population Size";
      type = true;
    } else if (i == 1) {
      min = 0;
      max = 6;
      operator = "Elite Size";
      type = true;
    } else if (i == 2) {
      min = 0;
      max = 16;
      operator = "Tournament Size";
      type = true;
    } else if (i == 3) {
      min = 0;
      max = 1;
      operator = "Mutation Rate";
      type = false;
    } else if (i == 4) {
      min = 0;
      max = 1;
      operator = "Crossover Rate";
      type = false;
    }

    hs[i] = new Slider(40 + (150 * i), height/2, 125, 2, 3, min, max, operator, type);
  }
}

void draw() {

  background(0);

  java.awt.Point p = new java.awt.Point();
  smoothCanvas.getFrame().getLocation(p);

  for (int j = 0; j < hs.length; j++) {
    hs[j].update();
    hs[j].display();
  }

  v_c.write(hs[0].getOperatorValue() + " " + hs[1].getOperatorValue() + " " + hs[2].getOperatorValue() + " " + hs[3].getOperatorValue() + " " + hs[4].getOperatorValue());

  if (v_c.available() > 0) {
    input = v_c.readString();
    exitValue = int(input);
    if (exitValue == 2) exit();
  }

  if (firstMousePress) {
    firstMousePress = false;
  }
}

void mousePressed() {
  if (!firstMousePress) {
    firstMousePress = true;
  }
}

class Slider {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  float value = 0;
  float vMin, vMax;
  String operator;
  boolean type;

  String printValue;

  Slider (float xp, float yp, int sw, int sh, int l, float vm, float vM, String op, boolean t) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp - sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    vMin = vm;
    vMax = vM;
    operator = op;
    type = t;
  }

  void update() {

    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (firstMousePress && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight*6) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(200);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(255);
    } else {
      fill(200);
    }
    value = map(spos, sposMin, sposMax, vMin, vMax);

    ellipse(spos, ypos, sheight * 10, sheight * 10);

    textAlign(CENTER);
    textFont(font);
    textSize(14);
    if (type) {
      operatorValue = str(int(value));
    } else {
      operatorValue = str(int(value));
      operatorValue = nf(value, 0, 1);
    }
    printValue = operatorValue;
    text(operator, xpos + swidth/2 - sheight/2, ypos + sheight * 16);
    text(operatorValue, spos, ypos - sheight * 12);
  }

  float getPos() {
    return spos * ratio;
  }

  String getOperatorValue() {
    return printValue;
  }
}
