import 'package:flutter/material.dart';
import 'package:lista_compras/models/item.model.dart';
import 'package:lista_compras/repositories/lista.repository.dart';

class CriarPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = ListaC();
  final _repository = ListaRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar item"),
        backgroundColor: Colors.teal,
        actions: [
          FlatButton(
            child: Text(" + ADICIONAR",
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () => onSave(context),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    //border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _item.texto = value,
                  validator: (value) =>
                      value.isEmpty ? "Campo obrigatório" : null,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Quantidade",
                    //border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _item.qtd = value,
                  validator: (value) =>
                      value.isEmpty ? "Campo obrigatório" : null,
                )
              ],
            )),
      ),
    );
  }
}
