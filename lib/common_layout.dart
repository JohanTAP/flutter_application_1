import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? drawer;

  const CommonLayout(
      {super.key, required this.body, required this.title, this.drawer});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      drawer: drawer ??
          Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: const Text(
                    'Menú',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: primaryColor),
                  title: Text('Inicio', style: TextStyle(color: primaryColor)),
                  onTap: () {
                    Navigator.pop(context); // Cerrar el Drawer
                    Navigator.pushNamed(context, '/home'); // Ir a la vista Home
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: primaryColor),
                  title: Text('Cerrar sesión',
                      style: TextStyle(color: primaryColor)),
                  onTap: () {
                    Navigator.pop(context); // Cerrar el Drawer
                    Navigator.pushNamed(
                        context, '/login'); // Ir a la vista Login
                  },
                ),
              ],
            ),
          ),
      body: body,
    );
  }
}
