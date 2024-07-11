// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hito3/tabs/mazos.dart';
import 'package:hito3/tabs/jugadores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indice = 0;
  List<Widget> paginas = [
    Jugadores(),
    Mazos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[indice],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Jugadores',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Mazos'),
        ],
        currentIndex: indice,
        onTap: (opcionSelec) {
          print('OPCION SELECCIONADA: $opcionSelec');
          indice = opcionSelec;
          setState(() {});
        },
      ),
    );
  }
}
