/**
 1.2 Interface design implementation
 */

boolean firstMousePress = false;
String operatorValue;
Slider [] hs = new Slider [6];

class Slider {
  float swidth, sheight;   //--> width and height of bar
  float xpos, ypos;       //--> x and y position of bar
  float spos, newspos;    //--> x position of slider
  float sposMin, sposMax; //--> max and min values of slider
  int loose;              //--> how loose/heavy
  boolean over;           //--> is the mouse over the slider?
  boolean locked;
  float ratio;
  float value = 0;
  float vMin, vMax;
  String operator;
  boolean type;
  boolean cases;

  String printValue;

  PFont fontSlider;

  Slider (float xp, float yp, float sw, float sh, int l, float vm, float vM, String op, boolean t, boolean cases) {
    swidth = sw;
    sheight = sh;
    float widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp - sheight/2;
    spos = xpos - swidth/4; //--> Changes starting values (recommended xpos - swidth/4)
    newspos = spos;
    sposMin = xpos - swidth/2;
    sposMax = xpos + swidth/2;
    loose = l;
    vMin = vm;
    vMax = vM;
    operator = op;
    type = t;
    this.cases = cases;
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
    if (dist(mouseX, mouseY, spos, ypos) < sheight * 4) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    fontSlider = createFont(textType, 300);
    noStroke();
    fill(colorStrokes);
    rect(xpos, ypos, swidth, sheight);

    if (over || locked) {
      fill(colorOnHover);
    } else {
      fill(colorStrokes);
    }

    value = map(spos, sposMin, sposMax, vMin, vMax);
    ellipse(spos, ypos, sheight * 8, sheight * 8);

    textAlign(CENTER);
    textFont(fontSlider);
    textSize(12);

    if (type) {
      operatorValue = str(int(value));
    } else {
      operatorValue = str(int(value));
      if (cases) {
        operatorValue = nf(value, 0, 1);
      } else {
        operatorValue = nf(value, 0, 2);
      }
    }
    printValue = operatorValue;
    text(operator, xpos, ypos + sheight * 13);
    text(operatorValue, spos, ypos - sheight * 7);
  }

  float getPos() {
    return spos * ratio;
  }

  String getOperatorValue() {
    return printValue;
  }
}

void createSliders (Slider [] hs) {

  float yPos = height * 0.471;

  for (int i = 0; i < hs.length; ++ i) {
    float min = 0, max = 0;
    String operator = "";
    boolean type = true;
    boolean cases = true;

    if (i == 0) {
      min = 0;
      max = 21;
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
      operator = "Crossover Rate";
      type = false;
      cases =true;
    } else if (i == 4) {
      min = 0;
      max = 1;
      operator = "Mutation Rate";
      type = false;
      cases = true;
    } else if (i == 5) {
      min = 0;
      max = 0.5;
      operator = "Mutation Scale factor";
      type = false;
      cases = false;
    }

    hs[i] = new Slider(width/2, yPos, 125, 1.6, 3, min, max, operator, type, cases);
    yPos+=60; // --> Set distance between sliders
  }
}
