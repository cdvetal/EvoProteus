/**
 
 Towards Automated Generative Design, Variator version 1.4
 Ricardo Sacadura advised by Penousal Machado and Tiago Martins (july 2023)
 Last feature: Fitness score based on position (10th july)
 --------------
 A. Main system
 --------------
 User guide
 1.  Create a sketch in processing;
 2.  Choose the set of parameters you want to evolve;
 3.  Tag those parameters with our markup language;
 Example:
 Original variable -> int radius = 0;
 Marked-up variable -> int __radius = 10; //min:0 max:50
 (only initializations are read by the system)
 4.  Run Variator and upload your sketch;
 5.  Explore.
 (all variated sketches will be stored -> 'variations' folder)
 
 */

//------------------------------------------------> Global counters
int counter=0; // --> label servers
int indivCounter=0; // --> label indiv.
int popCounter = 0; // --> count each generation

Population pop;
ArrayList <Genotype> genotype = new ArrayList<Genotype>();

void setup() {
  size(250, 800);
  int w = displayWidth - width;
  int h = displayHeight - height;
  surface.setLocation(w - width/8, h/2);
  surface.setResizable(true);

  background(0);

  systemID = int(ProcessHandle.current().pid());
  systemIDtoText = str(systemID);
  println("System ID: " + systemIDtoText);

  //------------------------------------------------> Interface buttons
  btnTxt [0] = "Run my sketch (opcional)";
  btnTxt [1] = "Create population (1)";
  btnTxt [2] = "Next generation (2)";

  for (int u  = 0; u < b.length; u++) {
    b[u] = new Button(width/2, btnHeight, 200, 40, btnTxt[u]); // --> Creates menu buttons
    btnHeight += 60;
  }

  createSliders(hs);

  //------------------------------------------------> Uploads PDE skecthes
  selectInput("Select a file to process:", "fileSelected");

  //------------------------------------------------> Runs control-panel
  String path = sketchPath("controls");
  //exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");

  pop = new Population();
}


void draw() {
  background(0);

  //------------------------------------------------> Interface
  titleElements(font, groteskSemi, 24, "Evolving 1.4", 35);
  titleElements(font, groteskRegular, 14, "Gen." + pop.getGenerations() + "  Pop. Size. " + populationSize, 65);
  elements(font, groteskRegular, 14, "Fitness Score", width/2, 100);

  sectionLine(height * 0.45);
  elements(font, groteskRegular, 14, "Genetic Operators", width/2, height * 0.48);

  for (Button button : b) {
    button.update();
    button.create(font, groteskRegular);
  }

  for (int j = 0; j < hs.length; j++) {
    hs[j].update();
    hs[j].display();
  }

  //------------------------------------------------> Fitness viz.
  for (int i = 0; i < populationSize; i++) {

    String [] screenFitness = new String [populationSize];
    String rawFitness = sketches.serverFitness().get("indiv_"+nf(i, 3));

    screenFitness [i] = "Individual "+ nf(i, 3) + " - " + rawFitness;
    titleElements(font, groteskRegular, 14, screenFitness [i], 130 + 20*i);

    if (rawFitness != null) {
      float fitness = float(rawFitness);
      pop.getIndiv(i).setFitness(fitness);
    }
  }

  //------------------------------------------------> Communication between sketches
  sketches.listenStatus();
  //sketches.serverPrint();
  sketches.serverFitness();
  sketches.sketchesLocation();

  controlPanel.listenValues();

  if (panelValues != null) {  //--> Gathers info. on the parametrization
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

  if (!firstMousePress) {
    firstMousePress = true;
  }


  for (int g  = 0; g < b.length; g++) {

    if (b[g].getHover()) {
      if (g == 0) { //------------------------------------------------> (optional) Runs original sketch
        int tabIndex = matcher(path, "/");
        String str = path.substring(0, tabIndex);
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
      } else if (g == 1) { //------------------------------------------------> (1) Creates and runs initial pop.
        pop.initialize();
        pop.renderPop();
        indivCounter=0;
      } else if (g == 2) { //------------------------------------------------> (2) Evolves
        delay(1000);
        sketchesName.clear();
        healthySketchesID.clear();
        zombieSketch.clear();

        counterGridX = 0;
        counterGridY = 0;

        pop.evolve();
        pop.renderPop();
        indivCounter=0;

        exitSketch = "2";
        sketches.serverShutdown();
        exitSketch = "1";
      }
    }
  }
}

void keyReleased() {
  if (key == ' ') {
    pop.reRenderIndiv();
    //println("SketchesName: " + sketchesName);
  }
}

//------------------------------------------------> Method to close all open windows
void exit() {
  exitSketch = "2";
  sketches.serverShutdown();
  serverPanel.write(exitSketch);
  thread("exitDelay");
}

void exitDelay() {
  delay(1500);
  System.exit(0);
}
