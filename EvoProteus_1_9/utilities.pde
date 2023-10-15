/**
    1.3 Interface design implementation
*/

//------------------------------------------------> Colours config.
int colorLetters = 200;
int colorBg = 10;
int colorStrokes = 200;
int colorOnHover = 255;
int colorOff = 80;
int colorPams = 0;
//------------------------------------------------> Interface font config.
PFont font;
String[] fontList = PFont.list();
String h1Type, textType, notesType;

//------------------------------------------------> Method to choose a typeface
int chooseType(String t) {
  int i = 0;

  for (String type : fontList) {
    if (type.equals(t)) break;
    if (i >= fontList.length-1) {
      i = 1;
      break;
    }
    i++;
  }
  return i;
}

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

// --> Detects x char occurrences on a string
int matcher(String in, String find) {
  int index = 0;
  int last = -1;
  while (index != -1) {
    index = in.indexOf(find, last+1);
    if ( index != -1 ) last = index;
  }
  return last;
}


//------------------------------------------------> Creates a toggle button
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

//------------------------------------------------> Creates a circle button

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
  fill(0);
  ellipse(x - 4 , y, radius * 2, radius*2);

}
