class serverListener {

  HashMap<String, int[]> positions = new HashMap<>();

  int screenW = Toolkit.getDefaultToolkit().getScreenSize().width; //--> Not used for now
  int screenH = Toolkit.getDefaultToolkit().getScreenSize().height; //--> Not used for now

  String indiv, fScore;

  void listenStatus() { //--> Listen window status for each individual
    for (int i = 0; i < servers.size(); i++) {
      v_m = servers.get(i).available();

      if (v_m != null) {
        String input = v_m.readString().trim();
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

  /*void serverPrint() { //--> Print fitness score
    for (Map.Entry me : windowStatus.entrySet()) {
      //println(me.getKey() + " is " + me.getValue());
    }
  }*/

  void serverShutdown () { //--> Kill population
    for (int i = 0; i < servers.size(); i++) {
      servers.get(i).write(exitSketch);
    }
  }

  String getIndiv () {
    return indiv;
  }

  String getFitness () {
    return fScore;
  }
}
