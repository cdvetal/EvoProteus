/**
 * Scrollbar.
 *
 * Move the scrollbars left and right to change the positions of the images.
 */

PFont font;
String[] fontList = PFont.list();
String SGrotesk_Regular  = fontList[2581];


//True if a mouse button was pressed while no other button was.
boolean firstMousePress = false;
Slider hs2;  // Two scrollbars
Slider [] hs = new Slider [5];

void setup() {
  size(850, 130);
  surface.setTitle("Control Panel");
  font  = createFont(SGrotesk_Regular, 100);

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
    hs[i] = new Slider(60 + (150 * i), height/2+8, 125, 3, 3, min, max, operator, type);
  }
}

void draw() {

  background(255);
  // Get the position of the img1 scrollbar
  // and convert to a value to display the img1 image

  for (int j = 0; j < hs.length; j++) {
    hs[j].update();
    hs[j].display();
  }


  //After it has been used in the sketch, set it back to false
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
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    value = map(spos, sposMin, sposMax, vMin, vMax);

    ellipse(spos, ypos, sheight * 6, sheight * 6);

    textAlign(CENTER);
    textFont(font);
    textSize(12);
    String v;
    if (type) {
      v = str(int(value));
    } else {
      v = str(int(value));
      v = nf(value, 0, 1);
    }
    text(operator, xpos + swidth/2 - sheight/2, ypos + sheight * 10);
    text(v, spos, ypos - sheight * 6);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
