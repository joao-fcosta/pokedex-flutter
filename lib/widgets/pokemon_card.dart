import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final int index;

  const PokemonCard({super.key, required this.pokemon, required this.index});

  Color _getTypeColor(String type) {
    switch (type) {
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
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            padding: const EdgeInsets.only(top: 70, left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 8),
                )
              ],
            ),
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                Text(
                  'POKÉMON #${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pokemon.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: pokemon.types.map((type) {
                    final color = _getTypeColor(type);
                    return Chip(
                      label: Text(type),
                      backgroundColor: color.withOpacity(0.2),
                      labelStyle: TextStyle(color: color),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statBox("Altura", "${pokemon.height / 10} m"),
                    _statBox("Peso", "${pokemon.weight / 10} kg"),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Image.network(
              pokemon.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, _) => Icon(Icons.image_not_supported, size: 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
