
import 'package:flutter/material.dart';
import '../models/pokemon_type.dart';
import '../utils/types_service.dart';
import '../widgets/type_card.dart';
import 'erro_screen.dart';
import 'type_pokemons_screen.dart';

class TypesScreen extends StatefulWidget {
  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  List<PokemonType> _types = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  Future<void> _loadTypes() async {
    try {
      final types = await TypesService.getAllTypes();
      setState(() {
        _types = types;
        _isLoading = false;
      });
    } catch (e) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ErroScreen(
            mensagem: e.toString(),
            onRetry: () {
              Navigator.of(context).pop();
              _loadTypes();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tipos de Pokémon"),
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF3F4F6),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _types.length,
                itemBuilder: (context, index) {
                  return TypeCard(
                    type: _types[index],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TypePokemonsScreen(
                            typeName: _types[index].name,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
