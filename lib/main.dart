import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:operacion_camaleon/features/profile/presentation/profile_screen.dart';

/// Punto de entrada de la aplicación
void main() {
  runApp(const MyApp());
}

/// Enum que representa las diferentes facciones disponibles
/// Cada una cambiará el tema visual de la aplicación
enum FactionType { hacker, enforcer, ghost }

/// Widget principal de la aplicación
/// Es Stateful porque el tema cambia dinámicamente
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// Estado de la aplicación
/// Aquí se maneja la facción seleccionada y el tema dinámico
class _MyAppState extends State<MyApp> {
  /// Facción seleccionada por defecto
  FactionType selectedFaction = FactionType.hacker;

  /// Método para cambiar la facción
  /// Al ejecutarse, reconstruye la UI con el nuevo tema
  void changeFaction(FactionType faction) {
    setState(() {
      selectedFaction = faction;
    });
  }

  /// Retorna el color base (seedColor) según la facción
  /// Este color se usa para generar el tema dinámico con Material 3
  Color getSeedColor() {
    switch (selectedFaction) {
      case FactionType.hacker:
        return Colors.green; // Estilo hacker
      case FactionType.enforcer:
        return Colors.blue; // Estilo autoridad
      case FactionType.ghost:
        return Colors.purple; // Estilo sigilo
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Oculta la etiqueta de debug
      debugShowCheckedModeBanner: false,

      /// Título de la aplicación
      title: 'Operación Camaleón',

      /// Configuración del tema global usando Material 3
      theme: ThemeData(
        useMaterial3: true,

        /// Generación dinámica del esquema de colores
        /// basado en el seedColor seleccionado
        colorScheme: ColorScheme.fromSeed(
          seedColor: getSeedColor(),
        ),

        /// Tipografía personalizada estilo tecnológica
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),

      /// Pantalla principal de la app
      home: _buildHome(),
    );
  }

  /// Construye la interfaz principal con navegación
  Widget _buildHome() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ShadowNet - Operación Camaleón"),
      ),
      body: Column(
        children: [
          /// Sección de selección de facciones
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Selecciona tu facción",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Botón para facción Hacker
                    ElevatedButton(
                      onPressed: () => changeFaction(FactionType.hacker),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedFaction == FactionType.hacker
                            ? Colors.green
                            : Colors.grey,
                      ),
                      child: const Text("Hacker"),
                    ),

                    /// Botón para facción Enforcer
                    ElevatedButton(
                      onPressed: () => changeFaction(FactionType.enforcer),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedFaction == FactionType.enforcer
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      child: const Text("Enforcer"),
                    ),

                    /// Botón para facción Ghost
                    ElevatedButton(
                      onPressed: () => changeFaction(FactionType.ghost),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedFaction == FactionType.ghost
                            ? Colors.purple
                            : Colors.grey,
                      ),
                      child: const Text("Ghost"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          /// Sección de ProfileScreen
          Expanded(
            child: ProfileScreen(),
          ),
        ],
      ),
    );
  }
}
