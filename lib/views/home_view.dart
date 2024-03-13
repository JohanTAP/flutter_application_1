import 'package:flutter/material.dart';
import '../common_layout.dart';
import '../models/orden.dart';
import '../services/orden_service.dart';
import 'orden_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  List<Orden> _ordenes = [];
  bool _showClearIcon = false;
  bool _showError = false;

  void _fetchOrdenes(String query) async {
    if (query.isNotEmpty) {
      try {
        final int id = int.tryParse(query) ?? 0;
        final List<Orden> ordenes = await OrdenService.fetchOrdenes(id);
        print('Ordenes recibidas: $ordenes');
        setState(() {
          _ordenes = ordenes;
          _showError = _ordenes.isEmpty;
        });
      } catch (e) {
        print('Error fetching ordenes: $e');
        setState(() {
          _showError = true;
        });
      }
    } else {
      setState(() {
        _ordenes.clear();
        _showError = false; // Limpiar el error al borrar la consulta
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      title: 'Buscar',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0, left: 32.0, right: 32.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _showClearIcon = query.isNotEmpty;
                  _showError = false;
                });
                _fetchOrdenes(query);
              },
              decoration: InputDecoration(
                labelText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                errorText: _showError ? 'No se encontraron resultados' : null,
                suffixIcon: _showClearIcon
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _showClearIcon = false;
                            _ordenes.clear();
                            _showError =
                                false; // Limpia el error al borrar el texto
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _showError
                ? const SizedBox.shrink() // Oculta la lista cuando hay un error
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ListView.builder(
                      itemCount: _ordenes.length,
                      itemBuilder: (context, index) {
                        final orden = _ordenes[index];
                        return ListTile(
                          title: Text(orden.idorden.toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrdenDetailsView(orden: orden),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
