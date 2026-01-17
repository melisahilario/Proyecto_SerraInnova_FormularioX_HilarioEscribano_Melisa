import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/consulta.dart';

class ConsultaProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Consulta> _consultas = [];
  List<Consulta> get consultas => _consultas;

  final List<String> tiposConsulta = [
    'Información sobre viviendas sostenibles disponibles',
    'Alquiler social y acceso a la vivienda para colectivos vulnerables',
    'Publicación de una vivienda por parte de propietarios comprometidos con la sostenibilidad',
    'Documentación y trámites administrativos',
    'Incidencias técnicas relacionadas con la web o la aplicación',
    'Otras consultas generales',
  ];

  Future<void> cargarConsultas() async {
    try {
      final snapshot = await _firestore.collection('consultas').get();
      _consultas = snapshot.docs
          .map((doc) => Consulta.fromJson(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error cargando consultas: $e');
    }
  }

  Future<void> agregarConsulta(Consulta consulta) async {
    try {
      final docRef = await _firestore
          .collection('consultas')
          .add(consulta.toJson());
      consulta.documentId = docRef.id;
      _consultas.add(consulta);
      notifyListeners();
    } catch (e) {
      debugPrint('Error agregando consulta: $e');
      rethrow;
    }
  }

  Future<void> eliminarConsulta(String? documentId) async {
    if (documentId == null) return;
    try {
      await _firestore.collection('consultas').doc(documentId).delete();
      _consultas.removeWhere((c) => c.documentId == documentId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error eliminando consulta: $e');
    }
  }
}
