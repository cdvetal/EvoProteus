// ------------------> ArrayList of Parameter objects
ArrayList<pamRefined> pamRefined = new ArrayList<pamRefined>(); //--> Refined set (without outliers)

class pamRefined {

  String type, name, value, limits;

  pamRefined(String t, String n, String v, String l) {

    type=t;
    name=n;
    value=v;
    limits=l;
  }
}
