/**
 EvoProteus version 2.0 adapted for Windows.
 Ricardo Sacadura, Penousal Machado, Tiago Martins and Luís Gonçalo (August 2024)
 at Computational Design and Visualization Lab. (DEI UC)
 Latest feature: Aesthetic Predictor combined with CLIP.
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
boolean automatorOn = true; //--> Switch between automation and interactivity

//------------------------------------------------> buttons & slider
Button [] b = new Button [3];
float btnHeight = 625; //--> First y-positions on screen
String [] btnTxt = new String [3]; //--> Text for buttons

Slider [] hs = new Slider [6];

//------------------------------------------------> GA
Population pop;
ArrayList <Genotype> genotype = new ArrayList<Genotype>();
ArrayList <Genotype> survivors = new ArrayList <Genotype>();
StringList updateParams = new StringList(); // --> Updates evolving parameters list
String prompt;

//------------------------------------------------> experiments txt.
PrintWriter writer;
String folderName;

float n = 0;

int chooseInterval = 350;  // number of generations which run automatically
int chooseSeconds = 24000; // time interval between generations (necessary to avoid errors on CLIP's side) //23500

void setup() {

  size(275, 900);
  pixelDensity(2);
  surface.setTitle("EvoProteus | Control Panel");

  int w = displayWidth - width - 30;
  int h = displayHeight / 20;
  //surface.setLocation(w - width/8, h/2); --> Regular laptop
  surface.setLocation(w, h);

  //------------------------------------------------> Sets three typefaces for the interface design (searching through the fontList)
  h1Type    = fontList[chooseType("Anthony Regular")];
  textType  = fontList[chooseType("Space Grotesk Regular")];
  notesType = fontList[chooseType("Space Grotesk Regular")];

  //------------------------------------------------> Info. on system process pid (debug)

  systemID = int(ProcessHandle.current().pid());
  systemIDtoText = str(systemID);
  println("Control panel ID: " + systemIDtoText);

  //------------------------------------------------> Interface buttons and sliders
  btnTxt[0] = "Create population";
  //btnTxt[1] = "Indiv. missing? Press here";
  //btnTxt[2] = "Run original sketch";

  btnHeight = height * 0.92;
  //------------------------------------------------> Creates new buttons
  b[0] = new Button(width/2, btnHeight, 190, 45, btnTxt[0], 1);
  //b[1] = new Button(width/2, btnHeight + 30, 150, 20, btnTxt[1], 2);
  //b[2] = new Button(width/2, btnHeight + 56, 100, 20, btnTxt[2], 2);

  b[1] = new Button(width/2 - 30, btnHeight, 30, 3);
  b[2] = new Button(width/2 + 30, btnHeight, 30, 4);

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
    } else if (inc < 0) {
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

  //eliteSize       = int(hs[1].getOperatorValue());
  //tournamentSize  = int(hs[2].getOperatorValue());
  //crossoverRate   = float(hs[3].getOperatorValue());
 // mutationRate    = float(hs[4].getOperatorValue());
//  mutationScaling = float(hs[5].getOperatorValue());

  populationSize = 20;
  eliteSize = 1;
  tournamentSize = 2;
  crossoverRate = 0.5;
  mutationRate = 0.5;

  //float ratio = pop.getGenerations() / 500.0;
  //mutationScaling = map(ratio, 0, 1, 0.15, 0.01);
  float xGaussian = pop.getGenerations() / 350.0;
  float A = 0.3;  // Amplitude
  float mu = 0;    // Mean
  float sigma = 0.3; // Standard deviation
  mutationScaling = A * (float)Math.exp(-Math.pow(xGaussian - mu, 2) / (2 * Math.pow(sigma, 2)));
  //mutationScaling = 0.9;

  //-------------------------------------------------> Automatic mode.

  if (buttonCounter >= 2 && automatorOn == true) {

    currentlyPaused = false;
    currentlyPlayed = true; //--> Highlights the play button.
    automation();
  }

  if (pop.getGenerations() > 0 && pop.getGenerations() % chooseInterval == 0) {
    currentlyPaused = true;
    currentlyPlayed = false;
    automatorOn = false;
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
        //prompt = " Silhouette of a ballerina, balance rendered, centered full body, foot, doing kick";
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
      } else if (g == 3) {
        /*
          [---> 2. Debug button. <---]
         **/
        pop.reRenderIndiv();
      } else if (g == 4) {
        /*
          [---> 3. Run input sketch. <---]
         **/
        int tabIndex = matcher(path, "/");
        String str = path.substring(0, tabIndex);
        exec("/usr/local/bin/processing-java", "--sketch=" + str, "--run");
      } else if (g == 1 && (pop.getGenerations() % chooseInterval != 0 || pop.getGenerations() == 0)) {
        /*
          [---> 4. Automatic evolution with CLIP. <---]
         **/
        automatorOn =true;
        automation();
        ++buttonCounter;
      } else if (g == 1 && pop.getGenerations() % chooseInterval == 0) { // == 0
        /*
          [---> 5. Pause evolution, interactivity. <---]
         **/
        interactive();
        delay(3000);
        automatorOn = true;
        currentlyPaused = false;
        currentlyPlayed = true;
        survivors.clear();
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

void keyReleased() {
  //--> A dynamic prompt spec. requires this.
  if (!isToggled) {
    k = key;
    tbox.setKey(k);
    tbox.processInput();
  }

  if (key == ' ') {
    saveFrame("control-panel.jpg");
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

  println("---");
  println("Crossover Rate:", crossoverRate);
  println("Mutation Rate:", mutationRate);
  println("Elite:", eliteSize);
  println("Tournament:", tournamentSize);
  println("Current mutation impact: " + mutationScaling);
  println("---");

  delay(chooseSeconds); //-> Expected delay between generations.

  int numThreads = Runtime.getRuntime().availableProcessors();
  numThreads = min(numThreads, pop.individuals.length);
  ExecutorService executor = Executors.newFixedThreadPool(numThreads);

  for (int i = 0; i < pop.individuals.length; ++i) {
    String imagePath = sketchPath() + "/" + folderName + "/pop_"+ nf(popCounter, 3) + "/indiv_" + nf(i, 3) + ".png";
    Evaluator e = new Evaluator(pop.individuals[i], imagePath, prompt);
    executor.execute(e);
    print(imagePath);
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

void interactive() {

  StringDict fitnesses = sketches.serverFitness();

  for (int i = 0; i < populationSize; ++ i) {

    String rawFitness = fitnesses.get("indiv_"+nf(i, 3));

    if (rawFitness != null) {
      float fitness = float(rawFitness);
      pop.getIndiv(i).setFitness(fitness); //--> Assign fitness score to each indiv.
      if (pop.getIndiv(i).getFitness() == 1.0) survivors.add(pop.getIndiv(i));
      println(pop.getIndiv(i), fitness);
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
