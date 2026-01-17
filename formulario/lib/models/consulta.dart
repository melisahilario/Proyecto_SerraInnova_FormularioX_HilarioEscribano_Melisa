import 'package:cloud_firestore/cloud_firestore.dart';

class Consulta {
  String? documentId;
  String tipo;
  String nombreApellidos;
  String email;
  String? telefono;
  String descripcion;
  DateTime fechaCreacion;
  bool aceptacionPrivacidad;

  Consulta({
    this.documentId,
    this.tipo = 'Otras consultas generales',
    required this.nombreApellidos,
    required this.email,
    this.telefono,
    required this.descripcion,
    required this.aceptacionPrivacidad,
    DateTime? fechaCreacion,
  }) : fechaCreacion = fechaCreacion ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'nombreApellidos': nombreApellidos,
      'email': email,
      'telefono': telefono,
      'descripcion': descripcion,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
      'aceptacionPrivacidad': aceptacionPrivacidad,
    };
  }

  factory Consulta.fromJson(Map<String, dynamic> json, String id) {
    return Consulta(
      documentId: id,
      tipo: json['tipo'] ?? 'Otras consultas generales',
      nombreApellidos: json['nombreApellidos'] ?? '',
      email: json['email'] ?? '',
      telefono: json['telefono'],
      descripcion: json['descripcion'] ?? '',
      aceptacionPrivacidad: json['aceptacionPrivacidad'] ?? false,
      fechaCreacion: (json['fechaCreacion'] as Timestamp).toDate(),
    );
  }
}
