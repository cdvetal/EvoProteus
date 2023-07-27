ArrayList<Particle> particles;
int[] list;

PVector axis;
//PFont font;
//String[] fontList = PFont.list();
String roboto = fontList[1957];
int __fontSize = 200; // min:100 max:350

int count;
int __max = 200; // min:100 max:750
char typedKey = 'R';

int __fg = 208; // min:100 max:255
int bg = 0;

float __scaleFactorA = 0.35; // min:0.1 max:0.6
float __scaleFactorB = 0.9; // min:0.35 max:1


void setup() {
  size(300, 300);

  frameRate(24);

  noStroke();

  font = createFont(roboto, __fontSize);
  textFont(font);
  fill(bg);

  count = 0;
  textAlign(CENTER, CENTER);
  text(typedKey, width / 2, height / 2);

  list = new int[width * height];

  loadPixels();
  for (int y = 0; y <= height - 1; y++) {
    for (int x = 0; x <= width - 1; x++) {
      color pb = pixels[y * width + x];
      if (red(pb) < 5) {
        list[y * width + x] = 0;
      } else {
        list[y * width + x] = 1;
      }
    }
  }
  updatePixels();

  particles = new ArrayList<Particle>();
}

void draw() {

  if (count < __max) {
    int i = 0;
    while (i < 3) {
      axis = new PVector(int(random(100, width - 100)), int(random(100, height - 100)));
      if (list[int(axis.y * width + axis.x)] == 0) {
        particles.add(new Particle(axis.x, axis.y));
        i++;
        count++;
      }
    }
  }

  background(bg);

  for (int i = 0; i < particles.size(); i++) {
    Particle f = particles.get(i);
    fill(bg);
    f.display();
    f.update();
  }
  for (int j = 0; j < particles.size(); j++) {
    Particle l = particles.get(j);
    fill(__fg);
    l.display2();
    l.update();
  }
}

class Particle {
  PVector location;
  PVector velocity;
  float scale = random(__scaleFactorA, __scaleFactorB);
  int radius = int(scale * 40);

  Particle(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(random(1), random(1));
  }

  void update() {
    location.add(velocity);
    if ((list[int(location.y) * width + int(location.x + velocity.x)] == 1) || (list[int(location.y) * width + int(location.x - velocity.x)] == 1)) {
      velocity.x *= -1;
    }
    if ((list[int(location.y + velocity.y) * width + int(location.x)] == 1) || (list[int(location.y - velocity.y) * width + int(location.x)] == 1)) {
      velocity.y *= -1;
    }
  }

  void display() {
    ellipse(location.x, location.y, radius, radius);
  }

  void display2() {
    ellipse(location.x, location.y, radius - 10, radius - 10);
  }
}
