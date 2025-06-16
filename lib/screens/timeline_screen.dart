import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../utils/pokemon_service.dart';
import 'erro_screen.dart';
import 'pokemon_detail_screen.dart'; // Importe sua tela de detalhes

class TimelineScreen extends StatefulWidget {
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _isLoading = false;
  int _offset = 0;
  final int _limit = 20;
  final ScrollController _scrollController = ScrollController();
  bool _hasMore = true;
  String _searchText = "";

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
          await PokemonService.getAllPokemons(offset: _offset, limit: _limit);

      setState(() {
        _pokemons.addAll(newPokemons);
        _offset += _limit;
        _hasMore = newPokemons.isNotEmpty;
        _filterPokemons();
      });
    } catch (e) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ErroScreen(
            mensagem: e.toString(),
            onRetry: () {
              Navigator.of(context).pop();
              _loadMorePokemons();
            },
          ),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterPokemons() {
    setState(() {
      if (_searchText.isEmpty) {
        _filteredPokemons = List.from(_pokemons);
      } else {
        _filteredPokemons = _pokemons
            .where((p) => p.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokémons")),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pesquisar Pokémon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  _searchText = value;
                  _filterPokemons();
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _filteredPokemons.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _filteredPokemons.length) {
                    return ListTile(
                      leading: Text(
                        "#${_filteredPokemons[index].id}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(_filteredPokemons[index].name),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PokemonDetailScreen(
                              pokemonId: _filteredPokemons[index].id,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
    );
  }
}
