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
int buttonCounter = 0; // --> count each click on evolution button

Population pop;
ArrayList <Genotype> genotype = new ArrayList<Genotype>();

void setup() {

  size(250, 825);
  int w = displayWidth - width;
  int h = displayHeight - height;
  surface.setLocation(w - width/8, h/2);

  background(0);

  systemID = int(ProcessHandle.current().pid());
  systemIDtoText = str(systemID);
  println("System ID: " + systemIDtoText);

  //------------------------------------------------> Interface buttons
  btnTxt[0] = "Create population";
  btnTxt[1] = "Indiv. missing? Press here";
  btnTxt[2] = "Run original sketch";

  btnHeight = height * 0.9;
  b[0] = new Button(width/2, btnHeight - 10, 200, 40, btnTxt[0], 1); // --> Creates menu buttons
  b[1] = new Button(width/2, btnHeight + 28, 200, 40, btnTxt[1], 2); // --> Creates menu buttons
  b[2] = new Button(width/2, btnHeight + 58, 200, 40, btnTxt[2], 2); // --> Creates menu buttons

  createSliders(hs);

  //------------------------------------------------> Uploads PDE skecthes
  selectInput("Select a file to process:", "fileSelected");

  pop = new Population();
}


void draw() {

  background(0);
  //------------------------------------------------> Interface
  titleElements(font, groteskSemi, 24, "Evolving 1.4", 35);
  titleElements(font, groteskRegular, 14, "Generation " + pop.getGenerations() + ".", height * 0.84);
  elements(font, groteskRegular, 14, "Fitness Score", width/2, 70);

  sectionLine(height * 0.39);
  elements(font, groteskRegular, 14, "Genetic Operators", width/2, height * 0.42);

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
    titleElements(font, groteskRegular, 12, screenFitness [i], 100 + 20*i);

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

  populationSize = int(hs[0].getOperatorValue());
  eliteSize = int(hs[1].getOperatorValue());
  tournamentSize = int(hs[2].getOperatorValue());
  crossoverRate = float(hs[3].getOperatorValue());
  mutationRate = float(hs[4].getOperatorValue());
}

void mouseReleased() {

  if (!firstMousePress) {
    firstMousePress = true;
  }

  for (int g  = 0; g < b.length; g++) {

    if (b[g].getHover()) {
      if (g == 0) {
        if (buttonCounter == 0) {
          pop.initialize();
          pop.renderPop();
          indivCounter=0;
          ++ buttonCounter;
          delay(1000);
          btnTxt[0] = "Next Generation";
          println("-------------");
        } else {
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
          println("-------------");
        }
      } else if (g == 1) {
        pop.reRenderIndiv();
      } else if (g == 2) {
        int tabIndex = matcher(path, "/");
        String str = path.substring(0, tabIndex);
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
      }
    }
  }
}

//------------------------------------------------> Method to close all open windows
void exit() {
  exitSketch = "2";
  sketches.serverShutdown();
  thread("exitDelay");
  //IDEIA (quando fecha os sistema, abrir pasta com as populações exportadas)
}

void exitDelay() {
  delay(1500);
  System.exit(0);
}
