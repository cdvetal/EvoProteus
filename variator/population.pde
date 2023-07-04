class Population {

  Main m;
  Genotype [] ancestors;


  Population() {
    m = new Main();
  }

  void initialize() { //--> Generates initial population

    m.extractor(); // --> parameter extraction
    ancestors = new Genotype[populationSize];

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
      ancestors[i]=genotype.get(i);
    }
  }

  void evolve() {

    Genotype [] newGeneration = new Genotype[genotype.size()]; //--> (Note) Genotype is an extraction of the genetic code of each initial individual

    //--> Copy elite
    for (int i = 0; i < eliteSize; i++) {
      newGeneration[i] = ancestors[i];
    }

    //--> Create new generation with crossover operator
    for (int i = eliteSize; i < populationSize; i++) {
      if (random(1) <= crossoverRate) {
        
        Genotype parent1 = tournamentSelection();
        Genotype parent2 = tournamentSelection();
        Genotype child = parent1.onePointCrossover(parent2);
        newGeneration[i] = child;
      } else {
        newGeneration[i] = tournamentSelection().getCopy();
      }

      //println("Population 0, " + "Individual "+i+" :" + genotype.get(i).genes);
    }

    // Mutate new individuals
    for (int i = eliteSize; i < populationSize; i++) {
      //newGeneration[i] = ancestors[i];
      newGeneration[i].mutate();
      //println("Population 1, " + "Individual "+i+" :" + newGeneration[i].genes);
    }

    for (int i = 0; i < populationSize; i++) {
      ancestors[i] = newGeneration[i];
    }

    popCounter++;

    //Don't know if it's necessary ? m.setGrid();
    for (int i = 0; i < populationSize; i++) {
      serverOpen(); //--> Open servers for population

      m.setGrid();//--> Display population on-screen
      m.injectorA(indivCounter);
      m.injectorB(ancestors[i].genes.valueArray());
      //println(newGeneration[i].genes.valueArray());

      m.popExport(indivCounter);

      indivCounter++;
      counter++;
      inputSketch=original; //--> Reset injection A (avoid overwride)
    }
  }

  //--> Select one individual using a tournament selection
  //algum tem maior 1
  Genotype tournamentSelection() {
    // Select a random set of individuals from the population
    Genotype[] tournament = new Genotype[tournamentSize];
    for (int i = 0; i < tournament.length; i++) {
      int random_index = int(random(0, ancestors.length));
      tournament[i] = ancestors[random_index];
    }
    // Get the fittest individual from the selected individuals
    Genotype fittest = tournament[0];
    for (int i = 1; i < tournament.length; i++) {
      if (tournament[i].getFitness() > fittest.getFitness()) {
        fittest = tournament[i];
      }
    }
    return fittest;
  }

  // Get an individual from the population located at the given index
  Genotype getIndiv(int index) {
    return ancestors[index];
  }

  void renderPop() {
    m.runSketch(counter); // --> Execute modified sketches in separate windows
  }

  int getGenerations() {
    return popCounter;
  }
}
