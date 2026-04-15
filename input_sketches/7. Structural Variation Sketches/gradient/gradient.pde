// Rectangle 1 - HSB values
float __h1 = 0;      // min:0 max:360
float __s1 = 100;    // min:0 max:100
float __b1 = 100;    // min:0 max:100

// Rectangle 2 - HSB values
float __h2 = 60; // min:0 max:360
float __s2 = 100; // min:0 max:100
float __b2 = 100; // min:0 max:100

// Rectangle 3 - HSB values
float __h3 = 120; // min:0 max:360
float __s3 = 100; // min:0 max:100
float __b3 = 100; // min:0 max:100

// Rectangle 4 - HSB values
float __h4 = 180; // min:0 max:360
float __s4 = 100; // min:0 max:100
float __b4 = 100; // min:0 max:100

// Rectangle 5 - HSB values
float __h5 = 240; // min:0 max:360
float __s5 = 100; // min:0 max:100
float __b5 = 100; // min:0 max:100

void setup() {
  size(300, 300);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(255);
  noStroke();
  
  float rectWidth = width / 5;
  float rectHeight = height;
  
  // Rectangle 1
  fill(__h1, __s1, __b1);
  rect(0, 0, rectWidth, rectHeight);
  
  // Rectangle 2
  fill(__h2, __s2, __b2);
  rect(rectWidth, 0, rectWidth, rectHeight);
  
  // Rectangle 3
  fill(__h3, __s3, __b3);
  rect(rectWidth * 2, 0, rectWidth, rectHeight);
  
  // Rectangle 4
  fill(__h4, __s4, __b4);
  rect(rectWidth * 3, 0, rectWidth, rectHeight);
  
  // Rectangle 5
  fill(__h5, __s5, __b5);
  rect(rectWidth * 4, 0, rectWidth, rectHeight);
}
