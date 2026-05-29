# Operacion Camaleon - ShadowNet

Aplicacion en Flutter con Material 3 y arquitectura basada en features.
El objetivo es crear un perfil dinamico de agente donde la interfaz cambia
segun la faccion seleccionada.

---

# Caracteristicas

- Selector de faccion (Hacker, Enforcer, Ghost).
- Tema dinamico Material 3 por faccion.
- Logo central que cambia segun la faccion.
- Tipografia JetBrains Mono con Google Fonts.
- Accesibilidad con Semantics.

---

# Tema dinamico con SeedColor

El tema global se genera con:

```dart
ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark)
```

El `seedColor` se deriva de la faccion seleccionada y se usa como base para
la paleta completa (AppBar, botones, fondos y texto).

Archivo clave: [lib/main.dart](lib/main.dart)

---

# Accesibilidad con Semantics

Se agregan etiquetas accesibles para lectores de pantalla, incluyendo:

- Botones de faccion con etiqueta descriptiva.
- Boton de "Cerrar sesion" con la etiqueta requerida:
  "Boton: Finalizar mision y borrar rastro".
- Logo central con etiqueta semantica.

Archivo clave: [lib/features/profile/presentation/accessibility_widgets.dart](lib/features/profile/presentation/accessibility_widgets.dart)

---

# Tipografia

- JetBrains Mono mediante Google Fonts.

---

# Estructura del proyecto

```text
lib/
 └── features/
     └── profile/
         ├── domain/
         └── presentation/
```

---

# Instalacion

## 1. Clonar repositorio

```bash
git clone URL_DEL_REPOSITORIO
```

## 2. Instalar dependencias

```bash
flutter pub get
```

## 3. Ejecutar proyecto

```bash
flutter run
```

---

# Integrantes

- Felipe Carrillo
- Angie Carrillo
- Oswal Wscanga
- Daniel Di Marco

---

# Tecnologias

- Flutter
- Dart
- Material 3
- Google Fonts
- Semantics API
