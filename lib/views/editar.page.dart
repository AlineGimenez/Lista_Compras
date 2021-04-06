import 'package:flutter/material.dart';
import 'package:lista_compras/models/item.model.dart';
import 'package:lista_compras/repositories/lista.repository.dart';

class EditarPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = ListaC();
  final _repository = ListaRepository();

  onSave(BuildContext context, ListaC tarefas) {
    if (_formKey.currentState.validate()) {
      //validar as informações do form
      _formKey.currentState.save();
      _repository.update(_item, tarefas);
      Navigator.of(context).pop(true);
    } //submit do form do HTML
  }

  @override
  Widget build(BuildContext context) {
    ListaC item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar item da lista"),
        backgroundColor: Colors.teal,
        /*actions: [
          FlatButton(
            child: Text(
              "SALVAR",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => onSave(context, item),
          )
        ],*/
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: item.texto.toString(),
                decoration: InputDecoration(
                  labelText: "Descrição\n",
                  //border: OutlineInputBorder(),
                ),
                onSaved: (value) => _item.texto = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                initialValue: item.qtd.toString(),
                decoration: InputDecoration(
                  labelText: "Quantidade\n",
                  //border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _item.qtd = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),              
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.tealAccent,
                width: 300,
                height: 35,
                child: ElevatedButton(
                  child: Text(
                    'SALVAR',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => onSave(context, item),
                  style: ElevatedButton.styleFrom(primary: Colors.teal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
