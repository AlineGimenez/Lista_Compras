import 'package:lista_compras/models/item.model.dart';

class ListaRepository {
  static List<ListaC> itensC = List<ListaC>();

  ListaRepository() {
    if (itensC.isEmpty) {
      itensC.add(ListaC(id: "1", texto: "Arroz", qtd: "2"));
      itensC.add(ListaC(id: "2", texto: "Feijão", qtd: "4"));
    }
  }

  void create(ListaC item) {
    itensC.add(item);
  }

  List<ListaC> read() {
    List<ListaC> listaN = List<ListaC>();
    List<ListaC> listaF = List<ListaC>();
    List<ListaC> listaEF = List<ListaC>();
    int i = 0;

    while (i < itensC.length) {
      if (itensC[i].finalizada == true) {
        listaEF.add(itensC[i]);
      } else {
        if (itensC[i].emFalta == true) {
          listaEF.add(itensC[i]);
        } else {
          listaF.add(itensC[i]);
        }
      }
      i++;
    }
    itensC = listaN + listaF + listaEF;
    return itensC;
    //return itensC;
  }

  List<ListaC> atualizarPage() {
    List<ListaC> listaN = List<ListaC>();
    List<ListaC> listaF = List<ListaC>();
    List<ListaC> listaEF = List<ListaC>();
    int i = 0;

    while (i < itensC.length) {
      if (itensC[i].finalizada == true) {
        listaEF.add(itensC[i]);
      } else {
        if (itensC[i].emFalta == true) {
          listaEF.add(itensC[i]);
        } else {
          listaF.add(itensC[i]);
        }
      }
      i++;
    }
    itensC = listaN + listaF + listaEF;
    return itensC;
    //return itensC;
  }

  void delete(String texto) {
    final item = itensC.singleWhere((t) => t.texto == texto);
    itensC.remove(item);
  }

  void updateEmFalta(ListaC newItem, ListaC oldItem) {
    final item = itensC.singleWhere((t) => t.texto == oldItem.texto);
    item.emFalta = newItem.emFalta;
  }

  void update(ListaC newItem, ListaC oldItem) {
    final item = itensC.singleWhere((t) => t.texto == oldItem.texto);
    item.texto = newItem.texto;
    item.qtd = newItem.qtd;
  }
}
