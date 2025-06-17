
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_type.dart';

class TypesService {
  static Future<List<PokemonType>> getAllTypes() async {
    final url = 'https://pokeapi.co/api/v2/type';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      if (results.isEmpty) {
        throw Exception('Nenhum tipo encontrado.');
      }
      return results.map<PokemonType>((type) => PokemonType.fromJson(type)).toList();
    } else {
      throw Exception('Erro ${response.statusCode}: Não foi possível carregar os tipos.');
    }
  }

  static Future<PokemonType> getTypeDetails(String typeName) async {
    final url = 'https://pokeapi.co/api/v2/type/$typeName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isEmpty) {
        throw Exception('Certeza que ele existe? Não consegui encontrar o tipo $typeName :(');
      }
      return PokemonType.fromDetailJson(data);
    } else {
      throw Exception('Erro ${response.statusCode}: Não foi possível carregar detalhes do tipo $typeName.');
    }
  }
}
