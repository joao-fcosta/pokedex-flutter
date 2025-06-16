import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static Future<List<Pokemon>> getAllPokemons({int offset = 0, int limit = 20}) async {
    final url = 'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map<Pokemon>((pokemon) => Pokemon.fromBasicJson(pokemon)).toList();
    } else {
      throw Exception('Erro ${response.statusCode}: Não foi possível carregar a lista de pokémons.');
    }
  }

  static Future<Pokemon> getPokemonById(int id) async {
    final url = 'https://pokeapi.co/api/v2/pokemon/$id';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Pokemon.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('Pokémon com ID $id não encontrado.');
      } else {
        throw Exception('Erro ${response.statusCode}: Não foi possível carregar o pokémon de id $id.');
      }
    } catch (e) {
      throw Exception('Erro ao buscar detalhes do pokémon: ${e.toString()}');
    }
  }
}