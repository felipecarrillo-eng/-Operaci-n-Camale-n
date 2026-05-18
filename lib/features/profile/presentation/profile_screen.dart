import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _counter = 0;
  String selectedFaction = 'hacker';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _changeFaction(String faction) {
    setState(() {
      selectedFaction = faction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0f3460),
        elevation: 0,
        title: const Text(
          'Operación Camaleón',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Color(0xFF00ff88),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1a1a2e),
              const Color(0xFF16213e),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🎨 IMAGEN DINÁMICA
                  _buildImageSection(),
                  const SizedBox(height: 40),

                  // 📝 TEXTO PRINCIPAL
                  _buildMainText(),
                  const SizedBox(height: 24),

                  // 🔢 CONTADOR CON ESTILO NEON
                  _buildCounterDisplay(),
                  const SizedBox(height: 40),

                  // 🎯 BOTONES DE FACCIÓN
                  _buildFactionButtons(),
                  const SizedBox(height: 40),

                  // 🔘 BOTÓN INCREMENT
                  _buildIncrementButton(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0f3460),
        foregroundColor: const Color(0xFF00ff88),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS
  // ============================================================================

  Widget _buildImageSection() {
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF00ff88),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00ff88).withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: const Color(0xFF0f3460),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getFactionIcon(selectedFaction),
                  size: 100,
                  color: const Color(0xFF00ff88),
                ),
                const SizedBox(height: 12),
                Text(
                  selectedFaction.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF00ff88),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainText() {
    return Text(
      'Has presionado el botón',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white.withOpacity(0.7),
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildCounterDisplay() {
    return Text(
      '$_counter',
      style: const TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
        color: Color(0xFF00ff88),
        letterSpacing: 3,
        shadows: [
          Shadow(
            color: Color(0xFF00ff88),
            blurRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildFactionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFactionButton('hacker', Icons.code),
        const SizedBox(width: 16),
        _buildFactionButton('ghost', Icons.ghost_mode),
        const SizedBox(width: 16),
        _buildFactionButton('enforcer', Icons.shield),
      ],
    );
  }

  Widget _buildFactionButton(String faction, IconData icon) {
    final isSelected = selectedFaction == faction;
    return GestureDetector(
      onTap: () => _changeFaction(faction),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF00ff88) : Colors.white30,
            width: isSelected ? 3 : 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFF0f3460) : Colors.transparent,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00ff88).withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF00ff88) : Colors.white60,
          size: 36,
        ),
      ),
    );
  }

  Widget _buildIncrementButton() {
    return ElevatedButton(
      onPressed: _incrementCounter,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0f3460),
        foregroundColor: const Color(0xFF00ff88),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFF00ff88),
            width: 2,
          ),
        ),
        elevation: 0,
      ),
      child: const Text(
        'INCREMENTAR',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

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
