import 'package:flutter/material.dart';
import '../models/consulta.dart';

class TarjetaConsulta extends StatelessWidget {
  final Consulta consulta;
  final VoidCallback onDelete;

  const TarjetaConsulta({
    super.key,
    required this.consulta,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          '${consulta.nombreApellidos} - ${consulta.tipo.split(' ').take(3).join(' ')}',
        ),
        subtitle: Text(
          '${consulta.email}\n${consulta.fechaCreacion.toString().substring(0, 16)}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
