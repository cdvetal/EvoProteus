import processing.pdf.*;
/**
 * Bezier.
 *
 * The first two parameters for the bezier() function specify the
 * first point in the curve and the last two parameters specify
 * the last point. The middle parameters set the control points
 * that define the shape of the curve.
 */

float __a = 100; // min:20 max:200
float __b = 240; // min:10 max:300
float __c = 20; // min:10 max:150
float __d = 8.0; // min:1.0 max:32.0
float __e = 16.0; // min:1.0 max:50.0
float __f = 200; // min:30 max:500

void setup() {
  size(340, 260);
  beginRecord(PDF, "frame.pdf");
  stroke(255);
  noFill();
}

void draw() {
  background(0);
  for (int i = 0; i < __f; i += 20) {
    bezier(mouseX-(i/2.0), 40+i, 210, __c, __b, __a, 140-(i/__e), 200+(i/__d));
  }
}

void keyReleased() {
  if (key == 'a') endRecord();
}
