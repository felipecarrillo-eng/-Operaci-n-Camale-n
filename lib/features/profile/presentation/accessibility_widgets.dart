import 'package:flutter/material.dart';

//BOTÓN ACCESIBLE PARA FACCIÓN
//Este widget reutilizable agrega accesibilidad usando
//Semantics para lectores de pantalla.

class AccessibleFactionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AccessibleFactionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Seleccionar facción $label",
      button: true,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}


//BOTÓN ACCESIBLE DE CERRAR SESIÓN
//Implementa la descripción solicitada en la actividad:
//"Botón: Finalizar misión y borrar rastro"

class LogoutMissionButton extends StatelessWidget {
  const LogoutMissionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Botón: Finalizar misión y borrar rastro",
      button: true,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("Cerrar sesión"),
      ),
    );
  }
}


//IMAGEN ACCESIBLE PARA FACCIÓN
//Permite que lectores de pantalla identifiquen
//correctamente el logo mostrado.

class AccessibleFactionImage extends StatelessWidget {
  final String imagePath;
  final String factionName;

  const AccessibleFactionImage({
    super.key,
    required this.imagePath,
    required this.factionName,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Logo de la facción $factionName",
      image: true,
      child: Image.asset(
        imagePath,
        height: 150,
      ),
    );
  }
}