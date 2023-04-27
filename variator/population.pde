class Population {

  Main m;
  Genotype [] parent;


  Population() {
    m = new Main();
  }

  void initialize() { //--> Generates initial population

    m.extractor(); // --> parameter extraction
    parent = new Genotype[populationSize];

    for (int i = 0; i < populationSize; i++) {

      serverOpen(); //--> Open servers for population

      m.manipulator();//--> input values to random values between established boundaries
      m.setGrid();//--> Display population on-screen
      m.injectorA(indivCounter);// --> Client-Server injection code entries and other utilities

      m.injectorB(genotype.get(i).genes.valueArray()); // --> variated values injection
      //println(genotype.get(i).genes.valueArray());
      m.popExport(indivCounter); // --> modified sketch exportation gathering all changes

      indivCounter++;
      counter++;
      inputSketch=original; //--> Reset injection A (avoid overwride)
    }

    for (int i = 0; i < populationSize; i++) {
      parent[i]=genotype.get(i);
    }
  }

  void evolve() {

    Genotype [] newGeneration = new Genotype[genotype.size()]; //--> (Note) Genotype is an extraction of the genetic code of each initial individual

    for (int i = 0; i < eliteSize; i++) {
      newGeneration[i] = parent[i];
    }

    // Initiate new generation
    for (int i = eliteSize; i < populationSize; i++) {
      newGeneration[i]= parent[i];
      //println("Population 0, " + "Individual "+i+" :" + genotype.get(i).genes);
    }

    // Mutate new individuals
    for (int i = eliteSize; i < populationSize; i++) {
      newGeneration[i].mutate();
      //println("Population 1, " + "Individual "+i+" :" + newGeneration[i].genes);
    }

    for (int i = 0; i < populationSize; i++) {
      parent[i] = newGeneration[i];
    }

    popCounter++;

    //Don't know if it's necessary ? m.setGrid();
    for (int i = 0; i < populationSize; i++) {
      serverOpen(); //--> Open servers for population

      m.setGrid();//--> Display population on-screen
      m.injectorA(indivCounter);
      m.injectorB(parent[i].genes.valueArray());
      //println(newGeneration[i].genes.valueArray());

      m.popExport(indivCounter);

      indivCounter++;
      counter++;
      inputSketch=original; //--> Reset injection A (avoid overwride)
    }
  }

  void renderPop() {
    m.runSketch(counter); // --> Execute modified sketches in separate windows
  }

  int getGenerations() {
    return popCounter;
  }
}
