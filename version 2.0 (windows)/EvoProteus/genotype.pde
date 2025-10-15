/**
 Genotype: Representation and Variation Operators
 */

int genCounter = -1;
int numGenes = 0;

class Genotype {

  StringDict genes = new StringDict(); //--> List of extracted parameters (previous population)
  StringList genesMin = new StringList(); //--> List of extracted parameters min. exploration envelope
  StringList genesMax = new StringList(); //--> List of extracted parameters max. exploration envelope
  float fitness = 0;
  String type, value;

  String [] keysList;

  Genotype () {
  }

  void arrange (String t, String v, String min, String max) {
    genes.set(t, v);
    genesMin.append(min);
    genesMax.append(max);
    ++ numGenes;
  }

  Genotype(StringDict genes) {
    this.genes = genes;
  }

  Genotype onePointCrossover(Genotype parent) {

    String [] childGenes = new String[genes.size()];
    keysList = genes.keyArray();

    Genotype child = new Genotype();
    StringDict parentGenes = parent.getGenes();

    int crossoverPoint = int(random(1, genes.size() - 1));

    for (int i = 0; i < genes.size(); ++ i) {

      if (i < crossoverPoint) {
        childGenes[i] = genes.get(keysList[i]);
        child.genesMin.set(i, genesMin.get(i));
        child.genesMax.set(i, genesMax.get(i));
      } else {
        //println("-> cut point <-");
        childGenes[i] = parentGenes.get(keysList[i]);
        child.genesMin.set(i, parent.genesMin.get(i));
        child.genesMax.set(i, parent.genesMax.get(i));
      }

      child.genes.set(keysList[i], childGenes[i]);
    }
    return child;
  }

  void mutate() {

    keysList = genes.keyArray();

    for (int i = 0; i < genes.size(); ++ i) {

      if (random(1) <= mutationRate) {

        String [] keyType = keysList[i].split(",");
        //println(keyType[1]);

        float min = float(genesMin.get(i));
        float max = float(genesMax.get(i));

        float current = float(genes.get(keysList[i]));
        float valueRange = max - min;
        float stdDeviation = valueRange * mutationScaling;

        float newValue = current + (randomGaussian() * stdDeviation);
        //--> The original randomGaussian() has std. deviation of 1 and a mean of 0
        //--> When multiplied by the valueRange, the means is still 0 but the std. dev. is 1 * valueRange

        if (keyType[1].equals(primitives[1])) { //--> Mutate floats
          float mutation = constrain(newValue, min, max);
          genes.set(keysList[i], str(mutation));
          //println("Mutation operator:", keyType + " Current: " + current + " mutatedValue: " + mutation);
          //println("Genes sized:", genes.size());
          //println("");
        } else if (keyType[1].equals(primitives[2])) { //--> Mutate ints
          int mutation = int(constrain(newValue, min, max));
          genes.set(keysList[i], str(mutation));
          //println(keyType + " Current: " + current + " mutatedValue: " + mutation);
          //println("");
        } else if (keyType[1].equals(primitives[4])) { //--> Mutate booleans
          boolean mutation =   random(2) > 1;
          genes.set(keysList[i], str(mutation));
          //println(keyType + " Current: " + current + " mutatedValue: " + mutation);
          //println("");
        }
      }
    }
  }

  void setFitness(float fitness) {
    this.fitness = fitness;
  }

  float getFitness() {
    return fitness;
  }

  //------------------------------------------------> Gets a clean copy
  Genotype getCopy() {
    Genotype copy = new Genotype();
    copy.fitness = fitness;
    copy.genesMin = genesMin.copy();
    copy.genesMax = genesMax.copy();

    //----------------------------------------------> Deep copy the StringDict
    for (String key : genes.keys()) {
      copy.genes.set(key, genes.get(key));
    }

    return copy;
  }

  StringDict getGenes() {
    return genes;
  }

  //------------------------------------------------> Genotype update based on user feedback regarding the parameters list
  Genotype updateGeneList(Genotype previous) {

    Genotype updated = new Genotype(genes);
    StringDict previousGenes = previous.getGenes();

    for (int i = 0; i < genes.size(); ++ i) {
      if (str(genes.keyArray()[i].charAt(0)).equals(updateParams.get(i))) {
        updated.genes.set(keysList[i], previousGenes.get(keysList[i]));
      }
    }
    return updated;
  }
}
