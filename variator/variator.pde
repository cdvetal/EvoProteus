// "Towards Automated Generative Design", Evolving 1.4 - user-guided fitness assignment + genetic operators + control panel
// Ricardo Sacadura, Master Degree in Design and Multimedia, 2023

import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map; //--> HashMap Library

// --> Interface typeface
PFont font;
String[] fontList = PFont.list();
String SGrotesk_SemiBold = fontList[2582];
String SGrotesk_Regular  = fontList[2581];

// --> Server architeture utilities
Client v_m;
ArrayList <Server> servers = new ArrayList<Server>(); //--> ArrayList of Servers for each individual;
serverListener s = new serverListener();
String exitSketch = "1"; //--> Sent to population for extinguish purposes
HashMap<String, Integer> windowStatus = new HashMap<String, Integer>();
int hIncrement= 20;

// --> Server architeture utilities (Control Panel)
Client v_c;
Server v = new Server(this, 12345);
serverListener controlPanel = new serverListener();
String [] panelValues = new String[5];

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


//------------------------------------------------> !GENETIC OPERATORS!
Population pop;
int popCounter = 0; // --> counting each generation

//--> Parametrization
int populationSize = 1;
float mutationRate = 0.3;
float crossoverRate = 0.7;
int tournamentSize = 3;
int eliteSize = 1;
//--> Parametrization

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
  background(0);

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

  String path = sketchPath("controls");
  exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");
}


void draw() {

  background(0);

  titleElements(font, SGrotesk_SemiBold, 24, "Evolving 1.4", 35);
  titleElements(font, SGrotesk_Regular, 14, "Gen." + pop.getGenerations() + "  Pop. Size. " + populationSize, 65);
  elements(font, SGrotesk_Regular, 14, "Fitness Score", width/2, 100);

  for (Button button : b) {
    button.update(mouseX, mouseY);
    button.create(font, SGrotesk_Regular);
  }

  for (int i = 0; i < populationSize; i++) {

    String [] screenFitness = new String [populationSize];
    String rawFitness = s.serverFitness().get("indiv_"+nf(i, 3));

    screenFitness [i] = "indiv_"+ nf(i, 3) + " - " + rawFitness;
    titleElements(font, SGrotesk_Regular, 14, screenFitness [i], 130 + hIncrement*i);

    if (rawFitness != null) {
      float fitness = float(rawFitness);
      pop.getIndiv(i).setFitness(fitness);
    }
  }

  s.listenStatus();
  //s.serverPrint();
  s.serverFitness();

  controlPanel.listenValues();

  if (panelValues != null) {
    try {
      populationSize = int(panelValues[0]);
      eliteSize = int(panelValues[1]);
      tournamentSize = int(panelValues[2]);
      mutationRate = float(panelValues[3]);
      crossoverRate = float(panelValues[4]);
    }
    catch(Exception exc) {
    }
  }
}

void mouseReleased() {

  for (int g  = 0; g < b.length; g++) {

    if (b[g].getHover() == true) {
      //-----------------//
      if (g==0) { // --> RUN ORIGINAL SKETCH
        int tabIndex = matcher(path, "/");
        String str = path.substring(0, tabIndex);
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
        //-----------------//
      } else if (g == 1) {  // --> CREATE & RUN INITIAL POPULATION
        pop.initialize();
        pop.renderPop();
        indivCounter=0;
        //-----------------//
      } else if (g==2) {  // --> EVOLVE
        delay(1000);
        /*---------------*/
        counterGridX = 0;
        counterGridY = 0;
        pop.evolve();
        pop.renderPop();
        /*---------------*/
        indivCounter=0;
        exitSketch = "2";
        s.serverShutdown();
        exitSketch = "1";
      }
    }
  }
}
