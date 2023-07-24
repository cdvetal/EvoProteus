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
          String sketchName = params[0];
          int status = int(params[1]);
          windowStatus.put(sketchName, status);
        }
        catch(Exception exc) {
        }
      }
    }
  }

  //------------------------------------------------> Fitness score w/window status
  StringDict serverFitness() {

    StringDict info = new StringDict();

    for (Map.Entry me : windowStatus.entrySet()) {
      indiv  = me.getKey().toString();
      fScore = me.getValue().toString();
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
