/**
    1.1 Interface design implementation
*/

//------------------------------------------------> Buttons
Button [] b = new Button [3];

float btnHeight = 625; //--> First button yPos on screen
String [] btnTxt = new String [3]; //--> Text for buttons


class Button {

  float buttonX, buttonY, buttonW, buttonH;
  String txt;
  int version;

  boolean btnIsHover = false;

  Button(float x, float y, float w, float h, String t, int v) {
    buttonX = x;
    buttonY = y;
    buttonW = w;
    buttonH = h;
    txt = t;
    version = v;
  }

  void create(PFont btnFont, String path) {

    stroke(255);

    rectMode(CENTER);
    textAlign(CENTER);

    btnFont = createFont(path, 100);
    textFont(btnFont);

    //------------------------------------------------> Button box
    if (version == 1) {

      strokeWeight(1.4); //--> Adjust the button stroke weight
      fill(btnIsHover ? 255 : 0);
      rect(buttonX, buttonY, buttonW, buttonH);

      fill(btnIsHover ? 0 : 200);
      textSize(14);
      setButtonTxt(btnTxt[0]);
      text(txt, buttonX, buttonY + 5);
    } 
    //------------------------------------------------> Underlined button box
    else if (version == 2) {

      strokeWeight(0.5); //--> Adjust the button stroke weight
      fill(btnIsHover ? 255 : 200);

      textSize(10.5);
      text(txt, buttonX, buttonY + 5);
      float x1 = buttonX - (textWidth(txt)/2);
      float x2 = buttonX + (textWidth(txt)/2);
      line (x1, buttonY + 8, x2, buttonY + 8);
    }
  }

  void update() {
    btnIsHover = hoverBtn();
  }

  boolean hoverBtn() {

    if (mouseX >= buttonX - buttonW/2 && mouseX <= buttonX + buttonW / 2 &&
      mouseY >= buttonY - buttonH /2 && mouseY <= buttonY+ buttonH /2) {
      return true;
    } else {
      return false;
    }
  }

  boolean getHover() {
    return btnIsHover;
  }

  void setButtonTxt(String t) {
    txt = t;
  }
}
