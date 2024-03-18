import 'package:flutter/material.dart';
import 'imageOrderScreen.dart'; // Importa la pantalla de ordenar imágenes

class ShowImagesScreen extends StatefulWidget {
  final String name;

  const ShowImagesScreen({Key? key, required this.name}) : super(key: key);

  @override
  _ShowImagesScreenState createState() => _ShowImagesScreenState();
}

class _ShowImagesScreenState extends State<ShowImagesScreen> {
  List<String> imagenes = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg'
  ];
  List<String> secuencia = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    generarSecuencia();
  }

  void generarSecuencia() {
    setState(() {
      secuencia = imagenes.toList(); // Copia las imágenes para la secuencia
      secuencia.shuffle(); // Mezcla la secuencia
      mostrarSiguienteImagen();
    });
  }

  void mostrarSiguienteImagen() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        currentIndex++;
        if (currentIndex < secuencia.length) {
          mostrarSiguienteImagen();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OrdenarImagenesScreen(
                name: widget.name,
                secuencia: imagenes,
                imagenesFijas: const [],
              ),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Cambiar el color de fondo
      appBar: AppBar(
        title: const Text('Mostrar Imágenes'),
      ),
      body: Center(
        child: currentIndex < secuencia.length
            ? SizedBox(
                width: 400,
                height: 400,
                child: Image.asset(
                  secuencia[currentIndex],
                  fit: BoxFit.cover, // Ajusta la imagen al tamaño especificado
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
