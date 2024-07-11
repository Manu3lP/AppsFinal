import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hito3/servicios/firestore_service.dart';
import 'package:hito3/pages/JugadoresAgregar.dart';
import 'package:hito3/widgets/campo_jugador.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Jugadores extends StatefulWidget {
  const Jugadores({super.key});

  @override
  State<Jugadores> createState() => _JugadoresState();
}

class _JugadoresState extends State<Jugadores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase jugadores'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirestoreService().Jugadores(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var jugador = snapshot.data!.docs[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: MdiIcons.trashCan,
                          label: 'Borrar',
                          backgroundColor: Colors.pink,
                          onPressed: (context) {
                            FirestoreService().BorrarJugador(jugador.id);
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(MdiIcons.cardsDiamond),
                      title:
                          Text('${jugador['Nombre']} ${jugador['Apellido']}'),
                      subtitle: Text('(${jugador['Tipo de mazo']})'),
                      onLongPress: () {
                        mostrarInformacion(context, jugador);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => JugadoresAgregarPage());
          Navigator.push(context, route);
        },
      ),
    );
  }

  void mostrarInformacion(BuildContext context, jugador) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 350,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              border: Border.all(color: Colors.blue.shade900, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                CampoJugador(
                    dato: '${jugador['Nombre']} ${jugador['Apellido']}',
                    icono: MdiIcons.account),
                CampoJugador(
                    dato: 'Modo de juego:${jugador['Tipo de mazo']}',
                    icono: MdiIcons.gamepad),
                CampoJugador(
                    dato: 'Comenzo a jugar el: ${jugador['Inicio'].toDate()}',
                    icono: MdiIcons.calendar),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text('Cerrar'),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
