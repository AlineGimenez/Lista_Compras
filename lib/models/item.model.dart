class ListaC {
  //Atributos
  String id;
  String texto;
  String qtd;
  bool finalizada;
  bool emFalta;

  //Contrutor
  ListaC(
      {this.id,
      this.texto,
      this.qtd,
      this.finalizada = false,
      this.emFalta = false});
}
