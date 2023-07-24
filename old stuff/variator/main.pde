//------------------------------------------------> IntList of Sketch lines containing parameters
IntList sketchLine = new IntList(); //--> Lines w/ identified parameters
IntList sketchLineRefined = new IntList(); //--> Refined lines (no outliers)

String primitives [] = {"String", "float", "int", "char", "boolean"}; //--> Listing primitive data types

//------------------------------------------------> Variables to store input sketch information
String inputSketch [] = {"/n"};
String original [] = {"/n"};
String path = "/n";
String orgPath = "/n";
Main m = new Main(); //--> Initial input information

int counterGridX = 0, counterGridY=0;

File selection;
int [] orgSize = new int[2]; //--> Original sketch size
int sketchW, sketchH;

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

class Main {

  StringList labeledIndex = new StringList(); // --> String to store all labeled indexes

  String label = "__", attribution = "=", close = ";", comment = "//", min = "min:", max = "max:"; // --> parameter's extraction labels
  String setup = "void setup()", draw = "void draw()", size = "size("; // --> code injection labels


  int ix_l = -1; //--> index of "__"
  int ix_at = -1, ix_cl = -1, ix_cm = -1; //--> index of "=" , ";" and "//"
  int ix_max = -1, ix_min = -1; //--> index of "min:" and "max:"
  int ix_setup = -1, ix_draw = -1; //--> index of "void setup()"
  int ix_size = -1; //--> index of "size(x,y);";

  //------------------------------------------------> (1) Parameters identification

  String type, name, value, limits, min_value, max_value;

  int gridX = 0, gridY =0 ;

  /**
   
   [A] PARAMETER EXTRACTION METHOD
   
   */

  void extractor () {

    //------------------------------------------------> (2) Searches through the sketch

    for (int i=0; i<inputSketch.length; i++) {

      ix_l  =  inputSketch[i].indexOf(label);
      ix_at =  inputSketch[i].indexOf(attribution);
      ix_cl =  inputSketch[i].indexOf(close);
      ix_cm =  inputSketch[i].indexOf(comment);

      if (ix_l != -1 && ix_at != -1 && ix_cl != -1) {
        labeledIndex.append(inputSketch[i]);
        sketchLine.append(i);
      }
    }

    //------------------------------------------------> (3) Inspects the identified labeled indexes

    for (int j=0; j<labeledIndex.size(); j++) {

      ix_l  = labeledIndex.get(j).indexOf(label);
      ix_at = labeledIndex.get(j).indexOf(attribution);
      ix_cl = labeledIndex.get(j).indexOf(close);
      ix_cm = labeledIndex.get(j).indexOf(comment);

      // --> substring type
      type = labeledIndex.get(j).substring(0, ix_l-1);

      // --> substring name
      if (ix_l < ix_at) {
        name = labeledIndex.get(j).substring(ix_l, ix_at);
      }

      // --> substring value
      value = labeledIndex.get(j).substring(ix_at +1, ix_cl);

      // --> substring comments
      if (ix_cm != -1) {
        limits = labeledIndex.get(j).substring(ix_cm +2, labeledIndex.get(j).length());
      } else {
        limits = "Undefined";
      }

      parameters.add(new Parameters(type, name, value, limits));
    }

    //------------------------------------------------> (4) Removes outliers, (preserve only parameters preceeded by variable declaration)

    for (int k = 0; k<parameters.size(); k++) {

      parameters.get(k).type =  parameters.get(k).type.trim();

      for (int l = 0; l< primitives.length; l++) {

        if (parameters.get(k).type.equals(primitives[l])) {

          pamRefined.add(new pamRefined(parameters.get(k).type, parameters.get(k).name, parameters.get(k).value, parameters.get(k).limits));
          sketchLineRefined.append(sketchLine.get(k));
        }
      }
    }


    //------------------------------------------------> (5) Prints Results

    println("List of identified parameters:");

    for (int g = 0; g<pamRefined.size(); g++) {
      println(pamRefined.get(g).type);
      println(pamRefined.get(g).name);
      println(pamRefined.get(g).value);
      println(pamRefined.get(g).limits);
      println("-------------");
    }
  }

  /**
   
   [B] PARAMETERS VARIATION METHOD
   
   */

  //------------------------------------------------> (6) Changes randomly extracted values + Creates the initial pop.

  void manipulator () {

    StringList variableType = new StringList(); // --> StringList to help identify Datatype primitive
    genotype.add(new Genotype());
    genCounter ++;

    for (int d = 0; d<pamRefined.size(); d++) {

      ix_min = pamRefined.get(d).limits.indexOf(min);
      ix_max = pamRefined.get(d).limits.indexOf(max);

      variableType.append(pamRefined.get(d).type);

      if (ix_min != -1) {

        min_value =  pamRefined.get(d).limits.substring(ix_min + 4, ix_max - 1);
        max_value =  pamRefined.get(d).limits.substring(ix_max + 4, pamRefined.get(d).limits.length());

        // --> change float values
        if (variableType.get(d).equals(primitives[1])) {
          float n_value = random(float(min_value), float(max_value));
          pamRefined.get(d).value = str(n_value);
        }
        // --> change int values
        else if (variableType.get(d).equals(primitives[2])) {
          int n_value = round(random(int(min_value), int(max_value)));
          pamRefined.get(d).value = str(n_value);
        }
        // --> change boolean values
        else if (variableType.get(d).equals(primitives[4])) {
          boolean n_value =   random(2) > 1;
          pamRefined.get(d).value = str(n_value);
        }
      } else {
        min_value = "undefined"; // --> No boundaries, no fun.
        max_value = "undefined"; // --> :(
      }

      genotype.get(genCounter).arrange(d + pamRefined.get(d).type, pamRefined.get(d).value, min_value, max_value); // --> Ready for evolution
    }
  }

  /**
   
   [C] GENERIC CODE INJECTION METHOD
   
   */

  //--> Necessary for future communications between pop. and system.

  void injectorA (int counter) {

    // --> Client-Server injection code entries
    String injectedSetup [] = new String [1];
    String injectedBegin [] = new String [1];
    String injectedDraw  [] = new String [1];

    injectedBegin [0] = "import processing.net.*;import processing.awt.PSurfaceAWT;PSurfaceAWT.SmoothCanvas smoothCanvas;Client clientSketches;int listener = 0;void exit() { windowOpen = false; thread(\"exitDelay\");}boolean windowOpen = true;void exitDelay(){delay(1500); System.exit(0);}String input; int exitValue;//Injected line";
    injectedSetup [0] = "surface.setLocation("+ gridX + ","+ gridY+");PSurfaceAWT awtSurface = (PSurfaceAWT)surface;smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();println(\"[Client] Client connected\");clientSketches = new Client(this, \"localhost\", 3000 + " + counter + ");//variator";
    injectedDraw  [0] = "final String sketch = getClass().getName();java.awt.Point p = new java.awt.Point();smoothCanvas.getFrame().getLocation(p);if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;}clientSketches.write(sketch + \" \" + listener + \" \");if (clientSketches.available() > 0) {input = clientSketches.readString(); exitValue = int(input); if (exitValue == 2) exit();}//variator";


    for (int q=0; q<inputSketch.length; q++) {

      ix_setup = inputSketch[q].indexOf(setup); // --> Finding void setup() in input sketch

      if (ix_setup != -1) {
        for (int l = 0; l<injectedSetup.length; l++) {
          inputSketch = splice(inputSketch, injectedSetup[l], q+1);
        }
      }
    }

    for (int q=0; q<inputSketch.length; q++) {

      ix_draw = inputSketch[q].indexOf(draw); // --> Finding void draw() in input sketch

      if (ix_draw != -1) {
        for (int l = 0; l<injectedDraw.length; l++) {
          inputSketch = splice(inputSketch, injectedDraw[l], q+1);
        }
      }
    }


    int last_ix = inputSketch.length; // --> Finding last line in input sketch (simpler for declarations and libraries injection)

    for (int p = 0; p<injectedBegin.length; p++) {
      inputSketch = splice(inputSketch, injectedBegin[p], last_ix);
    }
  }

  /**
   
   [D] MODIFIED PARAMETERS INJECTION FUNCTION + SERVER-CLIENT UTILITIES
   
   */

  //------------------------------------------------> (7) Injects variated values

  void injectorB (String [] values) {


    String a, b, c;
    int ixInjectValues; // --> Stores each sketchLine to be variated


    for (int t = 0; t < sketchLineRefined.size(); t++) {

      ixInjectValues = sketchLineRefined.get(t);

      ix_l  = inputSketch[ixInjectValues].indexOf(label);
      ix_at = inputSketch[ixInjectValues].indexOf(attribution);
      ix_cl = inputSketch[ixInjectValues].indexOf(close);
      ix_cm = inputSketch[ixInjectValues].indexOf(comment);

      //----------> Substrings each labeled line to inject the variated value

      a = inputSketch[ixInjectValues].substring(0, ix_at+1);
      b = inputSketch[ixInjectValues].substring(ix_at+1, ix_cl);
      c = inputSketch[ixInjectValues].substring(ix_cl, inputSketch[ixInjectValues].length());

      b = values[t]; // --> pamRefined

      String modified = a + b + c ;

      inputSketch[ixInjectValues] = modified; // --> Injection
    }
  }

  /**
   
   [E] SAVE MODIFIED CODE METHOD
   
   */

  //------------------------------------------------> (8) Exports new sketches with variations

  void popExport(int counter) {
    println("indiv " + nf(counter, 3) + " from population " + nf(popCounter, 3) + " exported.");

    for (int s = 0; s<inputSketch.length; s++) {
      saveStrings("variations/pop_" + nf(popCounter, 3) + "/indiv_"+nf(counter, 3) + "/indiv_"+nf(counter, 3) + ".pde", inputSketch);
    }
  }

  /**
   
   [F] RUN MODIFIED CODE SKETCHES FUNCTION
   
   */

  //------------------------------------------------> (9) Runs each individual of the current pop.

  void runSketch(int counter) {
    String path = "";
    for (int f = 0; f < counter; f++) {
      path = sketchPath("variations/pop_"+nf(popCounter, 3)+"/indiv_"+nf(f, 3));
      //println(path);
      if (counter == -1) {
        println("nothing to run");
      } else {
        exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");
        //delay(500);
      }
    }
    //println(nf(popCounter, 3));
  }

  //------------------------------------------------> (extra) Info. on sketch size

  int [] getSketchSize() {

    int [] sketchSize = new int [2];
    int sizeW = 0, sizeH = 0;

    String comma = ",", paren = ")";
    int ix_comma = -1, ix_paren = -1;

    for (int i = 0; i < inputSketch.length; i++) {
      ix_size = inputSketch[i].indexOf(size);
      if (ix_size != -1) {
        try {
          ix_comma  = inputSketch[i].indexOf(comma);
          ix_paren  = inputSketch[i].indexOf(paren);

          sizeW = int(inputSketch[i].substring(ix_size + 5, ix_comma));
          sizeH = int(inputSketch[i].substring(ix_comma + 2, ix_paren));
        }
        catch(Exception exc) {
        }
      }
    }

    sketchSize[0] = sizeW;
    sketchSize[1] = sizeH;

    //println("sketchSize is:" + sketchSize[0] + " " + sketchSize[1]);
    return sketchSize;
  }

  //------------------------------------------------> (extra) Grid display

  void setGrid() {

    if (counterGridX == 3) {
      counterGridX = 0;
      counterGridY += 1;
    }

    gridX = (sketchW * counterGridX) + (23 * (counterGridX + 1));
    gridY = (sketchH * counterGridY) +  46 * (counterGridY + 1);

    counterGridX +=1;
  }
}
