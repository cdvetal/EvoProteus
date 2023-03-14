class Main {

  // --> ArrayList of objects
  ArrayList<Parameters> parameters = new ArrayList<Parameters>();
  ArrayList<Pam_refined> pam_refined = new ArrayList<Pam_refined>();

  IntList sketch_line = new IntList();
  IntList sketch_line_refined = new IntList();

  // --> note: the refined lists/arrays are created for outlier removal purposes;

  /*------------------------------------------SKETCHES CONCATENATION FUNCTION------------------------------------------------------*/
  /*-------------------------------------------------------------------------------------------------------------------------------*/

  /*String [] concatenator (String text_1 [], String text_2 []) {

    concat= concat(text_1, text_2);
    return concat;
  }*/

  StringList labeled_index = new StringList(); // --> String to store all labeled indexes
  //-----------------//
  String primitives_list [] = {"String", "float", "int", "char", "boolean"}; // --> Listing primitive data types
  //-----------------//
  String label = "__", attribution = "=", close = ";", comment = "//", min = "min:", max = "max:", setup = "void setup()", draw = "void draw()"; // --> labels
  String size = "size(";

  int ix_l = -1; // index of "__"
  int ix_at = -1, ix_cl = -1, ix_cm = -1; //--> index of "=" and ";"
  int ix_max = -1, ix_min = -1; //--> index of "min:" and "max:"
  int ix_setup = -1, ix_draw = -1; //--> index of "void setup()"
  int ix_size = -1; //--> index of "size(x,y);";

  //----------> (1) PARAMETERS CATEGORIZATION

  String type, name, value, limits, min_value, max_value;

  int grid_x = 0, grid_y =0 ;
  int counter_gridX = 0, counter_gridY=0;

  /*------------------------------------------PARAMETER EXTRACTION FUNCTION--------------------------------------------------------*/
  /*-------------------------------------------------------------------------------------------------------------------------------*/

  void extractor () {

    //----------> (2) SEARCHING THE CONCATENATED SKETCHES STRING

    for (int i=0; i<concat.length; i++) {

      ix_l = concat[i].indexOf(label);
      ix_at = concat[i].indexOf(attribution);
      ix_cl= concat[i].indexOf(close);
      ix_cm= concat[i].indexOf(comment);

      if (ix_l != -1 && ix_at != -1 && ix_cl != -1) {
        labeled_index.append(concat[i]);
        sketch_line.append(i);
      }
    }

    //----------> (3) INSPECTING THE IDENTIFIED LABELLED INDEXES

    for (int j=0; j<labeled_index.size(); j++) {

      ix_l = labeled_index.get(j).indexOf(label);
      ix_at = labeled_index.get(j).indexOf(attribution);
      ix_cl = labeled_index.get(j).indexOf(close);
      ix_cm = labeled_index.get(j).indexOf(comment);

      type = labeled_index.get(j).substring(0, ix_l-1); // --> substring variable type

      if (ix_l < ix_at) {
        name = labeled_index.get(j).substring(ix_l, ix_at); // --> substring variable name
      }

      value = labeled_index.get(j).substring(ix_at +1, ix_cl); // --> substring variable value

      if (ix_cm != -1) {
        limits = labeled_index.get(j).substring(ix_cm +2, labeled_index.get(j).length()); // --> substring variable comments
      } else {
        limits = "Undefined";
      }

      //-----------------//
      parameters.add(new Parameters(type, name, value, limits));
    }

    //----------> (4) REMOVE OUTLIERS, (preserve only parameters preceeded by variable declaration)

    for (int k = 0; k<parameters.size(); k++) {

      parameters.get(k).type =  parameters.get(k).type.trim();

      for (int l = 0; l< primitives_list.length; l++) {

        if (parameters.get(k).type.equals(primitives_list[l])) {
          pam_refined.add(new Pam_refined(parameters.get(k).type, parameters.get(k).name, parameters.get(k).value,
            parameters.get(k).limits));

          sketch_line_refined.append(sketch_line.get(k));
        }
      }
    }


    //----------> (5) PRINT RESULTS

    println("List of identified parameters:");

    for (int g = 0; g<pam_refined.size(); g++) {
      println(pam_refined.get(g).type);
      println(pam_refined.get(g).name);
      println(pam_refined.get(g).value);
      println(pam_refined.get(g).limits);
      println("-------------");
    }
  }

  /*------------------------------------------PARAMETER MANIPULATION FUNCTION--------------------------------------------------------*/
  /*---------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (6) EXTRACTED VALUES MANIPULATION

  void manipulator () {

    StringList variable_type = new StringList(); // --> StringList to help identify Datatype primitive

    for (int d = 0; d<pam_refined.size(); d++) {

      ix_min = pam_refined.get(d).limits.indexOf(min);
      ix_max = pam_refined.get(d).limits.indexOf(max);

      variable_type.append(pam_refined.get(d).type);

      if (ix_min != -1) {

        min_value =  pam_refined.get(d).limits.substring(ix_min +4, ix_max-1);
        max_value =  pam_refined.get(d).limits.substring(ix_max +4, pam_refined.get(d).limits.length());

        if (variable_type.get(d).equals(primitives_list[1])) { // --> change float values
          float n_value = random(float(min_value), float(max_value));
          pam_refined.get(d).value = str(n_value);
          //-----------------//
        } else if (variable_type.get(d).equals(primitives_list[2])) { // --> change int values
          int n_value = round(random(int(min_value), int(max_value)));
          pam_refined.get(d).value = str(n_value);
          //-----------------//
        } else if (variable_type.get(d).equals(primitives_list[4])) { // --> change boolean values
          boolean n_value =   random(2) > 1;
          pam_refined.get(d).value = str(n_value);
          //-----------------//
        }
      } else {
        min_value = "undefined";
        max_value = "undefined";
      }
    }
  }

  void injector_A (int counter) {

    // --> Client-Server injection code entries
    String injected_setup [] = new String [5];
    String injected_begin [] = new String [8];
    String injected_draw  [] = new String [5];


    injected_begin [7] = "import processing.net.*; //INJECTED LINE";
    injected_begin [6] = "import processing.awt.PSurfaceAWT; //INJECTED LINE";
    injected_begin [5] = "PSurfaceAWT.SmoothCanvas smoothCanvas; //INJECTED LINE";
    injected_begin [4] = "Client v_m; //INJECTED LINE";
    injected_begin [3] = "int listener = 0; //INJECTED LINE";
    injected_begin [2] = "void exit() { windowOpen = false; thread(\"exitDelay\");}";
    injected_begin [1] = "boolean windowOpen = true;";
    injected_begin [0] = "void exitDelay(){delay(1000); System.exit(0);}";



    injected_setup [4] = "surface.setLocation("+ grid_x + ","+ grid_y+"); //INJECTED LINE";
    injected_setup [3] = "PSurfaceAWT awtSurface = (PSurfaceAWT)surface; //INJECTED LINE";
    injected_setup [2] = "smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative(); //INJECTED LINE";
    injected_setup [1] = "println(\"[Client] Client connected\"); //INJECTED LINE";
    injected_setup [0] = "v_m = new Client(this, \"localhost\", 3000 + " + counter + "); //INJECTED LINE";

    injected_draw [4] = "final String sketch = getClass().getName();//INJECTED LINE";
    injected_draw [3] = "java.awt.Point p = new java.awt.Point();//INJECTED LINE";
    injected_draw [2] = "smoothCanvas.getFrame().getLocation(p);//INJECTED LINE";
    injected_draw [1] = "if (windowOpen==true) {listener=1; } else {  listener=0;} //INJECTED LINE";
    injected_draw [0] = "v_m.write(sketch + \" \" + listener + \" \"); //INJECTED LINE";
    //injected_draw [1] = "v_m.write(sketch + \" \" + p.x + \" \" + p.y + \" \"); //INJECTED LINE";

    //-----------------//
    for (int q=0; q<concat.length; q++) {

      ix_setup = concat[q].indexOf(setup); // --> Finding void setup() in input sketch

      if (ix_setup != -1) {
        for (int l = 0; l<injected_setup.length; l++) {
          concat = splice(concat, injected_setup[l], q+1);
        }
      }
    }
    //-----------------//
    for (int q=0; q<concat.length; q++) {

      ix_draw = concat[q].indexOf(draw); // --> Finding void draw() in input sketch

      if (ix_draw != -1) {
        for (int l = 0; l<injected_draw.length; l++) {
          concat = splice(concat, injected_draw[l], q+1);
        }
      }
    }
    //-----------------//
    int last_ix = concat.length; // --> Finding last line in input sketch

    for (int p = 0; p<injected_begin.length; p++) {
      concat = splice(concat, injected_begin[p], last_ix);
    }
  }

  /*------------------------------------------MODIFIED PARAMETERS INJECTION FUNCTION + SERVER-CLIENT UTILITIES------------------------------*/
  /*----------------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (7) MANIPULATED VALUES INJECTION

  void injector_B () {

    String a, b, c;
    int ix_inject_values; // --> Stores each sketch_line to be variated


    for (int t = 0; t < sketch_line_refined.size(); t++) {

      ix_inject_values = sketch_line_refined.get(t);

      ix_l = concat[ix_inject_values].indexOf(label);
      ix_at = concat[ix_inject_values].indexOf(attribution);
      ix_cl= concat[ix_inject_values].indexOf(close);
      ix_cm= concat[ix_inject_values].indexOf(comment);

      //---------- SUBSTRING EACH LABELLED LINE TO INJECT MODIFIED VALUE

      a = concat[ix_inject_values].substring(0, ix_at +1);
      b = concat[ix_inject_values].substring(ix_at+1, ix_cl);
      c = concat[ix_inject_values].substring(ix_cl, concat[ix_inject_values].length());

      b = pam_refined.get(t).value;

      String modified = a + b + c ;

      concat[ix_inject_values] = modified; // --> Injection
    }
  }

  /*------------------------------------------SAVE MODIFIED CODE FUNCTION-------------------------------------------------------------------*/
  /*----------------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (8) MODIFIED SKETCHES WITH PREVIOUS INJECTIONS EXPORTATIONS

  void modified_sketch(int counter) {
    println("modified_"+nf(counter, 3)+" exported.");

    for (int s = 0; s<concat.length; s++) {
      saveStrings("variations/modified_"+nf(counter, 3)+"/modified_"+nf(counter, 3)+".pde", concat);
    }
  }


  /*------------------------------------------RUN MODIFIED CODE SKETCHES FUNCTION-----------------------------------------------------------*/
  /*----------------------------------------------------------------------------------------------------------------------------------------*/

  //----------> (9) MODIFIED SKETCHES EXECUTION ON SEPARATE WINDOWS

  void run_sketch(int counter) {
    String path = "";
    for (int f = 0; f < counter; f++) {
      path = "/Users/ricardosacadura/faculdade/5º ano/Tese + Bolsa/04. Prova de conceito/variator/variations/modified_" + nf(f, 3);
      if (counter == -1) {
        println("nothing to run");
      } else {
        exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");
      }
    }
  }

  int [] get_sketch_size() {

    int [] s_size = new int [2];
    int size_W = 0, size_H = 0;

    String comma = ",", paren = ")";
    int ix_comma = -1, ix_paren = -1;

    for (int i=0; i<concat.length; i++) {
      ix_size = concat[i].indexOf(size);
      if (ix_size != -1) {
        ix_comma  = concat[i].indexOf(comma);
        ix_paren  = concat[i].indexOf(paren);

        size_W = int(concat[i].substring(ix_size + 5, ix_comma));
        size_H = int(concat[i].substring(ix_comma + 2, ix_paren));
      }
    }

    s_size[0] = size_W;
    s_size[1] = size_H;

    return s_size;
  }

  void set_grid() {

    if (counter_gridX == 3) {
      counter_gridX = 0;
      counter_gridY += 1;
    }

    grid_x = (sketch_W * counter_gridX) + (23 * (counter_gridX + 1));
    grid_y = (sketch_H * counter_gridY) + 46 * (counter_gridY + 1);

    counter_gridX +=1;
  }
}
