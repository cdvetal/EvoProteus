class Button {

  float button_x, button_y, button_w, button_h;
  String txt;

  boolean btnIs_hover = false;

  Button(float x, float y, float w, float h, String t) {
    button_x = x;
    button_y = y;
    button_w = w;
    button_h = h;
    txt = t;
  }

  void create(PFont btn_font, String path) {

    stroke(0);
    strokeWeight(0.7);
    if (btnIs_hover ==true) {
      fill(0);
    } else {
      fill(255);
    }
    rectMode(CENTER);
    rect(button_x, button_y, button_w, button_h);

    if (btnIs_hover ==true) {
      fill(255);
    } else {
      fill(0);
    }

    btn_font = createFont(path, 100);
    textFont(btn_font);
    textSize(14);
    textAlign(CENTER);
    text(txt, button_x, button_y + 5);
  }

  void update(float x, float y) {
    if (hover_btn()) {
      btnIs_hover = true;
    } else {
      btnIs_hover = false;
    }
  }

  boolean hover_btn() {

    if (mouseX >= button_x - button_w/2 && mouseX <= button_x + button_w / 2 &&
      mouseY >= button_y - button_h /2 && mouseY <= button_y+ button_h /2) {
      return true;
    } else {
      return false;
    }
  }

  boolean get_hover() {
    return btnIs_hover;
  }
}
