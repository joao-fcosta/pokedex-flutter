import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static Future<List<Pokemon>> getAllPokemons({int offset = 0, int limit = 20}) async {
    final url = 'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      // Supondo que seu model Pokemon tenha um construtor que aceite apenas name e url/id
      return results.map<Pokemon>((pokemon) => Pokemon.fromBasicJson(pokemon)).toList();
    } else {
      throw Exception('Falha ao carregar os pokémons');
    }
  }

  static Future<Pokemon> getPokemonById(int id) async {
    final url = 'https://pokeapi.co/api/v2/pokemon/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Falha ao carregar o pokémon de id $id');
    }
  }
}