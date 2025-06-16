
import 'package:flutter/material.dart';
import '../models/pokemon_type.dart';
import '../utils/types_service.dart';
import '../widgets/pokemon_card.dart';
import 'erro_screen.dart';
import 'pokemon_detail_screen.dart';

class TypePokemonsScreen extends StatefulWidget {
  final String typeName;

  const TypePokemonsScreen({
    Key? key,
    required this.typeName,
  }) : super(key: key);

  @override
  State<TypePokemonsScreen> createState() => _TypePokemonsScreenState();
}

class _TypePokemonsScreenState extends State<TypePokemonsScreen> {
  late Future<PokemonType> _typeFuture;

  @override
  void initState() {
    super.initState();
    _typeFuture = TypesService.getTypeDetails(widget.typeName);
  }

  Color _getTypeColor() {
    switch (widget.typeName) {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonType>(
      future: _typeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Tipo ${widget.typeName.toUpperCase()}"),
              backgroundColor: _getTypeColor(),
              foregroundColor: Colors.white,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return ErroScreen(
            mensagem: snapshot.error.toString().replaceFirst('Exception: ', ''),
            onRetry: () {
              setState(() {
                _typeFuture = TypesService.getTypeDetails(widget.typeName);
              });
            },
          );
        } else if (!snapshot.hasData) {
          return ErroScreen(
            mensagem: "Tipo não encontrado.",
          );
        }

        final typeData = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text("Tipo ${widget.typeName.toUpperCase()}"),
            backgroundColor: _getTypeColor(),
            foregroundColor: Colors.white,
          ),
          backgroundColor: const Color(0xFFF3F4F6),
          body: typeData.pokemons.isEmpty
              ? const Center(
                  child: Text(
                    "Nenhum Pokémon encontrado para este tipo.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: typeData.pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = typeData.pokemons[index];
                    return PokemonCard(
                      pokemon: pokemon,
                      index: index,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PokemonDetailScreen(
                              pokemonId: pokemon.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
