import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //obtener lista de cartas
  Stream<QuerySnapshot> Jugadores() {
    return FirebaseFirestore.instance.collection('Jugadores').snapshots();
  }

  Stream<QuerySnapshot> Cartas() {
    return FirebaseFirestore.instance.collection('Cartas').snapshots();
  }

  Future<QuerySnapshot> Tipo() {
    return FirebaseFirestore.instance.collection('Tipo').get();
  }

  Future<void> JugadoresAgregar(
      String nombre, String apellido, DateTime comienzo, String TipoMazo) {
    return FirebaseFirestore.instance.collection('Jugadores').doc().set({
      'Nombre': nombre,
      'Apellido': apellido,
      'Inicio': comienzo,
      'Tipo de mazo': TipoMazo,
    });
  }

  Future<void> MazoAgregar(String coste, String descripccion, int fuerza,
      String nombre, int resistencia) {
    return FirebaseFirestore.instance.collection('Cartas').doc().set({
      'Coste': coste,
      'Descripcion': descripccion,
      'Fuerza': fuerza,
      'Nombre': nombre,
      'Resistencia': resistencia,
    });
  }

  Future<void> BorrarJugador(String docId) {
    return FirebaseFirestore.instance
        .collection('Jugadores')
        .doc(docId)
        .delete();
  }
}
