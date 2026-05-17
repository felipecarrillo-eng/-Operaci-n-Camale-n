import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

enum FactionType { hacker, enforcer, ghost }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FactionType selectedFaction = FactionType.hacker;

  void changeFaction(FactionType faction) {
    setState(() {
      selectedFaction = faction;
    });
  }

  Color getSeedColor() {
    switch (selectedFaction) {
      case FactionType.hacker:
        return Colors.green;
      case FactionType.enforcer:
        return Colors.blue;
      case FactionType.ghost:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: getSeedColor(),
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ShadowNet"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Selecciona tu facción"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => changeFaction(FactionType.hacker),
              child: const Text("Hacker"),
            ),
            ElevatedButton(
              onPressed: () => changeFaction(FactionType.enforcer),
              child: const Text("Enforcer"),
            ),
            ElevatedButton(
              onPressed: () => changeFaction(FactionType.ghost),
              child: const Text("Ghost"),
            ),
          ],
        ),
      ),
    );
  }
}