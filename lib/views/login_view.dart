import 'package:flutter/material.dart';
import '../controllers/rut_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _rutController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _rutErrorText;

  @override
  void initState() {
    super.initState();
    _rutController
        .addListener(_validateRut); // Agregar listener para validar el RUT
  }

  @override
  void dispose() {
    _rutController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateRut() {
    final rut = _rutController.text.replaceAll(RegExp(r'[.-]'), '');
    setState(() {
      _rutErrorText = RutValidator.validarRut(rut) ? null : 'RUT inválido';
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  width: 250,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Tu Imagen Rx - Login',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _rutController,
              onChanged: (_) =>
                  _validateRut(), // Llama a la función de validación al cambiar el texto
              decoration: InputDecoration(
                labelText: 'RUT',
                errorText: _rutErrorText,
                labelStyle: TextStyle(color: primaryColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: primaryColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    _rutController.clear();
                    _passwordController.clear();
                    setState(() {
                      _rutErrorText = null;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: _rutErrorText == null
                      ? () {
                          if (_rutErrorText == null) {
                            Navigator.pushNamed(context, '/');
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    elevation: 8.0,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                  child: const Text('Iniciar Sesión'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
