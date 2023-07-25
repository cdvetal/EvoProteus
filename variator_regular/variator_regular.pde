/**
 
 Towards Automated Generative Design, Variator version 1.8
 Ricardo Sacadura advised by Penousal Machado and Tiago Martins (july 2023)
 Latest feature: Add to favourites folder (24th july)
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
 4.  Make sure your background() assignment is set right after void draw();
 5.  Run Variator and upload your sketch (make sure all code is combined in just 1 file);
 6.  Explore.
 (all variated sketches will be stored at -> 'variations' folder)
 (your favourite ones will be stored at   -> 'favourites' folder)
 
 */

//------------------------------------------------> Global counters
int netCounter = 0; //--> label servers
int indivCounter=0; // --> label indiv.
int popCounter = 0; // --> count each generation
int buttonCounter = 0; // --> count each click on evolution button

boolean iconDisplay = false; //--> View mode
boolean restart = false; //--> Restart button

Population pop;
ArrayList <Genotype> genotype = new ArrayList<Genotype>();

StringList updateParams = new StringList(); // --> Updates evolving parameters list


void setup() {

  size(275, 850);
  int w = displayWidth - width;
  int h = displayHeight - height;
  surface.setLocation(w - width/8, h/2);

  background(colorBg);

  //------------------------------------------------> Sets three typefaces for the interface design (searching through the fontList)
  h1Type    = fontList[chooseType("Anthony")];
  textType  = fontList[chooseType("SpaceGrotesk-Regular")];
  notesType = fontList[chooseType("SpaceGrotesk-Regular")];

  //------------------------------------------------> Info. on system process pid (debug)
  /**
   systemID = int(ProcessHandle.current().pid());
   systemIDtoText = str(systemID);
   println("System ID: " + systemIDtoText);
   //not in use
   */

  //------------------------------------------------> Interface buttons and sliders
  btnTxt[0] = "Create population";
  btnTxt[1] = "Indiv. missing? Press here";
  btnTxt[2] = "Run original sketch";

  btnHeight = height * 0.90;
  b[0] = new Button(width/2, btnHeight - 19, 190, 45, btnTxt[0], 1); // --> Creates menu buttons
  b[1] = new Button(width/2, btnHeight + 30, 150, 20, btnTxt[1], 2); // --> Creates menu buttons
  b[2] = new Button(width/2, btnHeight + 56, 100, 20, btnTxt[2], 2); // --> Creates menu buttons

  t = new ToggleButton(width/12 + 15, 101); //--> Toggle Button between Fitness and Parameters

  createSliders(hs); //--> Sliders / Genetic operators

  //------------------------------------------------> Uploads your PDE sketchfile
  selectInput("Select a file to process:", "fileSelected");

  //------------------------------------------------> Sets a population to evolve
  pop = new Population();
}


void draw() {

  background(colorBg);

  //------------------------------------------------> Interface
  h1(font, h1Type, 34, "Variator", 40); //--> Title

  String type = (dist(mouseX, mouseY, width/2, 70) < 50) ? textType : textType;
  int f = (dist(mouseX, mouseY, width/2, 70) < 50) ? 14 : 14;
  elements(font, type, f, "Gen. " + pop.getGenerations(), width/2 - 60, 70, colorLetters); //--> No. Generations


  //--> Restart button init.
  boolean onHoverRestart = dist(mouseX, mouseY, width/2 + 60, 70) < 20 ? true : false;
  int colorRestart = onHoverRestart ? colorOnHover : colorLetters;
  elements(font, type, f, "Restart", width/2 + 60, 70, colorRestart); //--> Restart Generation


  if (iconDisplay) {
    sunIcon(width - width/12 - 5, 100, 4);
    colorLetters = 60;
    colorBg = 255;
    colorStrokes = 60;
    colorOnHover = 0;
    colorOff = 170;
  } else {
    moonIcon(width - width/12 - 5, 100, 6);
    colorLetters = 200;
    colorBg = 10;
    colorStrokes = 200;
    colorOnHover = 255;
    colorOff = 80;
  }

  t.create(); //--> Renders toggle button

  //------------------------------------------------> Displays parameters
  if (!isToggled) {

    elements(font, textType, 14, "Parameters", width/2, 105, colorLetters);
    int i = 0;
    for (pamRefined pam : pamRefined) {
      String parameterText = pam.name.substring(2);

      textAlign(CORNER);

      String [] ld = split(pam.limits, ' ');
      //---------------> Interface design
      String [] t1 = ld[0].length() > 0 ? split(ld[0], ':') : split(ld[1], ':');
      String min = t1[0] + ": " + t1[1];
      //---------------
      String [] t2 = ld[1].length() > 0 ? split(ld[1], ':') : split(ld[2], ':');
      String max = t2[0] + ": " + t2[1];
      //---------------> Interface design
      cb.get(i).create();

      colorPams = cb.get(i).getClicked() == 0 ? colorOff : colorLetters;
      elements(font, textType, 12, parameterText, width/12, 135 + 25*i, colorPams);
      elements(font, textType, 12, min, width * 0.4, 135 + 25*i, colorPams);
      elements(font, textType, 12, max, width * 0.65, 135 + 25*i, colorPams);

      //------------------------------------------------> Updates variable parameters list based on user interaction
      if (cb.get(i).getClicked() == 0) {
        updateParams.set(i, str(i)); // --> Stores off parameter index
      } else {
        if (str(i).equals(updateParams.get(i))) updateParams.set(i, "a");
      }
      ++ i;
    }
    //------------------------------------------------> Displays fitness score
  } else {
    elements(font, textType, 14, "Fitness Score", width/2, 105, colorLetters);

    String [] screenFitness = new String [populationSize];

    for (int i = 0; i < populationSize; ++ i) { //--> Fitness viz.
      String rawFitness = sketches.serverFitness().get("indiv_"+nf(i, 3));
      screenFitness [i] = "Individual "+ nf(i, 3) + " - " + rawFitness;
      if (i<10) h1(font, textType, 12, screenFitness [i], 135 + 25*i);
    }
  }

  sectionLine(height * 0.47);

  //------------------------------------------------> Renders buttons
  int inc = 0;
  for (Button button : b) {

    button.update();
    if (inc == 0) {
      button.create(font, h1Type);
    } else {
      button.create(font, notesType);
    }

    ++ inc;
  }

  //------------------------------------------------> Renders sliders
  for (int j = 0; j < hs.length; ++ j) {
    hs[j].update();
    hs[j].display();
  }

  //------------------------------------------------> Fitness assignment.
  for (int i = 0; i < populationSize; ++ i) {

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

  if (dist(mouseX, mouseY, width - width/12 - 5, 100) < 6) {
    iconDisplay = !iconDisplay;
  }

  t.isHover(); //--> Checks toggle button state

  for (CircleButton c : cb) { //--> Checks each param. button state
    c.isClicked();
  }

  if (!firstMousePress) { //--> Sliders need it
    firstMousePress = true;
  }

  for (int g  = 0; g < b.length; ++ g) {

    if (b[g].getHover()) {
      //------------------------------------------------> 1. Main button
      if (g == 0) {
        //------------------------------------------------> 1.1 Initialize (1)
        if (buttonCounter == 0) {
          pop.initialize();
          pop.renderPop();
          indivCounter=0;
          ++ buttonCounter;
          delay(1000);
          btnTxt[0] = "Next Generation";
          println("-------------");
          //---------------
          for (int a = 0; a < pamRefined.size(); ++ a) { //--> Initializes updateParams list
            updateParams.append("a");
          }
          //---------------
          for (int p = 0; p < pamRefined.size(); ++ p) {
            isClicked.append(1);
            cb.add(new CircleButton(width - width/12 - 5, 130 + 25*p, isClicked.get(p)));
          }
        } else {
          //------------------------------------------------> 1.2 Next Generation (2 - )
          delay(1000);
          //---------------> Clears debug information
          sketchesName.clear();
          healthySketchesID.clear();
          zombieSketch.clear();

          counterGridX = 0;
          counterGridY = 0;

          pop.evolve();
          pop.renderPop();
          indivCounter = 0;

          exitSketch = "2";
          sketches.serverShutdown();
          exitSketch = "1";
          println("-------------");
        }
      }
      //------------------------------------------------> 2. Debug button
      else if (g == 1) {
        pop.reRenderIndiv();
      }
      //------------------------------------------------> 3. Run org. button
      else if (g == 2) {
        int tabIndex = matcher(path, "/");
        String str = path.substring(0, tabIndex);
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
      }
    }
  }

  //------------------------------------------------> Restart button activation
  if (dist(mouseX, mouseY, width/2 + 60, 70) < 20) {
    //--> Resets all counters
    indivCounter=0;
    popCounter = 0;
    buttonCounter = 0;
    genCounter = -1;
    counterGridX = 0;
    counterGridY = 0;
    exitSketch = "2";
    sketches.serverShutdown();
    exitSketch = "1";
    btnTxt[0] = "Create Population";
    //--> Empty created objects
    serverSketches.clear();
    genotype.clear();
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
