import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Películas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MovieCatalog(),
    );
  }
}

class MovieCatalog extends StatelessWidget {
  const MovieCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Catálogo de Películas'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenido al catálogo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            movieCard(
              title: 'Inception',
              year: '2010',
              synopsis:
                  'Un ladrón que roba secretos corporativos a través del uso de la tecnología de compartir sueños es encargado de implantar una idea en la mente de un CEO.',
              color: Colors.indigo[100]!,
            ),
            const SizedBox(height: 12),

            movieCard(
              title: 'Interstellar',
              year: '2014',
              synopsis:
                  'Un grupo de exploradores viaja a través de un agujero de gusano en el espacio con la misión de asegurar el futuro de la humanidad.',
              color: Colors.teal[100]!,
            ),
            const SizedBox(height: 12),
            
                movieCard(
                  title: 'Avatar',
                  year: '2009',
                  synopsis:
                      'Un exmarine parapléjico es enviado a la luna Pandora, donde debe decidir entre seguir órdenes o proteger a sus nuevos amigos alienígenas.',
                  color: Colors.blue[100]!,
                ),
               const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

 Widget movieCard({
  required String title,
  required String year,
  required String synopsis,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),

    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  year,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              synopsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
          ],
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:  Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Disponible en 4K',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}
}