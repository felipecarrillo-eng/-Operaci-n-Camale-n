import 'package:flutter/material.dart';

/// Pantalla principal de Operación Camaleón con interfaz futurista
/// 
/// Características:
/// - Diseño cyberpunk estilo ShadowNet
/// - Selector dinámico de facciones
/// - Contador interactivo con efectos neon
/// - Animaciones suaves y responsivas
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================================
  // CONSTANTS - COLORES NEON
  // ============================================================================

  static const Color _colorNeonGreen = Color(0xFF00ff88);
  static const Color _colorNeonPurple = Color(0xFF9d00ff);
  static const Color _colorNeonBlue = Color(0xFF00d4ff);
  static const Color _colorDarkBg1 = Color(0xFF1a1a2e);
  static const Color _colorDarkBg2 = Color(0xFF16213e);
  static const Color _colorDarkBg3 = Color(0xFF0f3460);

  // ============================================================================
  // STATE
  // ============================================================================

  int _counter = 0;
  String selectedFaction = 'hacker';
  late AnimationController _animationController;

  // ============================================================================
  // LIFECYCLE
  // ============================================================================

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================================
  // ACTIONS
  // ============================================================================

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _animationController.forward().then((_) {
      _animationController.reset();
    });
  }

  void _changeFaction(String faction) {
    setState(() {
      selectedFaction = faction;
    });
  }

  // ============================================================================
  // BUILD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(isMobile),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // ============================================================================
  // UI BUILDERS - MAIN STRUCTURE
  // ============================================================================

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _colorDarkBg3,
      elevation: 0,
      title: const Text(
        'OPERACIÓN CAMALEÓN',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          color: _colorNeonGreen,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _colorNeonGreen.withOpacity(0.5),
                _colorNeonPurple.withOpacity(0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(bool isMobile) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_colorDarkBg1, _colorDarkBg2],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImageSection(),
                const SizedBox(height: 48),
                _buildMainText(),
                const SizedBox(height: 32),
                _buildCounterDisplay(),
                const SizedBox(height: 48),
                _buildFactionButtons(),
                const SizedBox(height: 48),
                _buildIncrementButton(),
                const SizedBox(height: 32),
                _buildInfoBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - COMPONENTS
  // ============================================================================

  /// Caja de imagen con efecto neon dinámico
  Widget _buildImageSection() {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
      ),
      child: Container(
        height: 240,
        width: 240,
        decoration: BoxDecoration(
          border: Border.all(
            color: _colorNeonGreen,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _colorNeonGreen.withOpacity(0.5),
              blurRadius: 30,
              spreadRadius: 8,
            ),
            BoxShadow(
              color: _colorNeonPurple.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Fondo degradado
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_colorDarkBg3, _colorDarkBg2],
                  ),
                ),
              ),

              // Contenido
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getFactionIcon(selectedFaction),
                    size: 120,
                    color: _colorNeonGreen,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selectedFaction.toUpperCase(),
                    style: const TextStyle(
                      color: _colorNeonGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Texto descriptivo principal
  Widget _buildMainText() {
    return Column(
      children: [
        Text(
          'CONTADOR INTERACTIVO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: _colorNeonBlue.withOpacity(0.8),
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Presiona para incrementar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  /// Contador con efecto glow y animación
  Widget _buildCounterDisplay() {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: _colorNeonGreen,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _colorNeonGreen.withOpacity(0.4),
              blurRadius: 15,
            ),
          ],
        ),
        child: Text(
          '$_counter',
          style: const TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.bold,
            color: _colorNeonGreen,
            letterSpacing: 4,
            shadows: [
              Shadow(
                color: _colorNeonGreen,
                blurRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Botones de selección de facción
  Widget _buildFactionButtons() {
    return Column(
      children: [
        Text(
          'SELECCIONA FACCIÓN',
          style: TextStyle(
            fontSize: 12,
            color: _colorNeonPurple.withOpacity(0.8),
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFactionButton('hacker', Icons.code),
            const SizedBox(width: 20),
            _buildFactionButton('ghost', Icons.ghost_mode),
            const SizedBox(width: 20),
            _buildFactionButton('enforcer', Icons.shield),
          ],
        ),
      ],
    );
  }

  /// Botón individual de facción con efecto hover
  Widget _buildFactionButton(String faction, IconData icon) {
    final isSelected = selectedFaction == faction;
    final borderColor = isSelected ? _colorNeonGreen : _colorNeonBlue;
    final glowColor = isSelected ? _colorNeonGreen : _colorNeonBlue;

    return GestureDetector(
      onTap: () => _changeFaction(faction),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: isSelected ? 3 : 2,
            ),
            borderRadius: BorderRadius.circular(14),
            color: isSelected ? _colorDarkBg3 : Colors.transparent,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: glowColor.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? _colorNeonGreen : Colors.white54,
            size: 40,
          ),
        ),
      ),
    );
  }

  /// Botón principal de incremento
  Widget _buildIncrementButton() {
    return ElevatedButton(
      onPressed: _incrementCounter,
      style: ElevatedButton.styleFrom(
        backgroundColor: _colorDarkBg3,
        foregroundColor: _colorNeonGreen,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: _colorNeonGreen,
            width: 2,
          ),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: const Text(
        '⚡ INCREMENTAR ⚡',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  /// Caja informativa con estadísticas
  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: _colorNeonBlue.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: _colorDarkBg3.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Text(
            'ESTADO ACTUAL',
            style: TextStyle(
              fontSize: 12,
              color: _colorNeonBlue.withOpacity(0.8),
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem('FACCIÓN', selectedFaction.toUpperCase()),
              _buildInfoItem('PUNTOS', _counter.toString()),
            ],
          ),
        ],
      ),
    );
  }

  /// Elemento de información
  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: _colorNeonGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Botón de acción flotante
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      backgroundColor: _colorDarkBg3,
      foregroundColor: _colorNeonGreen,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: _colorNeonGreen,
          width: 2,
        ),
      ),
      child: const Icon(Icons.add, size: 32),
    );
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  /// Obtiene el icono según la facción seleccionada
  IconData _getFactionIcon(String faction) {
    switch (faction) {
      case 'hacker':
        return Icons.code;
      case 'ghost':
        return Icons.ghost_mode;
      case 'enforcer':
        return Icons.shield;
      default:
        return Icons.code;
    }
  }
}
