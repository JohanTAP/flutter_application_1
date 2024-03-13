import 'package:flutter/material.dart';
import '../models/orden.dart';

class OrdenDetailsView extends StatelessWidget {
  final Orden orden;

  const OrdenDetailsView({super.key, required this.orden});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Orden'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID de la Orden: ${orden.idorden}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'ID del Paciente: ${orden.idPaciente}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'ID del Usuario del Recepcionista: ${orden.idUsuarioRecepcionista}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'ID del Doctor: ${orden.idDoctor}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (orden.idAsistenteDental != null)
              Text(
                'ID del Asistente Dental: ${orden.idAsistenteDental}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
