class Server_Listener {

  HashMap<String, int[]> positions = new HashMap<>();

  int screen_W = Toolkit.getDefaultToolkit().getScreenSize().width;
  int screen_H = Toolkit.getDefaultToolkit().getScreenSize().height;

  /* void server_extract() {
   //criar arrayList global
   for (int i = 0; i < servers.size(); i++) {
   v_m = servers.get(i).available();
   
   if (v_m != null) {
   String input = v_m.readString().trim();
   try {
   String[] params = input.split(" ");
   String sketch_name = params[0];
   int x = int(params[1]);
   int y = int(params[2]);
   positions.put(sketch_name, new int[]{x, y});
   }
   catch(Exception exc) {
   }
   }
   }
   }*/


  void listen_status() {
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

  void server_print() {
    for (Map.Entry me : window.entrySet()) {
      print(me.getKey() + " is ");
      println(me.getValue());
    }
  }

  /* void server_print() {
   for (String name : positions.keySet()) {
   int[] pos = positions.get(name);
   println(name + " - x:" + pos[0] + " y:" + pos[1]);
   }
   } */



  /* void get_location() {
   for (String value : positions.keySet()) {
   int [] pos = positions.get(value);
   float xPos =  map(pos[0], 0, screen_W - sketch_W, 0, 1);
   float yPos =  map(pos[1], 23, screen_H - sketch_H - 23, 0, 1);
   if (xPos >= 0 && xPos <= 1 && yPos <= 0.5) {
   //println(value + "seems nice - " + "x:"+pos[0]+" y:"+pos[1]);
   }
   }
   }*/
}
