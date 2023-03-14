// "Towards Automated Generative Design", Concept-proof - parameters extraction and manipulation for optimized solutions, Ricardo Sacadura

import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map;

ArrayList <Server> servers = new ArrayList<Server>(); //--> ArrayList of Servers for each variation
Client v_m;

String file_1 [] = {"/n"};
String file_2 [] = {"/n"};
int [] org_size = new int[2];
int sketch_W, sketch_H;

String concat [] = {"/n"};
String original [] = {"/n"};
String path = "/n";
File selection;

int counter=0; // --> global variable for variations & servers labelling

Main m = new Main();
Server_Listener s = new Server_Listener();
Button [] b  = new  Button [4]; // --> Array of button objects

PFont font;
String SGrotesk_SemiBold = "data/SpaceGrotesk-SemiBold.ttf";
String SGrotesk_Regular = "data/SpaceGrotesk-Regular.ttf";


float btn_height = 420; // --> Firts button y-pos on screen
String [] btn_txt = new String [4];


HashMap<String, Integer> window = new HashMap<String, Integer>();
int c= 0;

void setup() {

  size(300, 650);
  surface.setLocation(displayWidth - (displayWidth/4), displayHeight/7);
  pixelDensity(2);
  background(255);
  title_elements(font, SGrotesk_SemiBold, 24, "Variator", 35);
  title_elements(font, SGrotesk_Regular, 14, "Proof of concept", 60);


  //-----------------//
  btn_txt [0] = "Run my sketch (opcional)";
  btn_txt [1] = "Generate variations (1)";
  btn_txt [2] = "Run variations (2)";
  btn_txt [3] = "Store fittest candidates (3)";

  for (int u  = 0; u < b.length; u++) {
    b[u] = new Button(width/2, btn_height, 250, 40, btn_txt[u]); // --> menu buttons init
    btn_height += 60;
  }

  // --> .pde skecthes extraction
  selectInput("Select a file to process:", "fileSelected");

  //file_1= loadStrings("/Users/ricardosacadura/faculdade/5º ano/Tese + Bolsa/04. Prova de conceito/sketches/bouncy_balls/bouncy_balls.pde");
  //file_2= loadStrings("/Users/ricardosacadura/faculdade/5º ano/Tese + Bolsa/04. Prova de conceito/sketches/bouncy_balls/render.pde");

  //m.concatenator(file_1, file_2); // --> input .pde concatenation
}

void draw() {
  //s.server_extract(); // --> "Clients" positions on screen listener (NOT IN USE)


  for (Button button : b) {
    button.update(mouseX, mouseY);
    button.create(font, SGrotesk_Regular);
  }

  s.listen_status();
  s.server_print();


  //s.get_location(); // --> Get location onscreen (NOT IN USE)
}

void mousePressed() {

  for (int g  = 0; g < b.length; g++) {

    if (b[g].get_hover() == true) {
      //-----------------//
      if (g==0) {
        String path_org = "/Users/ricardosacadura/faculdade/5º ano/Tese + Bolsa/04. Prova de conceito/sketches/bouncy_balls";
        exec("/usr/local/bin/processing-java", "--sketch=" + path_org, "--run");
        //-----------------//
      } else if (g == 1) {
        int iteration [] = new int [3];
        for (int v : iteration) {
          servers.add(new Server(this, 3000 + counter)); // --> assigning new server each iteration
          m.manipulator();  // --> input values to random values between established boundaries
          m.set_grid();
          m.injector_A(counter); // --> Client-Server injection code entries
          m.injector_B(); // --> vartiated values injection
          m.modified_sketch(counter); // --> modified sketch exportation gathering all changes
          counter++;
          //-----------------//
          //m.concatenator(file_1, file_2); // --> Necessary to return to org sketch each iteration
          concat=original;
        }
        //-----------------//
      } else if (g==2) {
        m.run_sketch(counter); // --> Execute modified sketches in separate windows
      } else if (g==3) {
        background(255);
        c=0;
        title_elements(font, SGrotesk_SemiBold, 24, "Variator", 35);
        title_elements(font, SGrotesk_Regular, 14, "Proof of concept", 60);
        elements(font, SGrotesk_SemiBold, 14, "Fittest candidates:", 100);

        for (Map.Entry me : window.entrySet()) {
          if (me.getValue().equals(1)) {
            String object = me.getKey().toString();
            title_elements(font, SGrotesk_Regular, 14, object, 140 + c*40);
            c += 1;
          }
        }
      }
    }
  }
}

// --> Title elements function

void title_elements (PFont title, String font_path, int size, String text, float yPos) {
  title = createFont(font_path, 100);
  fill(0);
  textAlign(CENTER);
  textFont(title);
  textSize(size);
  text(text, width/2, yPos);
}

void elements (PFont title, String font_path, int size, String text, float yPos) {

  title = createFont(font_path, 100);
  fill(0);
  textAlign(CENTER);
  textFont(title);
  textSize(size);
  text(text, width/2, yPos);
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    original = loadStrings(selection.getAbsolutePath());
    concat = original;
    path = selection.getAbsolutePath();
    m.extractor(); // --> parameter extraction
    org_size = m.get_sketch_size();
    sketch_W = org_size[0];
    sketch_H =  org_size[1];
    //println("User selected " + path);
  }
}
