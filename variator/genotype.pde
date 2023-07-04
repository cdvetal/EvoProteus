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
    //genes.sortKeys();
    //println("original:" + genes);
    numGenes++;
  }

  Genotype(StringDict genes) {
    this.genes = genes;
  }

  Genotype onePointCrossover(Genotype parent) {

    String [] childGenes = new String[genes.size()];
    keysList = genes.keyArray();

    Genotype child = new Genotype();
    StringDict parentGenes = parent.getGenes();

    int crossover_point = int(random(1, genes.size() - 1));

    for (int i = 0; i < genes.size(); i++) {

      if (i < crossover_point) {
        childGenes[i] = genes.get(keysList[i]);
        child.genesMin.set(i, genesMin.get(i));
        child.genesMax.set(i, genesMax.get(i));
        println("parent 1 Genes " + childGenes[i]);
        //println(i + " Child Genes 1: " + child.genes.get(keysList[i]));
      } else {
        println("crossover point <-");
        childGenes[i] = parentGenes.get(keysList[i]);
        child.genesMin.set(i, parent.genesMin.get(i));
        child.genesMax.set(i, parent.genesMax.get(i));
        //println(i + " Child Genes 2: " + child.genes.get(keysList[i]));
        println("parent 2 Genes " + parentGenes.get(keysList[i]));
      }

      child.genes.set(keysList[i], childGenes[i]);
    }

    //println(" Boundaries " + child.genesMin + " " + child.genesMax);

    return child;
  }

  void mutate() {

    //println("Boundaries on mutate " + genesMin + " " + genesMax);
    keysList = genes.keyArray();

    for (int i = 0; i < genes.size(); i++) {

      if (random(1) <= mutationRate) {

        String keyType = keysList[i].substring(1, keysList[i].length());
        float min = float(genesMin.get(i));
        float max = float(genesMax.get(i));
        //float min = 0;
        //float max = 1;

        float stdDeviation = (max - min) / 20.0; //--> Standard deviation parameter

        float current = float(genes.get(keysList[i]));
        float newValue = current + randomGaussian() * stdDeviation;

        if (keyType.equals(primitivesList[1])) { //--> Mutate floats
          float mutation = constrain(newValue, min, max);
          genes.set(keysList[i], str(mutation));
          //println(keyType + " current: " + current + " mutatedValue: " + mutation);
          println("");
          //-----------------//
        } else if (keyType.equals(primitivesList[2])) { //--> Mutate ints
          int mutation = int(constrain(newValue, min, max));
          genes.set(keysList[i], str(mutation));
          //println(keyType + " current: " + current + " mutatedValue: " + mutation);
          println("");
          //-----------------//
        } else if (keyType.equals(primitivesList[4])) { //--> Mutate booleans
          boolean mutation =   random(2) > 1;
          genes.set(keysList[i], str(mutation));
          //println(keyType + " current: " + current + " mutatedValue: " + mutation);
          println("");
          //-----------------//
        }
      }
    }
  }

  //--> Set the fitness value
  void setFitness(float fitness) {
    this.fitness = fitness;
  }

  //--> Get the fitness value
  float getFitness() {
    return fitness;
  }

  //--> Get a clean copy
  Genotype getCopy() {
    Genotype copy = new Genotype(genes);
    copy.fitness = fitness;
    copy.genesMin = genesMin;
    copy.genesMax = genesMax;
    return copy;
  }

  StringDict getGenes() {
    return genes;
  }
}
