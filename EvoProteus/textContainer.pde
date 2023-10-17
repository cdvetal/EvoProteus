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
