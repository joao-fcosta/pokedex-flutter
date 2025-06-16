import 'package:flutter/material.dart';
import '../models/pokemon_type.dart';

class TypeCard extends StatefulWidget {
  final PokemonType type;
  final VoidCallback? onTap;

  const TypeCard({
    super.key,
    required this.type,
    this.onTap,
  });

  @override
  State<TypeCard> createState() => _TypeCardState();
}

class _TypeCardState extends State<TypeCard> {
  bool _pressed = false;

  Color _getTypeColor() {
    switch (widget.type.name) {
      case 'grass':
        return Colors.green;
      case 'poison':
        return Colors.purple;
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.amber;
      case 'psychic':
        return Colors.pinkAccent;
      case 'ice':
        return Colors.cyan;
      case 'ground':
        return Colors.brown;
      case 'bug':
        return Colors.lightGreen;
      case 'fighting':
        return Colors.red;
      case 'normal':
        return Colors.grey;
      case 'flying':
        return Colors.indigo;
      case 'rock':
        return Colors.brown;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.deepPurple;
      case 'dark':
        return Colors.grey.shade800;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon() {
    switch (widget.type.name) {
      case 'fire':
        return Icons.local_fire_department;
      case 'water':
        return Icons.water_drop;
      case 'grass':
        return Icons.eco;
      case 'electric':
        return Icons.flash_on;
      case 'psychic':
        return Icons.psychology;
      case 'ice':
        return Icons.ac_unit;
      case 'ground':
        return Icons.terrain;
      case 'bug':
        return Icons.bug_report;
      case 'fighting':
        return Icons.sports_mma;
      case 'poison':
        return Icons.science;
      case 'flying':
        return Icons.flight;
      case 'rock':
        return Icons.landscape;
      case 'ghost':
        return Icons.visibility_off;
      case 'dragon':
        return Icons.auto_awesome;
      case 'dark':
        return Icons.dark_mode;
      case 'steel':
        return Icons.hardware;
      case 'fairy':
        return Icons.auto_awesome;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor();
    
    return AnimatedScale(
      scale: _pressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 120),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                typeColor,
                typeColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _pressed ? typeColor.withOpacity(0.3) : Colors.black26,
                blurRadius: _pressed ? 8 : 12,
                offset: Offset(0, _pressed ? 4 : 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getTypeIcon(),
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.type.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
