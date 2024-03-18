import 'package:flutter/material.dart';
import 'showImageScreen.dart';

class NombreScreen extends StatefulWidget {
  const NombreScreen({Key? key}) : super(key: key);

  @override
  _NombreScreenState createState() => _NombreScreenState();
}

class _NombreScreenState extends State<NombreScreen> {
  final TextEditingController _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Cambiar el color de fondo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Memory Game',
              style: TextStyle(fontSize: 30), // Cambiar el tamaño del texto
            ),
            SizedBox(height: 400), // Aumentar el espacio vertical
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String nombre = _nombreController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowImagesScreen(name: nombre),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Cambiar el color del botón
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
