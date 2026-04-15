/*
 Series of computational abstractions of artefacts depicted
 in Armin Hofmann's "Methodik Der Form - Und Bildgestaltung"
 
 No.4 The Line (From the book, page 112, figures 135)
 
 Ricardo Sacadura (2024)
 */

float alpha = 250;
int randomIndex;
int __index = 50; //min:0 max:100
int __numTiles = 10; //min:20 max:40
int __constrainMin = 0; //min:0 max:50
int __constrainMax = 255; //min:200 max:255
float __variance = 0.5; //min:0 max:0.7
int __varLow = 10; //min:10 max:25
int __varHigh = 100; //min:25 max:100
float [] alphaTiles;
float [] widths;
int counter = 0;


PImage t;

void setup() {
  size(500, 500);
  createComposition(__numTiles);
}

void draw() {
}

void keyPressed() {
  if (key == 'a') {
    ++__numTiles;
    background(255);
    createComposition(__numTiles);
    saveFrame("gen_"+nf(counter, 3)+".png");
    ++counter;
  }
  if (key == 's') {
    --__numTiles;
    background(255);
    createComposition(__numTiles);
    saveFrame("gen_"+nf(counter, 3)+".png");
    ++counter;
  }
}

void createComposition(float nt) {
  // Step 1: Generate random widths for each rectangle
  widths = new float[int(nt)];
  float totalWidth = 0;

  for (int i = 0; i < nt; i++) {
    widths[i] = random(__varLow, __varHigh); // Random initial widths, you can tweak these values for more or less variation
    totalWidth += widths[i];
  }

  // Step 2: Normalize widths so that they sum up to the screen width (500)
  float scaleFactor = 500 / totalWidth;
  for (int i = 0; i < nt; i++) {
    widths[i] *= scaleFactor;
  }

  // Step 3: Set up the alphaTiles array
  alphaTiles = new float[int(nt)];
  randomIndex = int(map(__index, 0, 100, 1, nt - 1));

  alphaTiles[randomIndex] = 5;
  alphaTiles[max(0, randomIndex - 1)] = 255;
  alphaTiles[min(int(nt) - 1, randomIndex + 1)] = 255;

  alpha = 250;

  for (int i = 0; i < randomIndex - 1; i++) {
    alphaTiles[i] = constrain(alpha, __constrainMin, __constrainMax);
    float d = alpha / randomIndex;
    alpha -= d;
  }

  alpha = 250;
  for (int i = randomIndex + 1; i < nt; i++) {
    alphaTiles[i] = constrain(alpha, __constrainMin, __constrainMax);
    float d = alpha / (nt - randomIndex - 1);
    alpha -= d;
  }

  // Step 4: Draw the rectangles with the calculated widths
  float xOffset = 0;
  for (int i = 0; i < nt; i++) {
    strokeWeight(0.05);
    stroke(0, alphaTiles[i]);
    fill(0, alphaTiles[i]);
    xOffset += __variance * randomGaussian();
    rect(xOffset, 0, widths[i], height);
    xOffset += widths[i]; // Move the x position for the next rectangle
  }

  alpha = 250;

  println("Widths of each tile: ", widths);
  println("Number of tiles: ", nt);
}
