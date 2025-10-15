/**
 Interface: Components
 */

//---------------------------------- COLOURS CONFIGURATION --------------------------//
int colorLetters = 200; //THIS MUST CHANGE TO 200 AGAIN
int colorBg = 10;
int colorStrokes = 200;
int colorOnHover = 255;
int colorOff = 80;
int colorPams = 0;

//---------------------------------- FONTS CONFIGURATION --------------------------//

PFont font;
String[] fontList = PFont.list();
String h1Type, textType, notesType;

//------------------------------------------------> Method to choose a typeface
int chooseType(String t) {
  int i = 0;

  for (String type : fontList) {
    if (type.equals(t)) {
      break;
    }
    if (i >= fontList.length-1) {
      i = 1;
      break;
    }
    i++;
  }
  return i;
}

//----------------------------- TYPOGRAPHIC ELEMENTS ------------------------------//

//------------------------------------------------> Title elements (h1) method
void h1 (PFont typeface, String fontPath, int size, String text, float yPos) {
  typeface = createFont(fontPath, 100);
  fill(colorLetters);
  textAlign(CENTER);
  textFont(typeface);
  textSize(size);
  text(text, width/2, yPos);
}

//------------------------------------------------> Text elements method
void elements (PFont typeface, String fontPath, int size, String text, float xPos, float yPos, float eFill) {
  typeface = createFont(fontPath, 100);
  fill(eFill);
  textFont(typeface);
  textSize(size);
  text(text, xPos, yPos);
}

//------------------------------------------------> Section line
void sectionLine(float y) {

  stroke (colorStrokes);
  strokeWeight(1.4); //--> Adjust the button stroke weight
  line (width/12, y, width - width/12, y);
}

//------------------------------ TOGGLE BUTTON CLASS ------------------------------//
class ToggleButton {

  int posX;
  float posY;

  int sWidth = 30;
  int sHeight = 15;
  float radius = 8;
  float moveX;

  ToggleButton(int x, float y) {
    posX = x;
    posY = y;
    moveX = (x - sWidth/2) + radius;
  }

  void create() {

    //--> Draws the switch body
    noFill();
    stroke(colorStrokes);
    strokeWeight(1.4); //--> Adjust the button stroke weight
    rect(posX, posY, sWidth, sHeight, sHeight/2);

    //--> Smoothly transition the indicator position
    float targetX = isToggled ? (posX + sWidth/2) - radius * 0.9 : (posX - sWidth/2) + radius * 0.9;
    moveX = lerp(moveX, targetX, 0.2);


    //--> Draws the toggle indicator
    noStroke();
    fill(colorStrokes);
    ellipse(moveX, posY, radius * 2, radius * 2);
  }

  boolean isHover() {

    if (dist(mouseX, mouseY, moveX, posY) < radius * 2) {
      isToggled = !isToggled; // Toggle the state
    }

    return isToggled;
  }
}

boolean isToggled = false;
ToggleButton t;

//------------------------------ CIRCLE BUTTON CLASS ------------------------------//
class CircleButton {

  float xPos, yPos;
  float radius = 5;
  int clicked = 1;

  CircleButton(float x, float y, int c) {
    xPos = x;
    yPos = y;
    clicked = c;
  }

  void create () {

    strokeWeight(1.4); //--> Adjust the button stroke weight
    stroke(colorOff);
    noFill();
    if (clicked == 1) {
      ellipse(xPos, yPos, radius * 2, radius * 2);

      fill(colorLetters);
      noStroke();
      ellipse(xPos + 0.5, yPos + 0.5, radius, radius);
    } else {
      ellipse(xPos, yPos, radius * 2, radius * 2);
    }
  }

  int isClicked() {

    if (dist(mouseX, mouseY, xPos, yPos) < radius * 2) {
      if (clicked == 0) {
        clicked = 1;
      } else {
        clicked = 0;
      }
    }

    return clicked;
  }

  int getClicked() {
    return clicked;
  }
}

ArrayList <CircleButton> cb = new ArrayList<CircleButton>();
IntList isClicked = new IntList();

//---------------------------------- BUTTON CLASS ---------------------------------//
class Button {

  float buttonX, buttonY, buttonW, buttonH;
  String txt;
  int typeOfButton;
  float diameter;

  boolean btnIsHover = false;
  boolean btnIsHover2 = false;

  //--> Textual buttons
  Button(float x, float y, float w, float h, String t, int v) {
    buttonX = x;
    buttonY = y;
    buttonW = w;
    buttonH = h;
    txt = t;
    typeOfButton = v;
  }

  //--> Rounded buttons (play/pause)
  Button(float x, float y, float dm, int v) {
    buttonX = x;
    buttonY = y;
    diameter = dm;
    typeOfButton = v;
  }


  void create(PFont btnFont, String path) {

    stroke(colorStrokes);

    rectMode(CENTER);
    textAlign(CENTER);

    btnFont = createFont(path, 100);
    textFont(btnFont);

    //------------------------------------------------> Button box
    if (typeOfButton == 1) {

      strokeWeight(1.4); //--> Adjust the button stroke weight
      fill(btnIsHover ? colorOnHover : colorBg);
      rect(buttonX, buttonY, buttonW, buttonH);

      fill(btnIsHover ? colorBg : colorLetters);
      textSize(18);
      setButtonTxt(btnTxt[0]);
      text(txt, buttonX, buttonY + 5);
    }
    //------------------------------------------------> Underlined button box
    if (typeOfButton == 2) {

      strokeWeight(0.5); //--> Adjust the button stroke weight
      fill(btnIsHover ? colorOnHover : colorOff);

      textSize(10.5);
      text(txt, buttonX, buttonY + 5);
      float x1 = buttonX - (textWidth(txt)/2);
      float x2 = buttonX + (textWidth(txt)/2);
      line (x1, buttonY + 8, x2, buttonY + 8);
    }
  }

  void create() {

    fill(colorBg);
    //if (currentlyPlayed) stroke(colorOnHover);
    strokeWeight(1.4);

    //------------------------------------------------> Play button
    if (typeOfButton == 3) {

      float angle = PI / 6; // 30 degrees in radians
      float r = diameter / 2;
      float[] xPos = new float[3];
      float[] yPos = new float[3];

      for (int i = 0; i < 3; i++) {
        xPos[i] = buttonX + (r/1.4) * cos(angle + HALF_PI + TWO_PI / 3 * i);
        yPos[i] = buttonY + (r/1.4) * sin(angle + HALF_PI + TWO_PI / 3 * i);
      }

      if (currentlyPlayed) {
        stroke(colorOnHover);
      } else {
        stroke(btnIsHover ? colorOnHover : colorOff);
      }

      ellipse(buttonX, buttonY, diameter, diameter); //--> Create border

      if (currentlyPlayed) {
        fill(colorOnHover);
      } else {
        fill(btnIsHover ? colorOnHover : colorOff);
      }

      triangle(xPos[0], yPos[0], xPos[1], yPos[1], xPos[2], yPos[2]);
    }
    //------------------------------------------------> Pause button
    if (typeOfButton == 4) {
      float r = diameter / 2;

      if (currentlyPaused) {
        stroke(colorOnHover);
      } else {
        stroke(btnIsHover ? colorOnHover : colorOff);
      }

      ellipse(buttonX, buttonY, diameter, diameter); //--> Create border

      if (currentlyPaused) {
        fill(colorOnHover);
      } else {
        fill(btnIsHover ? colorOnHover : colorOff);
      }

      rectMode(CENTER);
      rect(buttonX - r/4, buttonY, r/3, r);
      rect(buttonX + r/4, buttonY, r/3, r);
    }
  }

  void update() {
    btnIsHover = hoverBtn();
    btnIsHover2 = hoverBtn();
  }

  boolean hoverBtn() {

    if (typeOfButton <= 2) {
      if (mouseX >= buttonX - buttonW/2 && mouseX <= buttonX + buttonW / 2 &&
        mouseY >= buttonY - buttonH /2 && mouseY <= buttonY+ buttonH /2) {
        return true;
      } else {
        return false;
      }
    } else if (typeOfButton >= 3) {
      float d = dist(buttonX, buttonY, mouseX, mouseY);

      if (d < diameter/2) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  boolean getHover() {
    return btnIsHover;
  }

  void setHover2(boolean a) {
    btnIsHover2 = a;
  }

  void setButtonTxt(String t) {
    txt = t;
  }
}

//---------------------------------- SLIDER CLASS ---------------------------------//
boolean firstMousePress = false;
String operatorValue;

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
    String displayValue = "";

    if (type) {
      operatorValue = str(int(value));
      displayValue = operatorValue;
    } else {
      operatorValue = str(int(value));
      displayValue = operatorValue;
      if (cases) {
        operatorValue = str(value);
        displayValue = nf(value, 0, 1);
      } else {
        operatorValue = str(value);
        displayValue = nf(value, 0, 2);
      }
    }
    if (type) {
      printValue = displayValue;
    } else {
      printValue = displayValue.replace(',', '.');
    }
    text(operator, xpos, ypos + sheight * 13);
    text(displayValue, spos, ypos - sheight * 7);
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
      max = 31;
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
      min = 0.0;
      max = 1.0;
      operator = "Crossover Rate";
      type = false;
      cases =true;
    } else if (i == 4) {
      min = 0.0;
      max = 1.0;
      operator = "Mutation Rate";
      type = false;
      cases = true;
    } else if (i == 5) {
      min = 0.0;
      max = 1.0;
      operator = "Mutation Scale factor";
      type = false;
      cases = false;
    }

    hs[i] = new Slider(width/2, yPos, 125, 1.6, 3, min, max, operator, type, cases);
    yPos+=60; // --> Set distance between sliders
  }
}

//---------------------------------- TYPER CLASS (prompting) ---------------------------------//

String txt = "";
char k;
TextContainer tbox;


class TextContainer {
  float x, y; //--> x and y position
  float w; //--> Width of the line
  char k;
  String txt = "";
  int txtLength;
  int timer;
  boolean active = true;


  TextContainer(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
  }

  void createContainer() {
    stroke(active ? colorStrokes : colorOff); //--> Change by EvoProteus own colour scheme
    fill(active ? colorLetters : colorOff); //--> Change by EvoProteus own colour scheme
    strokeWeight(1.4);
    line(x, y, x + w, y);
    textAlign(LEFT);
    textSize(10.5);
    textAlign(CENTER);
    String f1 = "(press enter to submit)";
    String f2 = "Prompt received (press enter again to edit)";
    text(active ? f1 : f2, width/2, y + 25);
    textSize(14);
    text(txt, width/2, y - 5);
  }

  void createTyperLine(float tw) {
    timer = (timer + 1) % 48;
    if (timer < 24) {
      strokeWeight(1.4);
    } else {
      strokeWeight(0);
    }
    float k = getTextWidth()/2;
    if (active) line(width/2 + k + 3, y - 5, width/2 + k + 3, y - 15);
  }

  void processInput() {
    txtLength = txt.length();

    if (k == BACKSPACE) backspace();
    if (k == ' ') space();
    if (k == ENTER) enter();
    if (validChar()) txt += k;
  }

  void backspace() {
    if (txtLength > 0) txt = txt.substring(0, txtLength - 1);
  }

  void space() {
    txt += " ";
  }

  void enter() {
    active = !active;
  }

  boolean validChar() {
    boolean caps = (k >= 'A' && k <= 'Z');
    boolean lowers = (k >= 'a' && k <= 'z');
    boolean nums = (k >= '0' && k <= '9');

    if (caps || lowers || nums) {
      return true;
    } else {
      return false;
    }
  }

  void setKey(char newKey) {
    k = newKey;
  }

  float getTextWidth() {
    return textWidth(txt);
  }

  String getPrompt() {
    return txt;
  }
}

//---------------------------------- ICONS ---------------------------------//

//------------------------------------------------> Creates a sun icon
void sunIcon(float x, float y, float radius) {

  stroke(colorStrokes);
  strokeWeight(1.4);

  float angle = TWO_PI / 8;
  ellipse(x, y, radius * 2, radius * 2);

  for (float a = 0; a < TWO_PI; a+=angle) {
    float x1 = x + cos(a) * radius;
    float y1 = y + sin(a) * radius;
    float x2 = x + cos(a) * radius * 1.8;
    float y2 = y + sin(a) * radius * 1.8;
    line(x1, y1, x2, y2);
  }
}

//------------------------------------------------> Creates a moon icon
void moonIcon(float x, float y, float radius) {

  noStroke();
  fill(255);
  ellipse(x, y, radius * 2, radius*2);
  fill(colorBg);
  ellipse(x - 4, y, radius * 2, radius*2);
}
