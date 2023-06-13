class Genotype {

  StringDict genes = new StringDict(); //--> List of extracted parameters (previous population)
  StringList genesMin = new StringList(); //--> List of extracted parameters min. exploration envelope
  StringList genesMax = new StringList(); //--> List of extracted parameters max. exploration envelope
  float fitness = 0;
  String type, value;

  Genotype () {
  }

  void arrange(String t, String v, String min, String max) {
    genes.set(t, v);
    genesMin.append(min);
    genesMax.append(max);
    //genes.sortKeys();
    //println("original:" + genes);
    numGenes++;
  }

  void mutate() {
    String [] keysList = genes.keyArray();

    for (int i = 0; i < genes.size(); i++) {

      if (random(1) <= mutationRate) {

        String keyType = keysList[i].substring(1, keysList[i].length());
        float min = float(genesMin.get(i));
        float max = float(genesMax.get(i));

        float stdDeviation = (max - min) / 20.0; //--> Standard deviation parameter

        float current = float(genes.get(keysList[i]));
        float newValue = current + randomGaussian() * stdDeviation;

        if (keyType.equals(primitivesList[1])) { //--> Mutate floats
          float mutation = constrain(newValue, min, max);
          genes.set(keysList[i], str(mutation));
          println(keyType + " current: " + current + " mutatedValue: " + mutation);
          println("");
          //-----------------//
        } else if (keyType.equals(primitivesList[2])) { //--> Mutate ints
          int mutation = int(constrain(newValue, min, max));
          genes.set(keysList[i], str(mutation));
          println(keyType + " current: " + current + " mutatedValue: " + mutation);
          println("");
          //-----------------//
        } else if (keyType.equals(primitivesList[4])) { //--> Mutate booleans
          boolean mutation =   random(2) > 1;
          genes.set(keysList[i], str(mutation));
          println(keyType + " current: " + current + " mutatedValue: " + mutation);
          println("");
          //-----------------//
        }
      }
    }
  }
}
