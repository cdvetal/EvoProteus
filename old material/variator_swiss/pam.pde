// ------------------> ArrayList of Parameter objects
ArrayList<Parameters> parameters = new ArrayList<Parameters>(); //--> Set of parameter extracted from first pop.

class Parameters {

  String type, name, value, limits;

  Parameters(String t, String n, String v, String l) {

    type=t;
    name=n;
    value=v;
    limits=l;
  }
}
