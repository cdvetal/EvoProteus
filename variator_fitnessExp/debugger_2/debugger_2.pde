import processing.net.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;

Client clientSketches;
ArrayList <Server> serverSketches = new ArrayList<Server>(); //--> ArrayList storing one server per phenotype;

int counter = 0;
int populationSize = 5;

String [] sketches = new String [populationSize];

ArrayList<Process> process = new ArrayList<Process>(); // --> Stores exec() process chain

void setup() {

  for (int i = 0; i < 5; i++) {
    try {
      //String path = sketchPath("sketches/indiv_000");
      String path = sketchPath("sketches/indiv_"+nf(i, 3));
      delay(100);
      Process v = exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");
      process.add(v);
      //println("Detected id's: " + process.get(i).pid());
      println("Detected process: " + i + " " + process.get(i));
      serverSketches.add(new Server(this, 3000 + i));
    }
    catch (Exception e) {
    }
  }
}

void draw() {

  serverListen();
}

StringDict serverListen() {

  StringDict clientInfo = new StringDict();

  for (int j = 0; j < serverSketches.size(); j++) {

    clientSketches = serverSketches.get(j).available();

    if (clientSketches != null) {
      String input = clientSketches.readString().trim();
      try {
        println(input);
        //Process v = Runtime.getRuntime().exec("kill -9 " + input);
        //v.waitFor();
        //println("Kill process: " + v);
      }
      catch(Exception exc) {
      }
    }
  }

  return clientInfo;
}

void keyPressed() {

  if (key == 'a') {
    destroyProcesses(process);
  }

  if (key == 'b') {
    try {
      javaProcesses = getRunningJavaProcesses();
      println(javaProcesses);
    }
    catch (Exception e) {
    }
  }

  if (key == 'c') {
    String [] processList;
    StringList windowProcesses = new StringList();

    for (int i = 0; i < javaProcesses.size(); ++i) {
      processList = javaProcesses.get(i).split(" ");
      if (processList[1].equals("processing.core.PApplet")) windowProcesses.append(processList[0]);
    }
    println(windowProcesses);
    try {
      for (int i = 1; i < windowProcesses.size(); i++) {
        //Runtime.getRuntime().exec("kill " + windowProcesses.get(i));
      }
    }
    catch (Exception e) {
    }
  }
}

StringList javaProcesses = new StringList();

void destroyProcesses(ArrayList <Process> process) {

  for (int i = 0; i < process.size(); ++i) {
    try {
      //Process c = exec("/usr/local/bin/processing-java", "ps -ax | grep", "java");
      //println(" ");
      //println("extracted id: " + c);
      process.get(i).destroy();
      process.get(i).waitFor();
      println(process.get(i));
    }
    catch (Exception e) {
    }
  }
}

StringList getRunningJavaProcesses() throws Exception {
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

/*void serverEvent(Server someServer, Client someClient) {
 println("We have a new client: " + someClient.ip());
 counter++;
 println(counter);
 }*/



// https://youtrack.jetbrains.com/issue/JBR-5462
// https://bugs.openjdk.org/browse/JDK-8066436
// https://github.com/frohoff/jdk8u-jdk/blob/master/src/macosx/classes/sun/lwawt/macosx/CPlatformWindow.java
