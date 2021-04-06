import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lista_compras/models/item.model.dart';
import 'package:lista_compras/repositories/lista.repository.dart';

final repository = ListaRepository();
bool emFalta = false;
bool emFalta2 = false;
bool alterar = false;
bool excluir = false;
String espacamento = "";

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  List<ListaC> lista;

  Future atualizarEmFalta(BuildContext context, ListaC item) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        if (item.emFalta == true) {
          return AlertDialog(
            title: Text("Retirar produto do status 'Em Falta'?"),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("NÃO"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  espacamento = "";
                },
                child: Text("SIM"),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text("O produto está em falta no mercado?"),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("NÃO"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  espacamento = "";
                },
                child: Text("SIM"),
              ),
            ],
          );
        }
      },
    );
  }

  Future alteracao(BuildContext context, ListaC item) async {
    {
      var result = await Navigator.of(context).pushNamed(
        '/updatepage',
        arguments: item,
      );
      if (result == true && result != null) {
        setState(() {
          this.lista = repository.read();
          alterar = false;
          espacamento = "";
        });
      }
    }
  }

  Future exclusao(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text("Deseja deletar este produto?"),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("NÃO"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                espacamento = "";
              },
              child: Text("SIM"),
            ),
          ],
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    this.lista = repository.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de compras",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (_, indice) {
          var item = lista[indice];
          emFalta = item.emFalta;
          return buildCheckboxListTile(emFalta, item);
        },
      ),
      floatingActionButton: controllerSpeedDial(),
    );
  }

  CheckboxListTile buildCheckboxListTile(bool emFalta, ListaC item) {
    return CheckboxListTile(
      title: Row(
        children: [
          emFalta2
              ? IconButton(
                  icon: Icon(
                    Icons.warning,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onPressed: () async {
                    if (item.finalizada == false) {
                      var result = await atualizarEmFalta(context, item);
                      setState(() {
                        if (result == true && result != null) {
                          ListaC itemEF = item;
                          itemEF.emFalta = !item.emFalta;
                          repository.updateEmFalta(itemEF, item);
                          setState(() => this.lista = repository.read());
                          emFalta2 = false;
                        }
                      });
                    }
                  })
              : Container(),
          alterar
              ? IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onPressed: () => alteracao(context, item))
              : Container(),
          excluir
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onPressed: () async {
                    var result = await exclusao(context);
                    setState(
                      () {
                        if (result == true && result != null) {
                          repository.delete(item.texto);
                          setState(
                            () {
                              this.lista.remove(item);
                              excluir = false;
                            },
                          );
                        }
                      },
                    );
                  },
                )
              : Container(),
          emFalta2 || alterar || excluir
              ? SizedBox(
                  width: 20,
                )
              : Container(),
          emFalta
              ? Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 30,
                )
              : Container(),
          Text(
            item.texto,
            style: TextStyle(
              decoration: item.finalizada
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ],
      ),
      subtitle:
          Text(espacamento.toString() + "Quantidade: " + item.qtd.toString()),
      value: item.finalizada,
      onChanged: (value) {
        setState(() {
          if (item.emFalta == false) item.finalizada = value;
          this.lista = repository.read();
        });
      },
    );
  }

  SpeedDial controllerSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.warning,
            color: Colors.white,
          ),
          label: "Em Falta",
          labelBackgroundColor: Colors.redAccent,
          backgroundColor: Colors.red,
          onTap: () {
            setState(() {
              emFalta2 = !emFalta2;
              if (emFalta2) {
                espacamento = "                 ";
              } else
                espacamento = "";
              alterar = false;
              excluir = false;
            });
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          label: "Deletar",
          backgroundColor: Colors.deepOrangeAccent,
          onTap: () {
            setState(() {
              excluir = !excluir;
              if (excluir) {
                espacamento = "                 ";
              } else
                espacamento = "";
              emFalta2 = false;
              alterar = false;
            });
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: "Alterar",
          backgroundColor: Colors.grey,
          onTap: () {
            setState(() {
              alterar = !alterar;
              if (alterar) {
                espacamento = "                 ";
              } else
                espacamento = "";
              emFalta2 = false;
              excluir = false;
            });
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          label: "Adicionar",
          backgroundColor: Colors.blueAccent,
          onTap: () async {
            var result = await Navigator.of(context).pushNamed('/createpage');
            setState(() {
              if (result == true && result != null) {
                this.lista = repository.read();
              }
            });
          },
        ),
      ],
    );
  }
}
