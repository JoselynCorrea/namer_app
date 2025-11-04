import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼 Imagen de fondo
          SizedBox.expand(
            child: Image.asset(
  'assets/background.jpg',
  fit: BoxFit.cover,
),
          ),

          // 🧩 Contenido centrado (texto e icono)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // Ícono decorativo
                Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent,
                  size: 60,
                ),
                SizedBox(height: 16),

                // Texto principal
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Nombre de la app
                Text(
                  'Namer App',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
