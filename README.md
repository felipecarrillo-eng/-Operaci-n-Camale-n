# Operación Camaleón - ShadowNet

Aplicación desarrollada en Flutter utilizando Material 3 y arquitectura basada en features.

El objetivo del proyecto es crear un perfil dinámico de agente donde la interfaz cambia visualmente según la facción seleccionada.

---

# Características

- Cambio dinámico de tema usando Material 3
- Selector de facciones:
  - Hacker
  - Enforcer
  - Ghost
- Tipografía futurista con Google Fonts
- Arquitectura basada en features
- Accesibilidad usando Semantics

---

# Tema Dinámico con SeedColor

La aplicación utiliza:

```dart
ColorScheme.fromSeed(seedColor: color)
```

Esto permite generar automáticamente toda la paleta de colores de la aplicación dependiendo de la facción seleccionada.

Ejemplo:

- Hacker → Verde
- Enforcer → Azul
- Ghost → Morado

---

# Accesibilidad con Semantics

Se implementan etiquetas accesibles para lectores de pantalla.

Ejemplo:

```dart
Semantics(
  label: "Botón: Finalizar misión y borrar rastro",
  button: true,
)
```

Esto mejora la experiencia de usuarios con herramientas de accesibilidad.

---

# Tipografía

Se utiliza:

- JetBrains Mono

Implementada mediante Google Fonts.

---

# Estructura del Proyecto

```text
lib/
 └── features/
     └── profile/
         ├── data/
         ├── domain/
         └── presentation/
```

---

# Instalación

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

#  Integrantes

- Felipe Carrillo
- Angie Carrillo
- Oswal Wscanga
- Daniel Di Marco

---

#  Tecnologías

- Flutter
- Dart
- Material 3
- Google Fonts
- Git & GitHub