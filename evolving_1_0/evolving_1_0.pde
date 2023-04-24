// "Towards Automated Generative Design", Evolving 1.0 - user-guided fitness assignment + mutation operator, Ricardo Sacadura

import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map;

ArrayList <Server> servers = new ArrayList<Server>(); //--> ArrayList of Servers for each individual
Client v_m;

int [] orgSize = new int[2];
int sketchW, sketchH;

String inputSketch [] = {"/n"};
String original [] = {"/n"};
String path = "/n";
String orgPath = "/n";

File selection;

int counter=0; // --> global variable for variations & servers labelling
int popCounter = -1;

Main m = new Main();
serverListener s = new serverListener();
Button [] b  = new  Button [4]; // --> Array of button objects

PFont font;
String SGrotesk_SemiBold = "data/SpaceGrotesk-SemiBold.ttf";
String SGrotesk_Regular  = "data/SpaceGrotesk-Regular.ttf";

float btn_height = 420; // --> Firts button y-pos on screen
String [] btn_txt = new String [4];

//--> Operators
int populationSize = 8;
float mutationRate;

HashMap<String, Integer> window = new HashMap<String, Integer>();
int c= 0;

void setup() {

  size(300, 650);
  surface.setLocation(displayWidth - (displayWidth/4), displayHeight/7);
  //pixelDensity(2);
  background(255);

  titleElements(font, SGrotesk_SemiBold, 24, "Evolving 1.0", 35);

  //-----------------//
  btn_txt [0] = "Run my sketch (opcional)";
  btn_txt [1] = "Create population (1)";
  btn_txt [2] = "Run current generation (2)";
  btn_txt [3] = "Next generation (3)";

  for (int u  = 0; u < b.length; u++) {
    b[u] = new Button(width/2, btn_height, 250, 40, btn_txt[u]); // --> menu buttons init
    btn_height += 60;
  }

  // --> .pde skecthes extraction
  selectInput("Select a file to process:", "fileSelected");
}

void draw() {

  for (Button button : b) {
    button.update(mouseX, mouseY);
    button.create(font, SGrotesk_Regular);
  }

  s.listenStatus();
  s.serverPrint();
}

void mousePressed() {

  for (int g  = 0; g < b.length; g++) {

    if (b[g].getHover() == true) {
      //-----------------//
      if (g==0) { // --> RUN ORIGINAL SKETCH
        String str = "/Users/ricardosacadura/faculdade/quinto_ano/Tese/towards-automated-generative-design/evolving_1_0/input/circles";
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
        //-----------------//
      } else if (g == 1) {  // --> CREATE INITIAL POPULATION
        popCounter ++;
        int iteration [] = new int [populationSize];
        for (int v : iteration) {
          servers.add(new Server(this, 3000 + counter)); // --> assigning new server each iteration
          m.manipulator();  // --> input values to random values between established boundaries
          m.set_grid();
          m.injectorA(counter); // --> Client-Server injection code entries
          m.injectorB(); // --> vartiated values injection
          m.modifiedSketch(counter); // --> modified sketch exportation gathering all changes
          counter++;
          //-----------------//
          //m.concatenator(file_1, file_2); // --> Necessary to return to org sketch each iteration
          inputSketch=original;
        }
        titleElements(font, SGrotesk_Regular, 14, "Gen."+ popCounter + "  Pop. Size " + populationSize, 85);
        //-----------------//
      } else if (g==2) {  // --> RUN CURRENT GENERATION
        m.run_sketch(counter); // --> Execute modified sketches in separate windows
      } else if (g==3) {  // --> NEXT GENERATION

        background(255);
        titleElements(font, SGrotesk_SemiBold, 24, "Variator", 35);
        titleElements(font, SGrotesk_Regular, 14, "Evolving 1.0", 60);
        elements(font, SGrotesk_SemiBold, 14, "Fittest candidates:", width/2, 120);
        titleElements(font, SGrotesk_Regular, 14, "Gen."+ popCounter + "  Pop. Size " + populationSize, 85);

        c=0;

        for (Map.Entry me : window.entrySet()) {
          if (me.getValue().equals(1)) {
            String object = me.getKey().toString();
            titleElements(font, SGrotesk_Regular, 14, object, 160 + c*40);
            c += 1;
          }
        }
      }
    }
  }
}

// --> Title elements function

void titleElements (PFont title, String font_path, int size, String text, float yPos) {
  title = createFont(font_path, 100);
  fill(0);
  textAlign(CENTER);
  textFont(title);
  textSize(size);
  text(text, width/2, yPos);
}

void elements (PFont title, String font_path, int size, String text, float xPos, float yPos) {

  title = createFont(font_path, 100);
  fill(0);
  textAlign(CENTER);
  textFont(title);
  textSize(size);
  text(text, xPos, yPos);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    original = loadStrings(selection.getAbsolutePath());
    inputSketch = original;
    path = selection.getAbsolutePath();
    orgPath = selection.getAbsolutePath();
    m.extractor(); // --> parameter extraction
    orgSize = m.getSketchSize();
    sketchW = orgSize[0];
    sketchH = orgSize[1];
    //println("User selected " + path);
  }
}
