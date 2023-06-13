// "Towards Automated Generative Design", Evolving 1.0 - user-guided fitness assignment + mutation operator, Ricardo Sacadura

import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map; //--> HashMap Library

// --> Typeface
PFont font;
String SGrotesk_SemiBold = "data/SpaceGrotesk-SemiBold.ttf";
String SGrotesk_Regular  = "data/SpaceGrotesk-Regular.ttf";

// --> Server architeture utilities
Client v_m;
ArrayList <Server> servers = new ArrayList<Server>(); //--> ArrayList of Servers for each individual;
serverListener s = new serverListener();
String exitSketch = "1"; //--> Sent to population for extinguish purposes
HashMap<String, Integer> windowStatus = new HashMap<String, Integer>();
int hIncrement= 20;

// --> ArrayList of objects
ArrayList<Parameters> parameters = new ArrayList<Parameters>(); //--> Set of parameter extracted from first pop.
ArrayList<pamRefined> pamRefined = new ArrayList<pamRefined>(); //--> Refined set (no outliers)

// --> ArrayList of sketch lines with parameters
IntList sketchLine = new IntList(); //--> Lines w/ identified parameters
IntList sketchLineRefined = new IntList(); //--> Refined lines (no outliers)

String primitivesList [] = {"String", "float", "int", "char", "boolean"}; // --> Listing primitive data types

File selection;

int [] orgSize = new int[2];
int sketchW, sketchH;

// --> Variables to store input sketch information
String inputSketch [] = {"/n"};
String original [] = {"/n"};
String path = "/n";
String orgPath = "/n";
Main m = new Main();//--> Initial input information


// --> Buttons
Button [] b  = new  Button [3]; // --> Array of button objects
float btn_height = 480; // --> Firts button y-pos on screen
String [] btn_txt = new String [3];


//------------------------------------------------> Genetic engine operators and declarations
Population pop;
int popCounter = 0; // --> counting each generation

//--> Settings
int populationSize = 3;
float mutationRate = 0.7;
float crossoverRate;
int tournamentSize;
int eliteSize = 1;
//--> Settings

ArrayList <Genotype> genotype = new ArrayList<Genotype>();
int genCounter = -1;
int numGenes = 0;

int counterGridX = 0, counterGridY=0;

//------------------------------------------------

int counter=0; // --> global variable for population & servers labelling
int indivCounter=0;

void setup() {

  size(300, 650);
  surface.setLocation(displayWidth - (displayWidth/4), displayHeight/7);
  //pixelDensity(2);
  background(255);

  //-----------------//
  btn_txt [0] = "Run my sketch (opcional)";
  btn_txt [1] = "Create population (1)";
  btn_txt [2] = "Next generation (2)";

  for (int u  = 0; u < b.length; u++) {
    b[u] = new Button(width/2, btn_height, 250, 40, btn_txt[u]); // --> menu buttons init
    btn_height += 60;
  }

  // --> .pde skecthes extraction
  selectInput("Select a file to process:", "fileSelected");

  pop = new Population();
}


void draw() {

  background(255);
  titleElements(font, SGrotesk_SemiBold, 24, "Evolving 1.0", 35);
  titleElements(font, SGrotesk_Regular, 14, "Gen." + pop.getGenerations() + "  Pop. Size. " + populationSize, 65);
  elements(font, SGrotesk_Regular, 14, "Fitness Score", width/2, 100);

  for (Button button : b) {
    button.update(mouseX, mouseY);
    button.create(font, SGrotesk_Regular);
  }

  for (int i = 0; i < populationSize; i++) {
    String [] fitness = new String [populationSize];
    fitness [i] = "indiv_"+ nf(i, 3) + " - " + s.serverFitness().get("indiv_"+nf(i, 3));
    titleElements(font, SGrotesk_Regular, 14, fitness [i], 130 + hIncrement*i);
  }

  s.listenStatus();
  s.serverPrint();
  s.serverFitness();
}

void mousePressed() {

  for (int g  = 0; g < b.length; g++) {

    if (b[g].getHover() == true) {
      //-----------------//
      if (g==0) { // --> RUN ORIGINAL SKETCH
        String str = "/Users/ricardosacadura/faculdade/quinto_ano/Tese/towards-automated-generative-design/variator/inputs/circles";
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
        //-----------------//
      } else if (g == 1) {  // --> CREATE & RUN INITIAL POPULATION
        pop.initialize();
        pop.renderPop();
        //-----------------//
      } else if (g==2) {  // --> Evolve
        delay(1000);
        /*---------------*/
        counterGridX = 0;
        counterGridY=0;
        pop.evolve();
        pop.renderPop();
        /*---------------*/
        indivCounter=0;
        exitSketch = "2";
        s.serverShutdown();
        exitSketch = "1";
        //delay(1000);
      }
    }
  }
}

/*------------------------------------------MINOR UTILITIES----------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------*/

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
    orgSize = m.getSketchSize();
    sketchW = orgSize[0];
    sketchH = orgSize[1];
    println("User selected " + path);
  }
}


void serverOpen() {
  servers.add(new Server(this, 3000 + counter)); // --> assigning new server each iteration
  //println(servers);
}
