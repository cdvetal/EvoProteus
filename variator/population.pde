
class Population {

  Main m;

  Population() {
    m = new Main();
  }

  void initialize() { //--> Generates initial population
    int iteration [] = new int [populationSize];
    m.extractor(); // --> parameter extraction

    for (int v : iteration) {

      serverOpen();
      m.manipulator();  // --> input values to random values between established boundaries
      m.set_grid();
      m.injectorA(counter); // --> Client-Server injection code entries
      m.injectorB(); // --> vartiated values injection
      m.modifiedSketch(counter); // --> modified sketch exportation gathering all changes
      counter++;

      inputSketch=original;
    }
  }

  void evolve() {
    
  }

  void renderPop() {
    m.run_sketch(counter); // --> Execute modified sketches in separate windows
    println();
  }
}
