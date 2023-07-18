// ------------------> Interface font config.
PFont font;
String[] fontList = PFont.list();
String groteskSemi = fontList[min(2582, fontList.length - 1)];
String groteskRegular  = fontList[min(2581, fontList.length - 1)];

// --> Title elements (h1) method
void h1 (PFont typeface, String fontPath, int size, String text, float yPos) {
  typeface = createFont(fontPath, 100);
  fill(200);
  textAlign(CENTER);
  textFont(typeface);
  textSize(size);
  text(text, width/2, yPos);
}

// --> Text elements method
void elements (PFont typeface, String fontPath, int size, String text, float xPos, float yPos) {
  typeface = createFont(fontPath, 100);
  fill(200);
  textFont(typeface);
  textSize(size);
  text(text, xPos, yPos);
}

void sectionLine(float y) {

  stroke (255);
  strokeWeight(1.7); //--> Adjust the button stroke weight
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
    strokeWeight(1.7); //--> Adjust the button stroke weight
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
