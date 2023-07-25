// --> Example for 'add to favourite' feature integration.


PFont font;
String[] fontList = PFont.list();
String textType;


boolean pressed = false;
int opacity = 0;
int startTime = 0;
int interval = 1500;

void setup() {
  size(300, 300);

  textType = fontList[chooseType("SpaceGrotesk-Regular")];
  font = createFont(textType, 12);
}

void draw () {
  background(255);

  if (pressed) {
    if (startTime == 0) startTime = millis();
    favComponent();
    pressed = false;
  }
}

void mouseReleased() {
  pressed = true;

  opacity = 0;
  startTime = 0;
}

void heart(float x, float y, float size) {
  beginShape();
  vertex(x, y);
  bezierVertex(x - size / 2, y - size / 3, x - size, y + size / 3, x, y + size);
  bezierVertex(x + size, y + size / 3, x + size / 2, y - size / 3, x, y);
  endShape(CLOSE);
}

void favComponent () {

  int maxOpacity = 200;

  if (opacity < maxOpacity && millis() - startTime < interval) {
    opacity += 10;
  } else if (opacity > 0) {
    opacity -= 10;
  }

  fill(0, opacity);
  translate(width/2, height/2);
  rectMode(CENTER);
  ellipse(0, 0, width * 0.6, width * 0.6);

  textAlign(CENTER);
  textFont(font);
  fill(255);
  String t = "Added\nto 'favourites' folder";
  textLeading(14);
  text(t, 0, height/12);
  noStroke();
  heart(0, -height/7, 40);
}

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
