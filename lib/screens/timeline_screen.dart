import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../utils/pokemon_service.dart';
import '../widgets/pokemon_card.dart';

class TimelineScreen extends StatefulWidget {
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Pokemon> _pokemons = [];
  bool _isLoading = false;
  int _offset = 0;
  final int _limit = 10;
  final ScrollController _scrollController = ScrollController();
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMorePokemons();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadMorePokemons();
      }
    });
  }

  Future<void> _loadMorePokemons() async {
    setState(() => _isLoading = true);
    try {
      final newPokemons =
          await PokemonService.fetchPokemons(offset: _offset, limit: _limit);

      setState(() {
        _pokemons.addAll(newPokemons);
        _offset += _limit;
        _hasMore = newPokemons.isNotEmpty;
      });
    } catch (e) {
      print("Erro: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokémon Timeline")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _pokemons.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _pokemons.length) {
            return PokemonCard(pokemon: _pokemons[index], index: index);
          } else {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
