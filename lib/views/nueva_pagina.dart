import 'package:flutter/material.dart';
import '../models/radiografia.dart';
import '../services/orden_service.dart'; // Asegúrate de importar OrdenService
import '../models/orden.dart';

class NuevaPagina extends StatelessWidget {
  final Orden orden;

  const NuevaPagina({Key? key, required this.orden}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Página'),
      ),
      body: FutureBuilder<List<Radiografia>>(
        future: OrdenService.fetchRadiografias(orden.idorden),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar las radiografías. Por favor, inténtalo de nuevo más tarde.',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            // Aquí puedes mostrar los datos de las radiografías
            final radiografias = snapshot.data!;
            return ListView.builder(
              itemCount: radiografias.length,
              itemBuilder: (context, index) {
                final radiografia = radiografias[index];
                // Reemplazar los espacios en la URL
                final url = radiografia.rutaRadiografia.replaceAll(' ', '%20');
                // Aquí muestra cada radiografía en la lista
                return ListTile(
                  title: Text('Radiografía ${index + 1}'),
                  subtitle: Image.network(url),
                );
              },
            );
          }
        },
      ),
    );
  }
}
