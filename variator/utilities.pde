// ------------------> Interface font config.
PFont font;
String[] fontList = PFont.list();
String grotesk_semi = fontList[2582];
String grotesk_regular  = fontList[2581];

// --> Title elements method
void titleElements (PFont typeface, String font_path, int size, String text, float yPos) {
  typeface = createFont(font_path, 100);
  fill(200);
  textAlign(CENTER);
  textFont(typeface);
  textSize(size);
  text(text, width/2, yPos);
}

// --> Text elements method
void elements (PFont typeface, String font_path, int size, String text, float xPos, float yPos) {
  typeface = createFont(font_path, 100);
  fill(200);
  textAlign(CENTER);
  textFont(typeface);
  textSize(size);
  text(text, xPos, yPos);
}

// -->  Detects x char occurrences on a string
int matcher(String in, String find) {
  int index = 0;
  int last = -1;
  while (index != -1) {
    index = in.indexOf(find, last+1);
    if ( index != -1 ) {
      println(index);
      last = index;
    }
  }
  return last;
}
