// ------------------> Interface font config.
PFont font;
String[] fontList = PFont.list();
String groteskSemi = fontList[2582];
String groteskRegular  = fontList[2581];

// --> Title elements method
void titleElements (PFont typeface, String fontPath, int size, String text, float yPos) {
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

// -->  Detects x char occurrences on a string
int matcher(String in, String find) {
  int index = 0;
  int last = -1;
  while (index != -1) {
    index = in.indexOf(find, last+1);
    if ( index != -1 ) last = index;
  }
  return last;
}
