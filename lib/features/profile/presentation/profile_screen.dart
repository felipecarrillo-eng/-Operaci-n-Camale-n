import 'package:flutter/material.dart';
import 'package:operacion_camaleon/features/profile/domain/faction_type.dart';
import 'package:operacion_camaleon/features/profile/presentation/accessibility_widgets.dart';

/// Pantalla principal de Operacion Camaleon con interfaz futurista.
class ProfileScreen extends StatefulWidget {
  final FactionType selectedFaction;
  final ValueChanged<FactionType> onFactionChanged;

  const ProfileScreen({
    super.key,
    required this.selectedFaction,
    required this.onFactionChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  double _missionProgress = 0.2;
  bool _stealthEnabled = true;
  final List<String> _activityLog = ['Sistema listo'];
  late AnimationController _animationController;

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

  void _incrementCounter() {
    setState(() {
      _counter++;
      _addLog('Puntos +1 (total $_counter)');
    });
    _animationController.forward().then((_) {
      _animationController.reset();
    });
  }

  void _changeFaction(FactionType faction) {
    setState(() {
      _addLog('Faccion cambiada a ${faction.label}');
    });
    widget.onFactionChanged(faction);
  }

  void _runScan() {
    setState(() {
      _missionProgress = (_missionProgress + 0.2).clamp(0.0, 1.0);
      if (_missionProgress >= 1.0) {
        _addLog('Objetivo asegurado. Extraccion lista');
      } else {
        _addLog('Escaneo de red completado');
      }
    });
    _animationController.forward().then((_) {
      _animationController.reset();
    });
  }

  void _toggleStealth() {
    setState(() {
      _stealthEnabled = !_stealthEnabled;
      _addLog(
        _stealthEnabled ? 'Modo sigilo activado' : 'Modo sigilo desactivado',
      );
    });
  }

  void _finalizeMission() {
    setState(() {
      _counter = 0;
      _missionProgress = 0.0;
      _stealthEnabled = false;
      _activityLog
        ..clear()
        ..add('Mision finalizada. Rastro borrado');
    });
  }

  void _addLog(String message) {
    _activityLog.insert(0, message);
    if (_activityLog.length > 4) {
      _activityLog.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _buildAppBar(scheme),
      body: _buildBody(isMobile, scheme),
      floatingActionButton: _buildFloatingActionButton(scheme),
    );
  }

  PreferredSizeWidget _buildAppBar(ColorScheme scheme) {
    return AppBar(
      backgroundColor: scheme.surface,
      elevation: 0,
      title: Text(
        'OPERACION CAMALEON',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          color: scheme.primary,
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
                scheme.primary.withOpacity(0.6),
                scheme.secondary.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(bool isMobile, ColorScheme scheme) {
    final surface1 = scheme.surface;
    final surface2 = scheme.surfaceContainerHigh;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [surface1, surface2],
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
                _buildImageSection(scheme),
                const SizedBox(height: 48),
                _buildMainText(scheme),
                const SizedBox(height: 32),
                _buildCounterDisplay(scheme),
                const SizedBox(height: 48),
                _buildFactionButtons(scheme),
                const SizedBox(height: 48),
                _buildIncrementButton(scheme),
                const SizedBox(height: 24),
                _buildInfoBox(scheme),
                const SizedBox(height: 24),
                _buildMissionModule(scheme),
                const SizedBox(height: 24),
                _buildActivityLog(scheme),
                const SizedBox(height: 24),
                LogoutMissionButton(
                  onPressed: _finalizeMission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.surfaceContainerHigh,
                    foregroundColor: scheme.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: scheme.error, width: 2),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(ColorScheme scheme) {
    final selectedFaction = widget.selectedFaction;

    return Semantics(
      label: 'Logo de la faccion ${selectedFaction.label}',
      image: true,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        ),
        child: Container(
          height: 240,
          width: 240,
          decoration: BoxDecoration(
            border: Border.all(color: scheme.primary, width: 3),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 8,
              ),
              BoxShadow(
                color: scheme.secondary.withOpacity(0.3),
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
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        scheme.surfaceContainerHighest,
                        scheme.surfaceContainerHigh,
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExcludeSemantics(
                      child: Icon(
                        _getFactionIcon(selectedFaction),
                        size: 120,
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      selectedFaction.label.toUpperCase(),
                      style: TextStyle(
                        color: scheme.primary,
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
      ),
    );
  }

  Widget _buildMainText(ColorScheme scheme) {
    return Column(
      children: [
        Text(
          'CONTADOR INTERACTIVO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: scheme.secondary.withOpacity(0.8),
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
            color: scheme.onSurface.withOpacity(0.7),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildCounterDisplay(ColorScheme scheme) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: scheme.primary, width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: scheme.primary.withOpacity(0.4), blurRadius: 15),
          ],
        ),
        child: Text(
          '$_counter',
          style: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.bold,
            color: scheme.primary,
            letterSpacing: 4,
            shadows: [Shadow(color: scheme.primary, blurRadius: 20)],
          ),
        ),
      ),
    );
  }

  Widget _buildFactionButtons(ColorScheme scheme) {
    return Column(
      children: [
        Text(
          'SELECCIONA FACCION',
          style: TextStyle(
            fontSize: 12,
            color: scheme.secondary.withOpacity(0.8),
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: [
            for (final faction in FactionType.values)
              _buildFactionButton(faction, scheme),
          ],
        ),
      ],
    );
  }

  Widget _buildFactionButton(FactionType faction, ColorScheme scheme) {
    final isSelected = widget.selectedFaction == faction;
    final borderColor = isSelected ? scheme.primary : scheme.secondary;
    final glowColor = isSelected ? scheme.primary : scheme.secondary;

    return Semantics(
      label: 'Seleccionar faccion ${faction.label}',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () => _changeFaction(faction),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: isSelected ? 3 : 2),
              borderRadius: BorderRadius.circular(14),
              color: isSelected
                  ? scheme.surfaceContainerHigh
                  : Colors.transparent,
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
            child: ExcludeSemantics(
              child: Icon(
                _getFactionIcon(faction),
                color: isSelected
                    ? scheme.primary
                    : scheme.onSurface.withOpacity(0.6),
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIncrementButton(ColorScheme scheme) {
    return ElevatedButton(
      onPressed: _incrementCounter,
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.surfaceContainerHigh,
        foregroundColor: scheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: scheme.primary, width: 2),
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

  Widget _buildInfoBox(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.secondary.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: scheme.surfaceContainerHigh.withOpacity(0.4),
      ),
      child: Column(
        children: [
          Text(
            'ESTADO ACTUAL',
            style: TextStyle(
              fontSize: 12,
              color: scheme.secondary.withOpacity(0.8),
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                'FACCION',
                widget.selectedFaction.label.toUpperCase(),
                scheme,
              ),
              _buildInfoItem('PUNTOS', _counter.toString(), scheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissionModule(ColorScheme scheme) {
    final progressPercent = (_missionProgress * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.primary.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: scheme.surfaceContainerHigh.withOpacity(0.35),
      ),
      child: Column(
        children: [
          Text(
            'MODULO DE MISION',
            style: TextStyle(
              fontSize: 12,
              color: scheme.primary.withOpacity(0.9),
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: _missionProgress,
            minHeight: 8,
            color: scheme.primary,
            backgroundColor: scheme.surfaceContainerHighest,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusChip('PROGRESO', '$progressPercent%', scheme),
              _buildStatusChip(
                'SIGILO',
                _stealthEnabled ? 'ACTIVO' : 'INACTIVO',
                scheme,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: _runScan,
                icon: const Icon(Icons.wifi_tethering),
                label: const Text('ESCANEAR RED'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.surfaceContainerHigh,
                  foregroundColor: scheme.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: scheme.primary, width: 1.5),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _toggleStealth,
                icon: Icon(
                  _stealthEnabled ? Icons.visibility_off : Icons.visibility,
                ),
                label: Text(
                  _stealthEnabled ? 'MODO SIGILO: ON' : 'MODO SIGILO: OFF',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: scheme.secondary,
                  side: BorderSide(color: scheme.secondary, width: 1.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLog(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.secondary.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: scheme.surfaceContainerHigh.withOpacity(0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVIDAD RECIENTE',
            style: TextStyle(
              fontSize: 12,
              color: scheme.secondary.withOpacity(0.9),
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (_activityLog.isEmpty)
            Text(
              'Sin eventos registrados',
              style: TextStyle(
                fontSize: 13,
                color: scheme.onSurface.withOpacity(0.6),
              ),
            )
          else
            for (final entry in _activityLog)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '- $entry',
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurface.withOpacity(0.75),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, String value, ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.primary.withOpacity(0.4), width: 1),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 11,
          color: scheme.onSurface.withOpacity(0.75),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, ColorScheme scheme) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: scheme.onSurface.withOpacity(0.5),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: scheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton(ColorScheme scheme) {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      backgroundColor: scheme.surfaceContainerHigh,
      foregroundColor: scheme.primary,
      elevation: 0,
      tooltip: 'Incrementar contador',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.primary, width: 2),
      ),
      child: const Icon(Icons.add, size: 32),
    );
  }

  IconData _getFactionIcon(FactionType faction) {
    switch (faction) {
      case FactionType.hacker:
        return Icons.code;
      case FactionType.ghost:
        return Icons.visibility_off;
      case FactionType.enforcer:
        return Icons.shield;
    }
  }
}
