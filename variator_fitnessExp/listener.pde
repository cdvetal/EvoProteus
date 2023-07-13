import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map; //--> HashMap Library

//------------------------------------------------> Server architeture utilities (Sketches)
Client clientSketches;
ArrayList <Server> serverSketches = new ArrayList<Server>(); //--> ArrayList storing one server per phenotype;
Listener sketches = new Listener();
String exitSketch = "1"; //--> Sent to each phenotype for 'extinguish' purposes

HashMap<String, Integer> windowStatus = new HashMap<String, Integer>(); //--> Window info. for fitness score

void serverOpen() {
  /*Iniciar o programa e criar um servidor, modelo baseado em multicast*/
  /*Multicast*/
  serverSketches.add(new Server(this, 3000 + counter)); // --> assigning new server each iteration
  //println(servers);
}

//------------------------------------------------> Server architeture utilities (Control panel)
Client clientPanel;
Server serverPanel = new Server(this, 8000); //--> Control panel server;
Listener controlPanel = new Listener();
String [] panelValues = new String[5]; //--> String to store listened operators values;

int sketchW, sketchH;

float fitnessSub = 0;

StringList sketchesName = new StringList();

class Listener {

  HashMap<String, int[]> positions = new HashMap<>();

  int screenW = Toolkit.getDefaultToolkit().getScreenSize().width; //--> Not used for now!
  int screenH = Toolkit.getDefaultToolkit().getScreenSize().height; //--> Not used for now!

  String indiv, fScore;


  //------------------------------------------------> Listens window status for each individual
  void listenStatus() {
    for (int i = 0; i < serverSketches.size(); i++) {
      clientSketches = serverSketches.get(i).available();

      if (clientSketches != null) {
        String input = clientSketches.readString().trim();
        try {
          String[] params = input.split(" ");
          if (params[0].equals("1")) {
            String sketchName = params[1];
            int status = int(params[2]);
            int x = int(params[3]);
            int y = int(params[4]);
            windowStatus.put(sketchName, status);
            positions.put(sketchName, new int[]{x, y});
          }
          if (params[0].equals("0")) {
            sketchesName.append(params[1]);
            println("Detected IP's: " + params[1] + " " + params[2]);
            //println(params[1]);
            
          }
        }
        catch(Exception exc) {
        }
      }
    }
  }

  //------------------------------------------------> Sketches location on-screen
  void sketchesLocation() {
    for (String value : positions.keySet()) {

      float difW = screenW - sketchW;
      float difY = screenH - sketchH;

      int [] pos = positions.get(value);
      float xPos =  map(pos[0], 0, difW, 0, 1);
      float yPos =  map(pos[1], 23, difY - 23, 0, 1);

      if (xPos >= 0 && xPos <= 1 && yPos <= 0.5) {
        //println(value + "seems nice - " + "x:" + pos[0] + " y:" + pos[1]);
      }

      if (pos[0] <= 0) {
        fitnessSub = map(pos[0], 0, -sketchW, 0, 1);
      } else if (pos[0] >= difW) {
        fitnessSub = map(pos[0], difW, screenW, 0, 1);
      } else if (pos[1] >= difY) {
        fitnessSub = map(pos[1], difY, screenH, 0, 1);
      }
    }
  }

  float getFitnessSub() {
    return fitnessSub;
  }

  //------------------------------------------------> Fitness score w/window status
  StringDict serverFitness() {

    StringDict info = new StringDict();

    for (Map.Entry me : windowStatus.entrySet()) {
      indiv  = me.getKey().toString();
      fScore = me.getValue().toString();
      /*float x = float(fScore);
       if (x == 1) {
       x -= fitnessSub;
       fScore = str(x);
       }*/
      info.set(indiv, fScore);
    }
    return info;
  }


  //------------------------------------------------> Listens control panel values
  void listenValues() {

    clientPanel = serverPanel.available();

    if (clientPanel != null) {
      String input = clientPanel.readString().trim();
      try {
        String[] params = input.split(" ");
        for (int l = 0; l < params.length; l++) {
          panelValues[l] = params[l];
          //println(params[l]);
        }
      }
      catch(Exception exc) {
      }
    }
  }

  //------------------------------------------------> Kills population
  void serverShutdown () {
    for (int i = 0; i < serverSketches.size(); i++) {
      serverSketches.get(i).write(exitSketch);
    }
  }

  String getIndiv () {
    return indiv;
  }

  String getFitness () {
    return fScore;
  }
}
