
import '../models/pokemon.dart';

class PokemonType {
  final String name;
  final String url;
  final List<Pokemon> pokemons;

  PokemonType({
    required this.name,
    required this.url,
    this.pokemons = const [],
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'],
      url: json['url'],
    );
  }

  factory PokemonType.fromDetailJson(Map<String, dynamic> json) {
    final List<Pokemon> pokemonList = [];
    
    if (json['pokemon'] != null) {
      for (var pokemonData in json['pokemon']) {
        final pokemonUrl = pokemonData['pokemon']['url'] as String;
        final id = int.parse(pokemonUrl.split('/')[pokemonUrl.split('/').length - 2]);
        
        pokemonList.add(Pokemon(
          name: pokemonData['pokemon']['name'],
          imageUrl: '',
          types: [],
          height: 0,
          weight: 0,
          baseExperience: 0,
          abilities: [],
          stats: {},
          id: id,
        ));
      }
    }

    return PokemonType(
      name: json['name'],
      url: '',
      pokemons: pokemonList,
    );
  }
}
