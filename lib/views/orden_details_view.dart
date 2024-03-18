import 'package:flutter/material.dart';
import '../common_layout.dart';
import '../models/orden.dart';
import '../services/orden_service.dart'; // Importa el servicio de órdenes

class OrdenDetailsView extends StatefulWidget {
  final Orden orden;

  const OrdenDetailsView({super.key, required this.orden});

  @override
  _OrdenDetailsViewState createState() => _OrdenDetailsViewState();
}

class _OrdenDetailsViewState extends State<OrdenDetailsView> {
  late Map<String, dynamic> _orderStatus = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrderStatus();
  }

  void _fetchOrderStatus() async {
    try {
      final orderStatus =
          await OrdenService.fetchOrderStatus(widget.orden.idorden);
      setState(() {
        _orderStatus = orderStatus;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching order status: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      title: 'Detalle orden',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Orden N°: ${widget.orden.idorden}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Fecha de toma: ${widget.orden.fechaSolicitud}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Hora: ${widget.orden.horaSolicitud}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sucursal: ${widget.orden.sucursal}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text(
                  'Estado: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : _buildOrderStatusCard(_formatOrderStatus(_orderStatus)),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text(
                  'Paciente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${widget.orden.nombresPaciente} ${widget.orden.apellidoPaterno} ${widget.orden.apellidoMaterno}',
                    ),
                    Text(
                      'Edad: ${_calculateAge(widget.orden.fechaNacimiento)} años',
                    ),
                    Text(
                      'Número: ${widget.orden.telefono}',
                    ),
                    Text(
                      'Correo: ${widget.orden.email}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text(
                  'Doctor(a)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Nombre: ${widget.orden.nombreDoctor}'),
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              elevation: 4,
              child: ExpansionTile(
                title: Text(
                  'Examenes tomados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                children: [
                  SizedBox(
                    height: 300, // Altura específica para el TabBarView
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: 'Imagenes'),
                              Tab(text: 'Informes'),
                              Tab(text: 'Archivos'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Contenido de la pestaña 'Imagenes'
                                Center(
                                  child: Text('Contenido de imagenes'),
                                ),
                                // Contenido de la pestaña 'Informes'
                                Center(
                                  child: Text('Contenido de informes'),
                                ),
                                // Contenido de la pestaña 'Archivos'
                                Center(
                                  child: Text('Contenido de archivos'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusCard(String orderStatus) {
    // Verifica si el estado es "TERMINADO" o "PENDIENTE DE INFORMAR"
    bool isCompleted = orderStatus == 'TERMINADO';
    bool isPending = orderStatus == 'PENDIENTE DE INFORMAR';

    return Card(
      elevation: 4,
      color: isCompleted
          ? Colors.lightGreen[100]
          : isPending
              ? Colors.yellow[100]
              : null, // Color de fondo verde claro si está terminado
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          orderStatus,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isCompleted
                ? Colors.green
                : isPending
                    ? Colors.orange
                    : null, // Color de texto verde si está terminado
          ),
        ),
      ),
    );
  }

  String _formatOrderStatus(Map<String, dynamic> orderStatus) {
    final allCompleted =
        orderStatus.values.every((status) => status == 'TERMINADO');
    final allPending =
        orderStatus.values.every((status) => status == 'PENDIENTE DE INFORMAR');
    final realStatus = orderStatus.values.join(', ');

    if (allCompleted) {
      return realStatus;
    } else if (allPending) {
      return realStatus;
    } else {
      return realStatus;
    }
  }

  int _calculateAge(String birthDate) {
    DateTime today = DateTime.now();
    DateTime dob = DateTime.parse(birthDate);
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }
}
