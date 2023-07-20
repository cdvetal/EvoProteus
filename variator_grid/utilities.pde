/**
    1.3 Interface design implementation
*/

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
  fill(200);
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

  stroke (255);
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
    stroke(200);
    strokeWeight(1.4); //--> Adjust the button stroke weight
    rect(posX, posY, sWidth, sHeight, sHeight/2);

    //--> Smoothly transition the indicator position
    float targetX = isToggled ? (posX + sWidth/2) - radius * 0.9 : (posX - sWidth/2) + radius * 0.9;
    moveX = lerp(moveX, targetX, 0.2);


    //--> Draws the toggle indicator
    noStroke();
    fill(200);
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
    stroke(200);
    noFill();
    if (clicked == 1) {
      ellipse(xPos, yPos, radius * 2, radius * 2);
      push();
      fill(200);
      noStroke();
      ellipse(xPos + 0.5, yPos + 0.5, radius, radius);
      pop();
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
