/**
 
 Towards Automated Generative Design, EvoProteus version 2.0
 Ricardo Sacadura, Penousal Machado, Tiago Martins and Luís Gonçalo (November 2023)
 at Computational Design and Visualization Lab. (DEI UC)
 Latest feature: Prompt-based evaluation.
 --------------
 A. Main system (grid display version)
 --------------
 User instructions
 1.  Create a sketch in processing;
 2.  Choose the set of parameters you want to evolve;
 3.  Tag those parameters with our markup language;
 Example:
 Original variable -> int radius = 0;
 Marked-up variable -> int __radius = 10; //min:0 max:50
 (the systems reads only initializations)
 4.  Run EvoProteus and upload your sketch (make sure all code is compiled into just one file);
 5.  Explore.
 (all variations will be stored at -> 'variations' folder)
 (each variation will have a .png file stored at -> 'snapshots' folder)
 
 */

//Population
import java.util.*; //--> Needed to sort arrays
//Evaluation
import java.util.concurrent.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.io.InputStreamReader;
import java.sql.Timestamp;
//Sockets
import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map; //--> HashMap Library
import java.io.BufferedReader;
import java.io.InputStreamReader;

//------------------------------------------------> global counters
int netCounter = 0; //--> label servers
int indivCounter=0; // --> label indiv.
int popCounter = 0; // --> count each generation
int buttonCounter = 0; // --> count each click on evolution button

//------------------------------------------------> booleans
boolean iconDisplay = false; //--> View mode
boolean restart = false; //--> Restart button
boolean renderButton = true; //--> View mode
boolean currentlyPlayed = false, currentlyPaused = false;
boolean automatorOn = true;

//------------------------------------------------> buttons & slider
Button [] b = new Button [5];
float btnHeight = 625; //--> First y-positions on screen
String [] btnTxt = new String [3]; //--> Text for buttons

Slider [] hs = new Slider [6];

//------------------------------------------------> GA
Population pop;
ArrayList <Genotype> genotype = new ArrayList<Genotype>();
StringList updateParams = new StringList(); // --> Updates evolving parameters list
String prompt;

//------------------------------------------------> experiments txt.
PrintWriter writer;
String folderName;

void setup() {

  size(275, 900);
  surface.setTitle("EvoProteus | Control Panel");

  int w = displayWidth - width -30;
  int h = displayHeight / 20;
  //surface.setLocation(w - width/8, h/2); --> Regular laptop
  surface.setLocation(w, h);

  //------------------------------------------------> Sets three typefaces for the interface design (searching through the fontList)
  h1Type    = fontList[chooseType("Anthony Regular")];
  textType  = fontList[chooseType("Space Grotesk Regular")];
  notesType = fontList[chooseType("Space Grotesk Regular")];

  //------------------------------------------------> Info. on system process pid (debug)

  /*systemID = int(ProcessHandle.current().pid());
   systemIDtoText = str(systemID);
   println("Control panel ID: " + systemIDtoText);*/

  //------------------------------------------------> Interface buttons and sliders
  btnTxt[0] = "Create population";
  btnTxt[1] = "Indiv. missing? Press here";
  btnTxt[2] = "Run original sketch";

  btnHeight = height * 0.90;
  //------------------------------------------------> Creates new buttons
  b[0] = new Button(width/2, btnHeight - 19, 190, 45, btnTxt[0], 1);
  b[1] = new Button(width/2, btnHeight + 30, 150, 20, btnTxt[1], 2);
  b[2] = new Button(width/2, btnHeight + 56, 100, 20, btnTxt[2], 2);

  b[3] = new Button(width/2 - 30, btnHeight - 19, 30, 3);
  b[4] = new Button(width/2 + 30, btnHeight - 19, 30, 4);

  t = new ToggleButton(width/12 + 15, 101); //--> Toggle Button between Fitness and Parameters

  createSliders(hs); //--> Sliders / Genetic operators
  tbox = new TextContainer(width/7, 225, 190); //--> Textual input component (prompt)

  //------------------------------------------------> Uploads your PDE sketchfile
  selectInput("Select a file to process:", "fileSelected");

  //------------------------------------------------> Sets a population to evolve
  pop = new Population();
}


void draw() {

  background(colorBg);

  //------------------------------------------------> Interface
  h1(font, h1Type, 34, "EvoProteus", 40); //--> Title

  String type = (dist(mouseX, mouseY, width/2, 70) < 50) ? textType : textType;
  int f = (dist(mouseX, mouseY, width/2, 70) < 50) ? 14 : 14;
  elements(font, type, f, "Gen. " + pop.getGenerations(), width/2 - 60, 70, colorLetters); //--> No. Generations


  //--> Restart button init.
  boolean onHoverRestart = dist(mouseX, mouseY, width/2 + 60, 70) < 20 ? true : false;
  int colorRestart = onHoverRestart ? colorOnHover : colorLetters;
  elements(font, type, f, "Restart", width/2 + 60, 70, colorRestart); //--> Restart Generation


  //------------------------------------------------> Dark and light mode
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
  if (isToggled) {

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
    //------------------------------------------------> Displays textual input component.
  } else {
    elements(font, textType, 14, "Prompt", width/2, 105, colorLetters);
    tbox.createContainer();
    float tw = tbox.getTextWidth();
    tbox.createTyperLine(tw);
  }

  //------------------------------------------------]
  sectionLine(height * 0.425);
  //------------------------------------------------]

  //------------------------------------------------> Renders buttons
  int inc = 0;
  for (Button button : b) {
    button.update();
    if (inc == 0) {
      if (renderButton) button.create(font, h1Type); //--> Remove this condition while using the single button approach
    } else if (inc <= 2) {
      button.create(font, notesType);
    } else {
      if (!renderButton) button.create();
    }
    ++ inc;
  }

  //------------------------------------------------> Renders sliders
  for (int j = 0; j < hs.length; ++ j) {
    hs[j].update();
    hs[j].display();
  }

  //------------------------------------------------> Fitness assignment -> interactive mode.

  /*
  StringDict fitnesses = sketches.serverFitness();
   for (int i = 0; i < populationSize; ++ i) {
   
   String rawFitness = fitnesses.get("indiv_"+nf(i, 3));
   
   if (rawFitness != null) {
   float fitness = float(rawFitness);
   pop.getIndiv(i).setFitness(fitness); //--> Assign fitness score to each indiv.
   }
   }
   */

  //------------------------------------------------> Communication between sketches
  sketches.listenMain();
  //sketches.sketchesLocation();
  sketches.serverFitness();

  //------------------------------------------------> Genetic operators dynamic assignment

  //populationSize  = int(hs[0].getOperatorValue());
  populationSize = 20;
  eliteSize = 1;
  tournamentSize = 2;
  //eliteSize       = int(hs[1].getOperatorValue());
  //tournamentSize  = int(hs[2].getOperatorValue());
  //crossoverRate   = float(hs[3].getOperatorValue());
  //mutationRate    = float(hs[4].getOperatorValue());
  //mutationRate = 0.5 * (1 + sin(TWO_PI * pop.getGenerations() / 250.0 - HALF_PI));
  //mutationScaling = float(hs[5].getOperatorValue());

  //crossoverRate   = float(hs[3].getOperatorValue());
  //crossoverRate = map(ratio, 0, 1, 0.8, 0);
  //mutationRate = map(ratio, 0, 1, 0.05, 1);
  //mutationRate    = float(hs[4].getOperatorValue());

  crossoverRate = 0.5;
  mutationRate = 0.5;

  float ratio = pop.getGenerations() / 600.0;

  //if (pop.getGenerations() >= 600 ) {
  //  mutationScaling = 0.01;
  // } else {
  mutationScaling = map(ratio, 0, 1, 0.5, 0.01);
  // }



  // crossoverRate = constrain(0.8 - (float(pop.getGenerations()) / 250.0), 0.05, 0.8);
  // mutationRate  = constrain(float(pop.getGenerations()) / 250.0, 0.05, 1);
  // mutationScaling = constrain(0.6 - (float(pop.getGenerations()) / 250.0), 0.01, 0.6);

  //-------------------------------------------------> Automatic mode.

  if (buttonCounter >= 2 && automatorOn == true) {
    if (allWindowsOpen()) { //--> This method check all windows state.
      currentlyPlayed = true; //--> Highlights the play button.
      automation();
    }
  }

  if (popCounter >= 601) {

    delay(25000);
    indivCounter=0;
    popCounter = 0;
    buttonCounter = 0;
    genCounter = -1;
    counterGridX = 0;
    counterGridY = 0;
    exitSketch = "2";
    sketches.windowShutdown();
    exitSketch = "1";
    btnTxt[0] = "Create Population";
    //--> Empty created objects
    serverSketches.clear();
    genotype.clear();
    //
    delay(2000);
    //
    /*
          [---> 1. Creates population button. <---]
     **/
    prompt = tbox.getPrompt();
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
    folderName = fileName + "_" + prompt + "_" + populationSize + "_" + timestamp.getTime();

    pop.initialize();
    pop.renderPop();
    indivCounter=0;
    delay(1000);

    renderButton = false;

    ++buttonCounter;
    println("-------------");

    for (int a = 0; a < pamRefined.size(); ++ a) { //--> Initializes updateParams list
      updateParams.append("a");
    }

    for (int p = 0; p < pamRefined.size(); ++ p) {
      isClicked.append(1);
      cb.add(new CircleButton(width - width/12 - 5, 130 + 25*p, isClicked.get(p)));
    }

    File theDir = new File("./" + folderName);
    if (!theDir.exists()) {
      theDir.mkdirs();
    }
    try {
      writer = createWriter(folderName + "/experimental_setup.txt");
      writer.println("prompt: " + prompt);
      writer.println("fileName: " + fileName);
      writer.println("pop_size: " + populationSize);
      writer.println("eliteSize: " + eliteSize);
      writer.println("tournamentSize: " + tournamentSize);
      writer.println("crossoverRate: " + crossoverRate);
      writer.println("mutationRate: " + mutationRate);
      writer.println("mutationScaling: " + mutationScaling);
      writer.println("______________");
      writer.println("gen,average,best");
      writer.flush();
    }
    catch (Exception ignored) {
    }
    //
    delay(20000);
    /*
          [---> 4. Automatic evolution with CLIP. <---]
     **/
    automation();
    ++buttonCounter;
    automatorOn = true;
  }
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
      if (g == 0 && buttonCounter == 0) {
        /*
          [---> 1. Creates population button. <---]
         **/
        prompt = tbox.getPrompt();
        //prompt = "sketch of a five point star";
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        folderName = fileName + "_" + prompt + "_" + populationSize + "_" + timestamp.getTime();

        pop.initialize();
        pop.renderPop();
        indivCounter=0;
        delay(1000);

        renderButton = false;

        ++buttonCounter;
        println("-------------");

        for (int a = 0; a < pamRefined.size(); ++ a) { //--> Initializes updateParams list
          updateParams.append("a");
        }

        for (int p = 0; p < pamRefined.size(); ++ p) {
          isClicked.append(1);
          cb.add(new CircleButton(width - width/12 - 5, 130 + 25*p, isClicked.get(p)));
        }

        File theDir = new File("./" + folderName);
        if (!theDir.exists()) {
          theDir.mkdirs();
        }
        try {
          writer = createWriter(folderName + "/experimental_setup.txt");
          writer.println("prompt: " + prompt);
          writer.println("fileName: " + fileName);
          writer.println("pop_size: " + populationSize);
          writer.println("eliteSize: " + eliteSize);
          writer.println("tournamentSize: " + tournamentSize);
          writer.println("crossoverRate: " + crossoverRate);
          writer.println("mutationRate: " + mutationRate);
          writer.println("mutationScaling: " + mutationScaling);
          writer.println("______________");
          writer.println("gen,average,best");
          writer.flush();
        }
        catch (Exception ignored) {
        }
      } else if (g == 1) {
        /*
          [---> 2. Debug button. <---]
         **/
        pop.reRenderIndiv();
      } else if (g == 2) {
        /*
          [---> 3. Run input sketch. <---]
         **/
        int tabIndex = matcher(path, "/");
        String str = path.substring(0, tabIndex);
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
      } else if (g == 3) {
        /*
          [---> 4. Automatic evolution with CLIP. <---]
         **/
        automation();
        ++buttonCounter;
        automatorOn = true;
      } else if (g == 4) {
        /*
          [---> 5. Pause evolution, interactivity. <---]
         **/
        automatorOn = false;
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
    sketches.windowShutdown();
    exitSketch = "1";
    btnTxt[0] = "Create Population";
    //--> Empty created objects
    serverSketches.clear();
    genotype.clear();
  }
}

void keyPressed() {
  //--> A dynamic prompt spec. requires this.
  if (!isToggled) {
    k = key;
    tbox.setKey(k);
    tbox.processInput();
  }
}

//------------------------------------------------> Method to close all open windows
void exit() {
  writer.close();
  exitSketch = "2";
  sketches.windowShutdown();
  thread("exitDelay");
  // $$[Further development idea] On exit, opens folder with exported pop(s).
}

void exitDelay() {
  delay(1500);
  System.exit(0);
}

void automation() {

  //------------------------------------------------> Automatic fitness
  // prompt = tbox.getPrompt(); //--> The textual instruction we give CLIP to evaluate candidates.

  if (allWindowsOpen()) {
    /*println("Current crossover rate: " + crossoverRate);
     println("Current mutation rate: " + mutationRate);*/
    println("---");
    println("Crossover Rate:", crossoverRate);
    println("Mutation Rate:", mutationRate);
    println("Elite:", eliteSize);
    println("Tournament:", tournamentSize);
    println("Current mutation impact: " + mutationScaling);
    println("---");

    delay(24000); //-> Expected delay between generations.

    int numThreads = Runtime.getRuntime().availableProcessors();
    numThreads = min(numThreads, pop.individuals.length);
    ExecutorService executor = Executors.newFixedThreadPool(numThreads);

    for (int i = 0; i < pop.individuals.length; ++i) {
      String imagePath = sketchPath() + "/" + folderName + "/pop_"+ nf(popCounter, 3) + "/indiv_" + nf(i, 3) + ".png";
      //double startTime = System.nanoTime();
      Evaluator e = new Evaluator(pop.individuals[i], imagePath, prompt);
      executor.execute(e);
      //double elapsed = (System.nanoTime() - startTime)/ 1e9;
      //System.out.println(elapsed + " seconds elapsed");
    }
    executor.shutdown();

    try {
      executor.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
    }
    catch (InterruptedException e) {
      e.printStackTrace();
    }
    finally {
      Float mean = 0.0;
      Float max = -9999.0;

      for (int i = 0; i < pop.individuals.length; ++i) {
        mean += pop.individuals[i].getFitness();
        if ( pop.individuals[i].getFitness() > max)
          max =  pop.individuals[i].getFitness();
      }
      mean /=  pop.individuals.length;

      writer.println(popCounter + "," + mean + "," + max);
      writer.flush();
    }
  }

  indivCounter = 0;

  exitSketch = "2";
  sketches.windowShutdown();
  exitSketch = "1";

  //---------------> Resets arrays
  sketchesName.clear();
  healthySketchesID.clear();
  zombieSketch.clear();
  serverSketches.clear();

  //--> Reset grid counter
  counterGridX = 0;
  counterGridY = 0;

  pop.evolve();
  pop.renderPop();
  println("-------------");
}

// --> Detects x char occurrences on a string
int matcher(String in, String find) {
  int index = 0;
  int last = -1;
  while (index != -1) {
    index = in.indexOf(find, last+1);
    if ( index != -1 ) last = index;
  }
  return last;
}
