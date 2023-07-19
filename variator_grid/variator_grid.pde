/**
 
 Towards Automated Generative Design, Variator version 1.5
 Ricardo Sacadura advised by Penousal Machado and Tiago Martins (july 2023)
 Last feature: Choose witch parameters to evolve within the parameter scope (16th july)
 --------------
 A. Main system (grid display version)
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

  size(275, 850);
  int w = displayWidth - width;
  int h = displayHeight - height;
  surface.setLocation(w - width/8, h/2);

  h1Type    = fontList[chooseType("Anthony")];
  textType  = fontList[chooseType("SpaceGrotesk-Regular")];
  notesType = fontList[chooseType("SpaceGrotesk-Regular")];

  background(0);

  //------------------------------------------------> Info. on system process pid (debug)
  systemID = int(ProcessHandle.current().pid());
  systemIDtoText = str(systemID);
  println("System ID: " + systemIDtoText);

  //------------------------------------------------> Interface buttons and sliders
  btnTxt[0] = "Create population";
  btnTxt[1] = "Indiv. missing? Press here";
  btnTxt[2] = "Run original sketch";

  btnHeight = height * 0.9;
  b[0] = new Button(width/2, btnHeight - 15, 175, 40, btnTxt[0], 1); // --> Creates menu buttons
  b[1] = new Button(width/2, btnHeight + 28, 150, 20, btnTxt[1], 2); // --> Creates menu buttons
  b[2] = new Button(width/2, btnHeight + 54, 100, 20, btnTxt[2], 2); // --> Creates menu buttons

  t = new ToggleButton(width/12 + 15, 101); //--> Toggle Button between Fitness and Parameters

  createSliders(hs);

  //------------------------------------------------> Uploads PDE skecthes
  selectInput("Select a file to process:", "fileSelected");

  pop = new Population();
}


void draw() {

  background(0);
  //------------------------------------------------> Interface
  h1(font, h1Type, 34, "Ex-Machina", 40);
  //---------------
  if (dist(mouseX, mouseY, width/2, 70) < 50) {
    h1(font, textType, 14, "Generation " + pop.getGenerations() + ".", 70);
  } else {
    h1(font, h1Type, 20, "Generation " + pop.getGenerations() + ".", 70); //height * 0.83
  }

  //------------------------------------------------> Displays parameters
  if (!isToggled) {

    elements(font, textType, 14, "Parameters", width/2, 105, 200);
    int i = 0;
    for (pamRefined pam : pamRefined) {
      String parameterText = pam.name.substring(2);
      textAlign(CORNER);

      String [] ld = split(pam.limits, ' ');
      //---------------> Interface design
      String [] t1 = split(ld[0], ':');
      String min = t1[0] + ": " + t1[1];
      //---------------
      String [] t2 = split(ld[1], ':');
      String max = t2[0] + ": " + t2[1];
      //---------------> Interface design
      isClicked.append(1);
      cb.add(new CircleButton(width - width/12 - 5, 130 + 25*i, isClicked.get(i)));
      cb.get(i).create();

      if (cb.get(i).getClicked() == 0) {
        elements(font, textType, 12, parameterText, width/12, 135 + 25*i, 100);
        elements(font, textType, 12, min, width * 0.4, 135 + 25*i, 100);
        elements(font, textType, 12, max, width * 0.65, 135 + 25*i, 100);
      } else {
        elements(font, textType, 12, parameterText, width/12, 135 + 25*i, 200);
        elements(font, textType, 12, min, width * 0.4, 135 + 25*i, 200);
        elements(font, textType, 12, max, width * 0.65, 135 + 25*i, 200);
      }
      i++;
    }
    //------------------------------------------------> Displays fitness score
  } else {
    elements(font, textType, 14, "Fitness Score", width/2, 105, 200);

    String [] screenFitness = new String [populationSize];

    for (int i = 0; i < populationSize; i++) { //--> Fitness viz.
      String rawFitness = sketches.serverFitness().get("indiv_"+nf(i, 3));
      screenFitness [i] = "Individual "+ nf(i, 3) + " - " + rawFitness;
      if (i<10) h1(font, textType, 12, screenFitness [i], 135 + 25*i);
    }
  }
  //---------------
  sectionLine(height * 0.47);
  //---------------
  textAlign(CENTER);
  //elements(font, textType, 14, "Genetic Operators", width/2, height * 0.42, 200);

  t.create();

  int inc = 0;
  for (Button button : b) {

    button.update();
    if (inc == 0) {
      button.create(font, textType);
    } else {
      button.create(font, notesType);
    }

    inc++;
  }

  for (int j = 0; j < hs.length; j++) {
    hs[j].update();
    hs[j].display();
  }

  //------------------------------------------------> Fitness assignment.
  for (int i = 0; i < populationSize; i++) {

    String rawFitness = sketches.serverFitness().get("indiv_"+nf(i, 3));

    if (rawFitness != null) {
      float fitness = float(rawFitness);
      pop.getIndiv(i).setFitness(fitness); //--> Assign fitness score to each indiv.
    }
  }

  //------------------------------------------------> Communication between sketches
  sketches.listenMain();
  sketches.sketchesLocation();
  sketches.serverFitness();

  //------------------------------------------------> Genetic operators dynamic assignment
  populationSize = int(hs[0].getOperatorValue());
  eliteSize = int(hs[1].getOperatorValue());
  tournamentSize = int(hs[2].getOperatorValue());
  crossoverRate = float(hs[3].getOperatorValue());
  mutationRate = float(hs[4].getOperatorValue());
}

void mouseReleased() {

  t.isHover();

  for (CircleButton c : cb) {
    c.isClicked();
  }


  if (!firstMousePress) {
    firstMousePress = true;
  }

  for (int g  = 0; g < b.length; g++) {

    if (b[g].getHover()) {
      //------------------------------------------------> Evolution button
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
      }
      //------------------------------------------------> Debug button
      else if (g == 1) {
        pop.reRenderIndiv();
      }
      //------------------------------------------------> Run org. button
      else if (g == 2) {
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
  //$$[Further development here] On exit, opens folder with exported pop(s).
}

void exitDelay() {
  delay(1500);
  System.exit(0);
}
