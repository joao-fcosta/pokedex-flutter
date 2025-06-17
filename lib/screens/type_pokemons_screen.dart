import 'package:flutter/material.dart';
import '../models/pokemon_type.dart';
import '../utils/types_service.dart';
import 'erro_screen.dart';
import 'pokemon_detail_screen.dart';

class TypePokemonsScreen extends StatefulWidget {
  final String typeName;

  const TypePokemonsScreen({
    super.key,
    required this.typeName,
  });

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
        } else if (!snapshot.hasData || snapshot.data!.pokemons.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Tipo ${widget.typeName.toUpperCase()}"),
              backgroundColor: _getTypeColor(),
              foregroundColor: Colors.white,
            ),
            body: const Center(
              child: Text(
                "Nenhum Pokémon encontrado para este tipo.",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }

        final pokemons = snapshot.data!.pokemons;

        return Scaffold(
          appBar: AppBar(
            title: Text("Tipo ${widget.typeName.toUpperCase()}"),
            backgroundColor: _getTypeColor(),
            foregroundColor: Colors.white,
          ),
          body: ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return ListTile(
                leading: Text(
                  "#${pokemon.id}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(pokemon.name),
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
