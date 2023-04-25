class Main {

  // --> ArrayList of objects
  ArrayList<Parameters> parameters = new ArrayList<Parameters>();
  ArrayList<pamRefined> pamRefined = new ArrayList<pamRefined>();

  IntList sketchLine = new IntList();
  IntList sketchLineRefined = new IntList();

  // --> note: the refined lists/arrays are created for outlier removal purposes;

  StringList labeledIndex = new StringList(); // --> String to store all labeled indexes

  //-----------------//

  String primitivesList [] = {"String", "float", "int", "char", "boolean"}; // --> Listing primitive data types

  //-----------------//

  String label = "__", attribution = "=", close = ";", comment = "//", min = "min:", max = "max:"; // --> parameter's extraction labels
  String setup = "void setup()", draw = "void draw()", size = "size("; // --> code injection labels

  //-----------------//

  int ix_l = -1; //--> index of "__"
  int ix_at = -1, ix_cl = -1, ix_cm = -1; //--> index of "=" , ";" and "//"
  int ix_max = -1, ix_min = -1; //--> index of "min:" and "max:"
  int ix_setup = -1, ix_draw = -1; //--> index of "void setup()"
  int ix_size = -1; //--> index of "size(x,y);";

  //----------> (1) PARAMETERS IDENTIFICATION

  String type, name, value, limits, min_value, max_value;

  int gridX = 0, gridY =0 ;
  int counterGridX = 0, counterGridY=0;

  /*------------------------------------------PARAMETER EXTRACTION FUNCTION--------------------------------------------------------*/
  /*-------------------------------------------------------------------------------------------------------------------------------*/

  void extractor () {

    //----------> (2) SEARCHING THE CONCATENATED SKETCHES STRING

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

    //----------> (3) INSPECTING THE IDENTIFIED LABELLED INDEXES

    for (int j=0; j<labeledIndex.size(); j++) {

      ix_l  = labeledIndex.get(j).indexOf(label);
      ix_at = labeledIndex.get(j).indexOf(attribution);
      ix_cl = labeledIndex.get(j).indexOf(close);
      ix_cm = labeledIndex.get(j).indexOf(comment);

      type = labeledIndex.get(j).substring(0, ix_l-1); // --> substring variable type

      if (ix_l < ix_at) {
        name = labeledIndex.get(j).substring(ix_l, ix_at); // --> substring variable name
      }

      value = labeledIndex.get(j).substring(ix_at +1, ix_cl); // --> substring variable value

      if (ix_cm != -1) {
        limits = labeledIndex.get(j).substring(ix_cm +2, labeledIndex.get(j).length()); // --> substring variable comments
      } else {
        limits = "Undefined";
      }

      //-----------------//
      parameters.add(new Parameters(type, name, value, limits));
    }

    //----------> (4) REMOVE OUTLIERS, (preserve only parameters preceeded by variable declaration)

    for (int k = 0; k<parameters.size(); k++) {

      parameters.get(k).type =  parameters.get(k).type.trim();

      for (int l = 0; l< primitivesList.length; l++) {

        if (parameters.get(k).type.equals(primitivesList[l])) {

          pamRefined.add(new pamRefined(parameters.get(k).type, parameters.get(k).name, parameters.get(k).value, parameters.get(k).limits));
          sketchLineRefined.append(sketchLine.get(k));
        }
      }
    }


    //----------> (5) PRINT RESULTS

    println("List of identified parameters:");

    for (int g = 0; g<pamRefined.size(); g++) {
      println(pamRefined.get(g).type);
      println(pamRefined.get(g).name);
      println(pamRefined.get(g).value);
      println(pamRefined.get(g).limits);
      println("-------------");
    }
  }

  /*------------------------------------------PARAMETERS MANIPULATION FUNCTION--------------------------------------------------------*/
  /*---------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (6) EXTRACTED VALUES MANIPULATION

  void manipulator () {

    StringList variableType = new StringList(); // --> StringList to help identify Datatype primitive

    for (int d = 0; d<pamRefined.size(); d++) {

      ix_min = pamRefined.get(d).limits.indexOf(min);
      ix_max = pamRefined.get(d).limits.indexOf(max);

      variableType.append(pamRefined.get(d).type);

      if (ix_min != -1) {

        min_value =  pamRefined.get(d).limits.substring(ix_min + 4, ix_max - 1);
        max_value =  pamRefined.get(d).limits.substring(ix_max + 4, pamRefined.get(d).limits.length());

        if (variableType.get(d).equals(primitivesList[1])) { // --> change float values
          float n_value = random(float(min_value), float(max_value));
          pamRefined.get(d).value = str(n_value);

          //-----------------//
        } else if (variableType.get(d).equals(primitivesList[2])) { // --> change int values
          int n_value = round(random(int(min_value), int(max_value)));
          pamRefined.get(d).value = str(n_value);

          //-----------------//
        } else if (variableType.get(d).equals(primitivesList[4])) { // --> change boolean values
          boolean n_value =   random(2) > 1;
          pamRefined.get(d).value = str(n_value);

          //-----------------//
        }
      } else {
        min_value = "undefined"; // --> No boundaries, no fun.
        max_value = "undefined"; // --> :(
      }
    }
  }

  /*------------------------------------------GENERIC CODE INJECTION FUNCTION--------------------------------------------------------*/
  /*---------------------------------------------------------------------------------------------------------------------------------*/

  void injectorA (int counter) {

    // --> Client-Server injection code entries
    String injectedSetup [] = new String [5];
    String injectedBegin [] = new String [9];
    String injectedDraw  [] = new String [6];


    injectedBegin [8] = "import processing.net.*; //variator";
    injectedBegin [7] = "import processing.awt.PSurfaceAWT; //variator";
    injectedBegin [6] = "PSurfaceAWT.SmoothCanvas smoothCanvas; //variator";
    injectedBegin [5] = "Client v_m; //variator";
    injectedBegin [4] = "int listener = 0; //variator";
    injectedBegin [3] = "void exit() { windowOpen = false; thread(\"exitDelay\");}";
    injectedBegin [2] = "boolean windowOpen = true;";
    injectedBegin [1] = "void exitDelay(){delay(1500); System.exit(0);}";
    injectedBegin [0] = "String input; int exitValue;";

    injectedSetup [4] = "surface.setLocation("+ gridX + ","+ gridY+"); //variator";
    injectedSetup [3] = "PSurfaceAWT awtSurface = (PSurfaceAWT)surface; //variator";
    injectedSetup [2] = "smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative(); //variator";
    injectedSetup [1] = "println(\"[Client] Client connected\"); //variator";
    injectedSetup [0] = "v_m = new Client(this, \"localhost\", 3000 + " + counter + "); //variator";

    injectedDraw [5] = "final String sketch = getClass().getName();//variator";
    injectedDraw [4] = "java.awt.Point p = new java.awt.Point();//variator";
    injectedDraw [3] = "smoothCanvas.getFrame().getLocation(p);//variator";
    injectedDraw [2] = "if (windowOpen==true) {listener=1;} else if (windowOpen == false) {listener=0;} //variator";
    injectedDraw [1] = "v_m.write(sketch + \" \" + listener + \" \"); //variator";
    injectedDraw [0] = "if (v_m.available() > 0) {input = v_m.readString(); exitValue = int(input); if (exitValue == 2) exit();}";


    //-----------------//
    for (int q=0; q<inputSketch.length; q++) {

      ix_setup = inputSketch[q].indexOf(setup); // --> Finding void setup() in input sketch

      if (ix_setup != -1) {
        for (int l = 0; l<injectedSetup.length; l++) {
          inputSketch = splice(inputSketch, injectedSetup[l], q+1);
        }
      }
    }
    //-----------------//
    for (int q=0; q<inputSketch.length; q++) {

      ix_draw = inputSketch[q].indexOf(draw); // --> Finding void draw() in input sketch

      if (ix_draw != -1) {
        for (int l = 0; l<injectedDraw.length; l++) {
          inputSketch = splice(inputSketch, injectedDraw[l], q+1);
        }
      }
    }
    //-----------------//
    int last_ix = inputSketch.length; // --> Finding last line in input sketch (simpler for declarations and libraries injection)

    for (int p = 0; p<injectedBegin.length; p++) {
      inputSketch = splice(inputSketch, injectedBegin[p], last_ix);
    }
  }

  /*------------------------------------------MODIFIED PARAMETERS INJECTION FUNCTION + SERVER-CLIENT UTILITIES------------------------------*/
  /*----------------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (7) MANIPULATED VALUES INJECTION

  void injectorB () {

    String a, b, c;
    int ixInjectValues; // --> Stores each sketchLine to be variated


    for (int t = 0; t < sketchLineRefined.size(); t++) {

      ixInjectValues = sketchLineRefined.get(t);

      ix_l  = inputSketch[ixInjectValues].indexOf(label);
      ix_at = inputSketch[ixInjectValues].indexOf(attribution);
      ix_cl = inputSketch[ixInjectValues].indexOf(close);
      ix_cm = inputSketch[ixInjectValues].indexOf(comment);

      //---------- SUBSTRING EACH LABELLED LINE TO INJECT MODIFIED VALUE

      a = inputSketch[ixInjectValues].substring(0, ix_at+1);
      b = inputSketch[ixInjectValues].substring(ix_at+1, ix_cl);
      c = inputSketch[ixInjectValues].substring(ix_cl, inputSketch[ixInjectValues].length());

      b = pamRefined.get(t).value;

      String modified = a + b + c ;

      inputSketch[ixInjectValues] = modified; // --> Injection
    }
  }

  /*------------------------------------------SAVE MODIFIED CODE FUNCTION-------------------------------------------------------------------*/
  /*----------------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (8) MODIFIED SKETCHES WITH PREVIOUS INJECTIONS EXPORTATIONS

  void modifiedSketch(int counter) {
    println("indiv " + nf(counter, 3) + " from population " + nf(popCounter, 3) + " exported.");

    for (int s = 0; s<inputSketch.length; s++) {
      saveStrings("variations/pop_" + nf(popCounter, 3) + "/indiv_"+nf(counter, 3) + "/indiv_"+nf(counter, 3) + ".pde", inputSketch);
    }
  }


  /*------------------------------------------RUN MODIFIED CODE SKETCHES FUNCTION-----------------------------------------------------------*/
  /*----------------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (9) MODIFIED SKETCHES EXECUTION ON SEPARATE WINDOWS

  void run_sketch(int counter) {
    String path = "";
    for (int f = 0; f < counter; f++) {
      path = "/Users/ricardosacadura/faculdade/quinto_ano/Tese/towards-automated-generative-design/variator/variations/pop_"+nf(popCounter, 3)+"/indiv_"+nf(f, 3);
      if (counter == -1) {
        println("nothing to run");
      } else {
        exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");
      }
    }
    println(nf(popCounter, 3));
  }

  //----------> (extra) SKETCH SIZE INFORMATION

  int [] getSketchSize() {

    int [] sketchSize = new int [2];
    int sizeW = 0, sizeH = 0;

    String comma = ",", paren = ")";
    int ix_comma = -1, ix_paren = -1;

    for (int i=0; i<inputSketch.length; i++) {
      ix_size = inputSketch[i].indexOf(size);
      if (ix_size != -1) {
        ix_comma  = inputSketch[i].indexOf(comma);
        ix_paren  = inputSketch[i].indexOf(paren);

        sizeW = int(inputSketch[i].substring(ix_size + 5, ix_comma));
        sizeH = int(inputSketch[i].substring(ix_comma + 2, ix_paren));
      }
    }

    sketchSize[0] = sizeW;
    sketchSize[1] = sizeH;

    return sketchSize;
  }

  //----------> (extra) POPULATIONS GRID DISPLAY

  void set_grid() {

    if (counterGridX == 3) {
      counterGridX = 0;
      counterGridY += 1;
    }

    gridX = (sketchW * counterGridX) + (23 * (counterGridX + 1));
    gridY = (sketchH * counterGridY) + 46 * (counterGridY + 1);

    counterGridX +=1;
  }
}
