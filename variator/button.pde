//------------------------------------------------> Buttons
Button [] b  = new  Button [3]; //--> Array of button objects
float btnHeight = 480; //--> First button yPos on screen
String [] btnTxt = new String [3];

class Button {

  float buttonX, buttonY, buttonW, buttonH;
  String txt;

  boolean btnIsHover = false;

  Button(float x, float y, float w, float h, String t) {
    buttonX = x;
    buttonY = y;
    buttonW = w;
    buttonH = h;
    txt = t;
  }

  void create(PFont btnFont, String path) {

    stroke(255);
    strokeWeight(1.7); //--> Adjust the button stroke weight

    fill(btnIsHover ? 255 : 0);

    rectMode(CENTER);
    rect(buttonX, buttonY, buttonW, buttonH);

    fill(btnIsHover ? 0 : 200);

    btnFont = createFont(path, 100);
    textFont(btnFont);
    textSize(14);
    textAlign(CENTER);
    text(txt, buttonX, buttonY + 5);
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
}
