import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static final Map<String, Pokemon> _cache = {};

  static Future<List<Pokemon>> fetchPokemons({int offset = 0, int limit = 20}) async {
    final url = 'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];

      final pokemons = await Future.wait(results.map((pokemon) async {
        final name = pokemon['name'];
        if (_cache.containsKey(name)) return _cache[name]!;

        final detailResponse = await http.get(Uri.parse(pokemon['url']));
        if (detailResponse.statusCode == 200) {
          final parsed = jsonDecode(detailResponse.body);
          final p = Pokemon.fromJson(parsed);
          _cache[name] = p;
          return p;
        }

        return null;
      }));

      return pokemons.whereType<Pokemon>().toList();
    } else {
      throw Exception('Erro ao carregar pokémons');
    }
  }
}
