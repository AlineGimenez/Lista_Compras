import 'package:flutter/material.dart';
import 'package:lista_compras/views/criar.page.dart';
import 'package:lista_compras/views/editar.page.dart';
import 'package:lista_compras/views/lista.page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ListaPage(),
        '/createpage': (context) => CriarPage(),
        '/updatepage': (context) => EditarPage()
      },
      initialRoute: '/',
    );
  }
}
