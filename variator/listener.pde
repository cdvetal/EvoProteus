class serverListener {

  HashMap<String, int[]> positions = new HashMap<>();

  int screenW = Toolkit.getDefaultToolkit().getScreenSize().width;
  int screenH = Toolkit.getDefaultToolkit().getScreenSize().height;

  void listenStatus() {
    for (int i = 0; i < servers.size(); i++) {
      v_m = servers.get(i).available();

      if (v_m != null) {
        String input = v_m.readString().trim();
        try {
          String[] params = input.split(" ");
          String sketch_name = params[0];
          int status = int(params[1]);
          window.put(sketch_name, status);
        }
        catch(Exception exc) {
        }
      }
    }
  }

  void serverPrint() {
    for (Map.Entry me : window.entrySet()) {
      println(me.getKey() + " is " + me.getValue());
    }
  }

  void serverShutdown () {
    for (int i = 0; i < servers.size(); i++) {
      servers.get(i).write(exitSketch);
    }
  }
}
