class ChordLibraryModel {
  ChordLibraryModel(this.scale,this.root,this.tonality, this.variationsList);

  String scale;
  String root;
  String tonality;
  List<Chord> variationsList;
}

class Chord {

  Chord(this.p, this.f);
  String p;
  String f;
}
