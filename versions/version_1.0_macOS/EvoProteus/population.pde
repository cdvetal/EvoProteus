/**
 Population: Selection, Evolution and Renderization
 */

//------------------------------------------------> Genetic operators init.
int populationSize = 1;
int eliteSize = 1;
int tournamentSize = 3;
float crossoverRate = 1;
float mutationRate = 0;
float mutationScaling = 0.05;

class Population {

  Main m;
  Genotype [] individuals;


  Population() {
    m = new Main();
  }

  //------------------------------------------------> Generates initial population
  void initialize() {

    m.extractor(); // --> Parameter extraction
    individuals = new Genotype[populationSize];

    for (int i = 0; i < populationSize; ++ i) {

      serverOpen(); //--> Open servers for population

      m.manipulator();//--> input values to random values between established boundaries
      m.setGrid();//--> Display population on-screen
      m.injectorA(netCounter, i);// --> Client-Server injection code entries and other utilities

      m.injectorB(genotype.get(i).genes.valueArray()); // --> variated values injection
      m.popExport(indivCounter); // --> modified sketch exportation gathering all changes

      ++ indivCounter;
      netCounter += int(random(0, 1000));
      inputSketch = original; //--> Reset injection A (avoid overwride)
    }

    for (int i = 0; i < populationSize; ++ i) {
      individuals[i] = genotype.get(i);
    }
  }

  void evolve() {

    Genotype [] newGeneration = new Genotype[individuals.length]; //--> (Note) Genotype is an extraction of the genetic code of each initial individual

    //------------------------------------------------> Sort individuals by fitness
    sortByFitness();

    //------------------------------------------------> DEBUG
    /*for (int a = 0; a < individuals.length; ++ a) {
     //println("Individual", a, individuals[a].genes.get("0float"));
     }*/

    //------------------------------------------------> Copy elite

    for (int a = 0; a < eliteSize; ++ a) {
      newGeneration[a] = individuals[a].getCopy();
      //println("Elite", a, newGeneration[a].genes.get("0float"));
    }

    //------------------------------------------------> Create new generation with crossover operator
    for (int i = eliteSize; i < newGeneration.length; ++ i) {

      if (random(1) <= crossoverRate) {
        Genotype parent1 = tournamentSelection();
        Genotype parent2 = tournamentSelection();
        Genotype child = parent1.onePointCrossover(parent2);
        newGeneration[i] = child;
      } else {
        newGeneration[i] = tournamentSelection().getCopy();
      }
      //println("Crossover population, " + "Individual " + i + " :" + newGeneration[i].genes);
    }

    //------------------------------------------------> Mutate new individuals
    for (int i = eliteSize; i < newGeneration.length; ++ i) {
      
      newGeneration[i].mutate();
      
      //println("Elite", 0, newGeneration[0].genes.get("0float"));
    }

    //------------------------------------------------> DEBUG
    /*for (int a = 0; a < individuals.length; ++ a) {
     //println("Individual", a, individuals[a].genes.get("0float"));
     }*/

    for (int i = eliteSize; i < individuals.length; ++ i) {
      individuals[i].setFitness(0);
    }

    for (int i = 0; i < individuals.length; ++ i) {

      //newGeneration[i].updateGeneList(individuals[i]);
      individuals[i] = newGeneration[i].getCopy();
    }

    ++ popCounter;

    for (int i = 0; i < individuals.length; ++ i) {
      serverOpen(); //--> Open servers for population
      m.setGrid();//--> Display population on-screen
      m.injectorA(netCounter, i);
      m.injectorB(individuals[i].genes.valueArray());
      m.popExport(indivCounter);
      ++ indivCounter;
      ++ netCounter;
      inputSketch = original; //--> Reset injection A (avoid overwrite)
    }
  }

  //------------------------------------------------> Select one individual using a tournament selection
  Genotype tournamentSelection() {
    // Select a random set of individuals from the population
    Genotype[] tournament = new Genotype[tournamentSize];

    for (int i = 0; i < tournament.length; ++ i) {
      int random_index = int(random(0, individuals.length));
      tournament[i] = individuals[random_index];
    }
    // Get the fittest individual from the selected individuals
    Genotype fittest = tournament[0];
    for (int i = 1; i < tournament.length; ++ i) {
      if (tournament[i].getFitness() > fittest.getFitness()) {
        fittest = tournament[i];
      }
    }
    return fittest;
  }

  void sortByFitness () {
    Arrays.sort(individuals, new Comparator<Genotype>() {
      public int compare(Genotype indiv1, Genotype indiv2) {
        return Float.compare(indiv2.getFitness(), indiv1.getFitness());
      }
    }
    );
  }

  //------------------------------------------------> Get an individual from the population located at the given index
  Genotype getIndiv(int index) {
    return individuals[index];
  }

  void renderPop() {
    m.runSketch(indivCounter); // --> Execute modified sketches in separate windows
  }

  void reRenderIndiv() {
    try {
      StringList javaProcesses = new StringList();
      javaProcesses = getCurrentJavaProcesses();
      m.zombieDetector(sketchesName, javaProcesses);
    }
    catch (Exception e) {
    }
  }

  int getGenerations() {
    return popCounter;
  }
}
