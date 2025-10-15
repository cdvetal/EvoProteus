/**
 Sockets: Communication between Candidates and System
 */

//------------------------------------------------> Server architeture utilities (Sketches)
Client clientSketches;
ArrayList <Server> serverSketches = new ArrayList<Server>(); //--> ArrayList storing one server per phenotype;
Listener sketches = new Listener();
String exitSketch = "1"; //--> Sent to each phenotype for 'extinguish' purposes

HashMap<String, Integer> windowStatus = new HashMap<String, Integer>(); //--> Window info. for fitness score

void serverOpen() {
  serverSketches.add(new Server(this, 3000 + netCounter)); // --> assigning new server each iteration
}

int sketchW, sketchH;
float fitnessSub = 0; //--> Stores fitness score based on sketch location
StringList sketchesName = new StringList(); //--> Stores sketchesName (debug)

String niceSketch = "";
boolean fav = false;

class Listener {

  HashMap<String, float[]> positions = new HashMap<>();

  int screenW = Toolkit.getDefaultToolkit().getScreenSize().width;
  int screenH = Toolkit.getDefaultToolkit().getScreenSize().height;

  String indiv, fScore = "1.0";


  //------------------------------------------------> Listens valuable info. from each individual
  void listenMain() {

    for (int i = 0; i < serverSketches.size(); ++ i) {
      clientSketches = serverSketches.get(i).available();

      if (clientSketches != null) {

        String input = clientSketches.readString().trim();
        try {
          String[] params = input.split(" ");
          if (params[0].equals("1")) {

            String sketchName = params[1]; //--> Sketches name
            int status = int(params[2]); //--> Window status (open/closed)
            float x = float(params[3]); //--> X-position on-screen
            float y = float(params[4]); //--> Y-position on-screen

            windowStatus.put(sketchName, status); //--> Stores status
            positions.put(sketchName, new float[]{x, y, fitnessSub}); //--> Stores positions
          }
          if (params[0].equals("0")) {
            sketchesName.append(params[1]);
            if (params[2].length() > 5) {
              String cutID = params[2].substring(0, 5);
              healthySketchesID.append(cutID);
              println(params[1] + " rendered." + " ID: " + cutID);
            } else {
              healthySketchesID.append(params[2]);
              println(params[1] + " rendered." + " ID: " + params[2]);
            }
          }
        }
        catch(Exception exc) {
        }
      }
    }
  }

  //------------------------------------------------> Sketches location on-screen
  /* void sketchesLocation() {
   for (String value : positions.keySet()) {
   
   float difW = screenW - sketchW;
   float difY = screenH - sketchH;
   
   float [] pos = positions.get(value);
   
   if (pos[0] <= 0) {
   pos[2] = map(pos[0], 0, -sketchW, 0, 1);
   } else if (pos[0] >= difW) {
   pos[2] = map(pos[0], difW, screenW, 0, 1);
   } else if (pos[1] >= difY) {
   pos[2] = map(pos[1], difY, screenH, 0, 1);
   } else {
   }
   }
   } */

  float getFitnessSub() {
    return fitnessSub;
  }

  //------------------------------------------------> Fitness score w/window status
  StringDict serverFitness() {

    StringDict info = new StringDict();

    for (Map.Entry<String, float[]> entry : positions.entrySet()) {
      indiv  = entry.getKey().toString();
      float[] pos = entry.getValue();

      for (Map.Entry me : windowStatus.entrySet()) {
        if (me.getValue().toString().equals("0")) {
          fScore = "0.00";
          info.set(me.getKey().toString(), fScore);
        } else {
          fScore = nf(1-pos[2], 0, 2);
          info.set(indiv, fScore);
        }
      }
    }

    return info;
  }

  //------------------------------------------------> Kills population
  void windowShutdown () {
    for (int i = 0; i < serverSketches.size(); ++ i) {
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

//------------------------------------------------> Stores current java processes method

StringList getCurrentJavaProcesses() throws Exception {

  Process process = Runtime.getRuntime().exec("jps -l");
  BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
  StringList output = new StringList();
  String line;

  while ((line = reader.readLine()) != null) {
    output.append(line);
  }

  reader.close();
  return output;
}

boolean allWindowsOpen() {

  float aliveCounter = 0;

  for (Map.Entry me : windowStatus.entrySet()) {
    if (me.getValue().toString().equals("1")) {
      ++aliveCounter;
    }
  }
  if (aliveCounter == populationSize) {
    return true;
  } else {
    return false;
  }
}
