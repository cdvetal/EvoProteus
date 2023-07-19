import java.io.InputStreamReader;
import java.io.FileInputStream;

void setup() {
  for (int i = 0; i < 10; i++) {
    println("Launching processing sketch #" + (i + 1));
    thread("launchProcessingSketch");
  }
}

void draw() {
}

void launchProcessingSketch() {
  String path = "/Users/ricardosacadura/faculdade/quinto_ano/Tese/towards-automated-generative-design/variator_fitnessExp/inputs/circles/";
  Process process = exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");

  //BufferedReader readerInput = new BufferedReader(new InputStreamReader(process.getInputStream()));
  BufferedReader readerError = new BufferedReader(new InputStreamReader(process.getErrorStream()));

  // Get output of the command line
  /* try {
   String line = null;
   while ((line = readerInput.readLine()) != null) {
   println(line);
   }
   }
   catch(IOException e) {
   e.printStackTrace();
   } */

  // Get possible errors of the command line
  try {
    String line = null;
    while ((line = readerError.readLine()) != null) {
      println(line);
    }
  }
  catch(IOException e) {
    e.printStackTrace();
  }
}

// https://youtrack.jetbrains.com/issue/JBR-5462
// https://bugs.openjdk.org/browse/JDK-8066436
// https://github.com/frohoff/jdk8u-jdk/blob/master/src/macosx/classes/sun/lwawt/macosx/CPlatformWindow.java
