import 'package:flutter/material.dart';
import 'package:hito3/servicios/firestore_service.dart';

class MazosAgregarPage extends StatefulWidget {
  MazosAgregarPage({Key? key}) : super(key: key);
  @override
  State<MazosAgregarPage> createState() => _MazosAgregarPageState();
}

class _MazosAgregarPageState extends State<MazosAgregarPage> {
  TextEditingController costeCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController fuerzaCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController resistenciaCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Mazo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              TextFormField(
                controller: costeCtrl,
                decoration: InputDecoration(
                  label: Text('Coste de mana'),
                ),
                validator: (coste) {
                  if (coste!.isEmpty) {
                    return ' Indique el coste de mana de la carta';
                  }
                  if (coste.length < 2) {
                    return 'indique el color y cantidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descripcionCtrl,
                decoration: InputDecoration(
                  label: Text('Descripcion'),
                ),
                validator: (descripcion) {
                  if (descripcion!.isEmpty) {
                    return ' Indique la descripcion de la carta';
                  }
                  if (descripcion.length < 2) {
                    return 'indique algo mas largo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: fuerzaCtrl,
                decoration: InputDecoration(
                  label: Text('Fuerza'),
                ),
                validator: (fuerza) {
                  if (fuerza!.isEmpty) {
                    return ' Indiqueel nombre del mazo';
                  }
                  if (fuerza.length > 2) {
                    return 'Colque un numero bien';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                ),
                validator: (nombre) {
                  if (nombre!.isEmpty) {
                    return ' Indiqueel nombre del jugador';
                  }
                  if (nombre.length < 2) {
                    return 'El nombre es muy corto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: resistenciaCtrl,
                decoration: InputDecoration(
                  label: Text('Recistencia'),
                ),
                validator: (vit) {
                  if (vit!.isEmpty) {
                    return ' Indiqueel nombre del mazo';
                  }
                  if (vit.length > 2) {
                    return 'Colque un numero bien';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Agregar Mazo',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirestoreService().MazoAgregar(
                        costeCtrl.text.trim(),
                        descripcionCtrl.text.trim(),
                        int.parse(fuerzaCtrl.text.trim()),
                        nombreCtrl.text.trim(),
                        int.parse(resistenciaCtrl.text.trim()),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
