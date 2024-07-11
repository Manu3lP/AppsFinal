import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hito3/pages/MazosAgregar.dart';
import 'package:hito3/servicios/firestore_service.dart';

class Mazos extends StatefulWidget {
  const Mazos({super.key});

  @override
  State<Mazos> createState() => _MazosState();
}

class _MazosState extends State<Mazos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Mazos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirestoreService().Cartas(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var carta = snapshot.data!.docs[index];
                  return ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text(
                        '${carta['Nombre']} (${carta['Fuerza']} / ${carta['Resistencia']})'),
                    subtitle: Text('(${carta['Coste']})'),
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
              MaterialPageRoute(builder: (context) => MazosAgregarPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
