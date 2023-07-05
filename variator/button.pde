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

  void create(PFont btn_font, String path) {

    stroke(255);
    strokeWeight(1.7);
    if (btnIsHover ==true) {
      fill(255);
    } else {
      fill(0);
    }
    rectMode(CENTER);
    rect(buttonX, buttonY, buttonW, buttonH);

    if (btnIsHover ==true) {
      fill(0);
    } else {
      fill(200);
    }

    btn_font = createFont(path, 100);
    textFont(btn_font);
    textSize(14);
    textAlign(CENTER);
    text(txt, buttonX, buttonY + 5);
  }

  void update(float x, float y) {
    if (hoverBtn()) {
      btnIsHover = true;
    } else {
      btnIsHover = false;
    }
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
