//Sketch "Hello Harmonograph" by Tiago Martins for SPECIES Summer School 2023.
//Parameters adjusted for EvoProteus.

float __p1 = 0.317; //min:0 max:1
float __p2 = 0.275; //min:0 max:1
float __p3 = 0.018; //min:0 max:1
float __p4 = 0.213; //min:0 max:1
float __p5 = 0.110; //min:0 max:1
float __p6 = 0.406; //min:0 max:1
float __p7 = 0.555; //min:0 max:1
float __p8 = 0.095; //min:0 max:1
float __p9 = 0.448; //min:0 max:1
float __p10 = 0.512; //min:0 max:1
float __p11 = 0.156; //min:0 max:1
float __p12 = 0.472; //min:0 max:1
float __p13 = 0.080; //min:0 max:1
float __p14 = 0.037; //min:0 max:1
float __p15 = 0.597; //min:0 max:1
float __p16 = 0.448; //min:0 max:1
float __p17 = 0.723; //min:0 max:1
float __p18 = 0.249; //min:0 max:1
float __p19 = 0.598; //min:0 max:1
float __p20 = 0.824; //min:0 max:1



void setup() {

  size(300, 300);
  smooth(8);
  background(255);


  // Array with the normalised values of the harmonograph parameters
  // All values in this array are in the range [0, 1].
  float[] params = {__p1, __p2, __p3, __p4, __p5, __p6, __p7, __p8, __p9, __p10,
    __p11, __p12, __p13, __p14, __p15, __p16, __p17, __p18, __p19, __p20};

  // Individual variables for the harmonograph parameters.
  // The values of the parameters are now in different ranges.
  float a1 = width * (0.15 + 0.1 * params[0]); // amplitude 1
  float a2 = width * (0.15 + 0.1 * params[1]); // amplitude 2
  float a3 = height * (0.15 + 0.1 * params[2]); // amplitude 3
  float a4 = height * (0.15 + 0.1 * params[3]); // amplitude 4
  float v1 = -0.02 + 0.04 * params[4]; // frequency variation 1
  float v2 = -0.02 + 0.04 * params[5]; // frequency variation 2
  float v3 = -0.02 + 0.04 * params[6]; // frequency variation 3
  float v4 = -0.02 + 0.04 * params[7]; // frequency variation 4
  float f1 = v1 + 1 + int(5 * params[8]); // frequency 1
  float f2 = v2 + 1 + int(5 * params[9]); // frequency 2
  float f3 = v3 + 1 + int(5 * params[10]); // frequency 3
  float f4 = v4 + 1 + int(5 * params[11]); // frequency 4
  float ph1 = TWO_PI * params[12]; // phase 1
  float ph2 = TWO_PI * params[13]; // phase 2
  float ph3 = TWO_PI * params[14]; // phase 3
  float ph4 = TWO_PI * params[15]; // phase 4
  float d1 = 0.01 * params[16]; // damping 1
  float d2 = 0.01 * params[17]; // damping 2
  float d3 = 0.01 * params[18]; // damping 3
  float d4 = 0.01 * params[19]; // damping 4

  float time_max = 300; // max time (length of the line)
  float time_step = 0.05; // time increment (distance between line vertexes)

  // Draw the harmonograph at the centre of the window
  noFill();
  strokeWeight(0.5);
  stroke(255, 90, 10);
  stroke(0);
  translate(width / 2, height / 2);

  beginShape(); // start drawing the line
  for (float t = 0; t< time_max; t += time_step) {
    float x = a1 * sin(t * f1 + ph1) * exp(-d1 * t) + a2 * sin(t * f2 + ph2) * exp(-d2 * t);
    float y = a3 * sin(t * f3 + ph3) * exp(-d3 * t) + a4 * sin(t * f4 + ph4) * exp(-d4 * t);
    vertex(x, y); // add new vertex to the line
  }
  endShape(); // stop drawing the line
}

void draw() {
  /**/
}
