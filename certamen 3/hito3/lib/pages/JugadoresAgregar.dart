import 'package:flutter/material.dart';
import 'package:hito3/servicios/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JugadoresAgregarPage extends StatefulWidget {
  JugadoresAgregarPage({Key? key}) : super(key: key);
  @override
  State<JugadoresAgregarPage> createState() => _JugadoresAgregarPageState();
}

class _JugadoresAgregarPageState extends State<JugadoresAgregarPage> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime fecha_inicio = DateTime.now();
  final formatoFecha = DateFormat('dd-MM-yyyy');
  String mazo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Jugador',
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
                controller: nombreCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                ),
                validator: (nombre) {
                  if (nombre!.isEmpty) {
                    return ' Indique el nombre del jugador';
                  }
                  if (nombre.length < 2) {
                    return 'El nombre es muy corto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: apellidoCtrl,
                decoration: InputDecoration(
                  label: Text('Apellido'),
                ),
                validator: (apellido) {
                  if (apellido!.isEmpty) {
                    return ' Indique el apellido del jugador';
                  }
                  if (apellido.length < 2) {
                    return 'El apellido es muy corto';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text('Fecha de inicio en magic:'),
                    Text(formatoFecha.format(fecha_inicio),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Spacer(),
                    IconButton(
                      icon: Icon(MdiIcons.calendar),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1993),
                                lastDate: DateTime.now(),
                                locale: Locale('es', 'ES'))
                            .then((fecha) {
                          setState(() {
                            fecha_inicio = fecha ?? fecha_inicio;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: FirestoreService().Tipo(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Cargando Modalidades....');
                  } else {
                    var Tipo = snapshot.data!.docs;
                    return DropdownButtonFormField<String>(
                      value: mazo == '' ? Tipo[0]['Tipo de mazo'] : mazo,
                      decoration: InputDecoration(labelText: 'Mazos'),
                      items: Tipo.map<DropdownMenuItem<String>>((mazo) {
                        return DropdownMenuItem<String>(
                          child: Text(mazo['Tipo de mazo']),
                          value: mazo['Tipo de mazo'],
                        );
                      }).toList(),
                      onChanged: (mazoSeleccionado) {
                        setState(() {
                          this.mazo = mazoSeleccionado!;
                        });
                      },
                    );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 39),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Agregar Jugador',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirestoreService().JugadoresAgregar(
                        nombreCtrl.text.trim(),
                        apellidoCtrl.text.trim(),
                        this.fecha_inicio,
                        this.mazo,
                        //TipoMazoCtrl.text.trim(),
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
