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
  line (width/8, y, width - width/8, y);
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
