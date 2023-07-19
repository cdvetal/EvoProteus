boolean firstMousePress = false;
String operatorValue;
Slider [] hs = new Slider [5];

class Slider {
  float swidth, sheight;    //--> width and height of bar
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

  String printValue;

  PFont fontSlider;

  Slider (float xp, float yp, float sw, float sh, int l, float vm, float vM, String op, boolean t) {
    swidth = sw;
    sheight = sh;
    float widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp - sheight/2;
    spos = xpos - swidth/2.4; //CHANGE STARTING VALUES HERE RECOMMENDED xpos - swidth/4
    newspos = spos;
    sposMin = xpos - swidth/2;
    sposMax = xpos + swidth/2;
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
    if (dist(mouseX, mouseY, spos, ypos) < sheight * 4) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    fontSlider = createFont(textType, 300);
    noStroke();
    fill(200);
    rect(xpos, ypos, swidth, sheight);

    if (over || locked) {
      fill(255);
    } else {
      fill(200);
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
      operatorValue = nf(value, 0, 1);
    }
    printValue = operatorValue;
    text(operator, xpos, ypos + sheight * 11);
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

  float yPos = height * 0.52;

  for (int i = 0; i < hs.length; i++) {
    float min = 0, max = 0;
    String operator = "";
    boolean type = true;

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
    } else if (i == 4) {
      min = 0;
      max = 1;
      operator = "Mutation Rate";
      type = false;
    }

    hs[i] = new Slider(width/2, yPos, 125, 1.6, 3, min, max, operator, type);
    yPos+=60; // --> Set distance between sliders
  }
}
