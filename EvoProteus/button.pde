/**
 1.1 Interface design implementation
 */

class Button {

  float buttonX, buttonY, buttonW, buttonH;
  String txt;
  int typeOfButton;
  float diameter;

  boolean btnIsHover = false;

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
      fill(btnIsHover ? colorOnHover : colorStrokes);

      textSize(10.5);
      text(txt, buttonX, buttonY + 5);
      float x1 = buttonX - (textWidth(txt)/2);
      float x2 = buttonX + (textWidth(txt)/2);
      line (x1, buttonY + 8, x2, buttonY + 8);
    }
  }

  void create() {

    fill(colorBg);
    stroke(btnIsHover ? colorOnHover : colorOff);
    if(currentlyPlayed) stroke(colorOnHover);
    strokeWeight(1.4);
    ellipse(buttonX, buttonY, diameter, diameter); //--> Create border

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

      noStroke();
      fill(btnIsHover ? colorOnHover : colorOff);
      if(currentlyPlayed) fill(colorOnHover);
      triangle(xPos[0], yPos[0], xPos[1], yPos[1], xPos[2], yPos[2]);
    }
    //------------------------------------------------> Pause button
    if (typeOfButton == 4) {
      float r = diameter / 2;
      noStroke();
      fill(btnIsHover ? colorOnHover : colorOff);
      rectMode(CENTER);
      rect(buttonX - r/4, buttonY, r/3, r);
      rect(buttonX + r/4, buttonY, r/3, r);
    }
  }

  void update() {
    btnIsHover = hoverBtn();
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

  void setButtonTxt(String t) {
    txt = t;
  }
}
