import processing.net.*; //--> Client-Server Network
import java.awt.Toolkit; //--> Screen information
import java.util.Map; //--> HashMap Library

// ------------------> Server architeture utilities (Sketches)
Client clientSketches;
ArrayList <Server> serverSketches = new ArrayList<Server>(); //--> ArrayList storing one server per phenotype;
Listener sketches = new Listener();
String exitSketch = "1"; //--> Sent to each phenotype for 'extinguish' purposes
HashMap<String, Integer> windowStatus = new HashMap<String, Integer>(); //--> Window info. for fitness score

// ------------------> Server architeture utilities (Control panel)
Client clientPanel;
Server serverPanel = new Server(this, 8000); //--> Control panel server;
Listener controlPanel = new Listener();
String [] panelValues = new String[5]; //--> String to store listened operators values;

class Listener {

  HashMap<String, int[]> positions = new HashMap<>();

  int screenW = Toolkit.getDefaultToolkit().getScreenSize().width; //--> Not used for now
  int screenH = Toolkit.getDefaultToolkit().getScreenSize().height; //--> Not used for now

  String indiv, fScore;


  void listenStatus() { //--> Listen window status for each individual
    for (int i = 0; i < serverSketches.size(); i++) {
      clientSketches = serverSketches.get(i).available();

      if (clientSketches != null) {
        String input = clientSketches.readString().trim();
        try {
          String[] params = input.split(" ");
          String sketch_name = params[0];
          int status = int(params[1]);
          windowStatus.put(sketch_name, status);
        }
        catch(Exception exc) {
        }
      }
    }
  }

  StringDict serverFitness() { //--> Fitness score w/window status

    StringDict info = new StringDict();

    for (Map.Entry me : windowStatus.entrySet()) {
      indiv  = me.getKey().toString();
      fScore = me.getValue().toString();
      info.set(indiv, fScore);
    }

    return info;
  }

  void listenValues() { //--> Listen control panel values

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

  void serverShutdown () { //--> Kill population
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
