import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:operacion_camaleon/features/profile/domain/faction_type.dart';
import 'package:operacion_camaleon/features/profile/presentation/profile_screen.dart';

/// Punto de entrada de la aplicación
void main() {
  runApp(const MyApp());
}

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
    final colorScheme = ColorScheme.fromSeed(
      seedColor: getSeedColor(),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      /// Oculta la etiqueta de debug
      debugShowCheckedModeBanner: false,

      /// Configuración del tema global usando Material 3
      theme: ThemeData(
        useMaterial3: true,

        /// Generación dinámica del esquema de colores
        /// basado en el seedColor seleccionado
        colorScheme: colorScheme,

        /// Tipografía personalizada estilo tecnológica
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),

        scaffoldBackgroundColor: colorScheme.surface,
      ),

      /// Pantalla principal: ProfileScreen con UI mejorada
      home: ProfileScreen(
        selectedFaction: selectedFaction,
        onFactionChanged: changeFaction,
      ),
    );
  }
}
