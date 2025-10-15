PImage k2, k3;
PImage[] img;
PFont font;

int __r = 1; // min:1 max:2
int __f = 2; // min:0 max:9

int __blend = 1; //min:0 max:3

int __c = 24; //min:0 max:100
int __a = 146; //min:0 max:200

int __fs = 28; //min:20 max:38

void setup() {
  size(300, 300);
  //pixelDensity(2);

  k2 = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\kafka_proteus\\data\\k2.jpg");
  k2.resize(width, height);

  k3 = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\kafka_proteus\\data\\k3.jpg");
  k3.resize(width, height);

  font = createFont("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\kafka_proteus\\data\\SabonLTStd-Bold.otf", 128);

  img = new PImage[9];

  for (int i = 0; i < img.length; i++) { // Fixed loop
    img[i] = loadImage("C:\\Users\\cdv\\Desktop\\ricardosacadura_research\\Towards-Automated-Generative-Design\\Input Sketches\\kafka_proteus\\data\\"+ i + ".png"); // Adjust if filenames are different
  }

  if (__r == 1) {
    noTint();
    copy(k2, 0, 0, 300, 150, 0, 0, 300, 150);
    copy(k3, 0, 150, 300, 150, 0, 150, 300, 150);
  } else {
    noTint();
    copy(k2, 0, 150, 300, 150, 0, 150, 300, 150);
    copy(k3, 0, 0, 300, 150, 0, 0, 300, 150);
  }

  push();
  if (__blend == 0) {
    blendMode(DARKEST);
  } else if (__blend == 1) {
    blendMode(MULTIPLY);
  } else if (__blend == 2) {
    blendMode(SCREEN);
  } else if (__blend == 3) {
    blendMode(EXCLUSION);
  }
  tint(255, 220);
  image(img[__f], 0, 0, 300, 300);
  pop();

  textFont(font);
  textSize(__fs);
  fill(145, __a, __c);
  text("Franz Kafka", 50, 80);
  text("Die Verwandlung", 50, 180);
}

void draw() {
  
  //
}
