// ---- DEBUG
import java.io.InputStreamReader;
import java.io.FileInputStream;

Process process;
BufferedReader readerInput;
BufferedReader readerError;

String path = "";


void setup() {
  size(100, 100);
}

void draw() {

  path = "/Users/ricardosacadura/faculdade/quinto_ano/Tese/towards-automated-generative-design/variator_fitnessExp/variations/pop_000/indiv_000/";
  process = exec("/usr/local/bin/processing-java", "--sketch=" + path, "--run");

  readerInput = new BufferedReader(new InputStreamReader(process.getInputStream()));
  readerError = new BufferedReader(new InputStreamReader(process.getErrorStream()));


  // Get output of the command line
  try {
    String line = null;
    while ((line = readerInput.readLine()) != null) {
      println(line);
    }
  }
  catch(IOException e) {
    e.printStackTrace();
  }

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
  
  println("ola");
  if (frameCount % 60 == 0) {
    println(frameCount);
  }
}
