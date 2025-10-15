/**
 Evaluation: CLIP model call.
 */

class Evaluator implements Runnable {

  private Genotype genotype;
  private String pathImage;
  private String prompt;
  private final Object lock = new Object();

  public Evaluator(Genotype genotype, String pathImage, String prompt) {

    this.genotype = genotype;
    this.pathImage = pathImage;
    this.prompt = prompt;
  }

  public void run() {

    //System.out.println(Thread.currentThread().getName() + " strated to evaluate image: " + pathImage);

    Float fitness = null;
    ProcessBuilder pb = new ProcessBuilder();

    String pathScript = "C:/Users/cdv/Desktop/ricardosacadura_research/Towards-Automated-Generative-Design/EvoProteus/MetricAPI/bridge_script.py";
    pb.command("C:/Users/cdv/anaconda3/envs/evoproteus/python", pathScript, pathImage, prompt);

    try {
      Process process = pb.start();
      process.waitFor();

      BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
      String output = "";
      String line = null;
      while ((line = reader.readLine()) != null) {
        output += line.trim();
      }
      fitness = Float.parseFloat(output);
      process.destroy();
    }
    catch(Exception e) {
      e.printStackTrace();
    }

    if (fitness != null) {
      genotype.setFitness(fitness);
    }

    System.out.println(Thread.currentThread().getName() + " finished with the fitness: " + fitness);
  }
}
