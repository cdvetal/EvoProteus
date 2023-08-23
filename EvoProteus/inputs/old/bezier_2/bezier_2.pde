import processing.pdf.*;
float __ampX = 12.0; // min:0.0 max:25.0
float __ampY = 12.0; // min:0.0 max:25.0

float __firstY = 150; // min:0 max:150
float __lastY = 150; // min:0 max:150

float __firstX = 0; // min:0 max:300
float __lastX = 500; // min:250 max:500




void setup() {
  size(400, 150);
  beginRecord(PDF, "frame.pdf");
  background(0);
  noFill();
  stroke(255);
  strokeWeight(0.3);

  // Stop generating after 2 seconds
  new java.util.Timer().schedule(
    new java.util.TimerTask() {
    public void run() {
      noLoop();
    }
  }
  ,
    1500
    );
}

void draw() {
  beginShape();
  vertex(__firstX, __firstY); // Add vertex at the bottom left corner
  for (int x = 0; x <= width; x += 30) {
    float y = noise(x / __ampX, frameCount / __ampY) * height;
    curveVertex(x, y);
  }
  vertex(__lastX, __lastY); // Add vertex at the bottom right corner
  endShape(CLOSE); // Close the shape
}
void keyReleased() {
  if (key == 'a') endRecord();
}

void mouseClicked() {
  // Save a screenshot to the download folder when the user clicks the mouse
  saveFrame("generative-art.png");
}
