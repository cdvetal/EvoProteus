/**
 Evaluation: CLIP model call.
 */

class Evaluator implements Runnable {

  private Genotype genotype;
  private String pathImage;
  private String prompt;
  //private final Object lock = new Object();

  public Evaluator(Genotype genotype, String pathImage, String prompt) {

    this.genotype = genotype;
    this.pathImage = pathImage;
    this.prompt = prompt;
  }

  public void run() {

    //System.out.println(Thread.currentThread().getName() + " strated to evaluate image: " + pathImage);

    Float fitness = null;
    //Float aestheticScore = null;
    Float clipScore = null;
    ProcessBuilder pb = new ProcessBuilder();

    String pathScript = sketchPath("MetricAPI/bridge_script.py");
    String pythonCmd = "/opt/anaconda3/envs/evoproteus/bin/python3";
    File pythonFile = new File(pythonCmd);
    if (!pythonFile.exists()) {
      pythonCmd = "python3";
    }
    pb.command(pythonCmd, pathScript, pathImage, prompt);

    try {
      Process process = pb.start();
      int exitCode = process.waitFor();

      BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
      BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
      String output = "";
      String errorOutput = "";
      String line = null;
      while ((line = reader.readLine()) != null) {
        output += line.trim();
      }
      while ((line = errorReader.readLine()) != null) {
        errorOutput += line + "\n";
      }

      if (exitCode != 0) {
        System.err.println("MetricAPI process failed for " + pathImage + " (exit " + exitCode + ")");
        if (output.length() > 0) {
          System.err.println("MetricAPI stdout: " + output);
        }
        if (errorOutput.length() > 0) {
          System.err.println(errorOutput);
        }
      } else {
        String jsonPayload = extractLastJsonObject(output);

        if (jsonPayload == null) {
          System.err.println("MetricAPI output is not valid JSON for " + pathImage + ": " + output);
        } else {
          JSONObject jsonData = JSONObject.parse(jsonPayload);

          //aestheticScore = jsonData.getFloat("aesthetic");
          clipScore = jsonData.getFloat("clip");

          fitness = clipScore;
        }
      }
      //fitness = aestheticScore/10;
      //fitness = clipScore + (aestheticScore / 200);
      //fitness = Float.parseFloat(output);
      process.destroy();
    }
    catch(Exception e) {
      e.printStackTrace();
    }

    if (fitness != null) {
      genotype.setFitness(fitness);
    }

    //System.out.println(Thread.currentThread().getName() + " fitness: " + fitness + " CLIP: " + clipScore + " LAION: " + aestheticScore);
    System.out.println(Thread.currentThread().getName() + " fitness: " + fitness);
  }

  private String extractLastJsonObject(String text) {
    if (text == null) {
      return null;
    }

    int start = text.lastIndexOf('{');
    int end = text.lastIndexOf('}');

    if (start == -1 || end == -1 || end <= start) {
      return null;
    }

    return text.substring(start, end + 1).trim();
  }
}
