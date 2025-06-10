import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('PokeDex Suprema'),
        centerTitle: true,
        backgroundColor: Colors.red.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildCard(context, Icons.catching_pokemon, 'Pokémons', '/pokemons'),
            _buildCard(context, Icons.person, 'Treinadores', '/trainers'),
            _buildCard(context, Icons.bolt, 'Tipos', '/types'),
            _buildCard(context, Icons.sports_martial_arts, 'Ginásios', '/gyms'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => _navigateTo(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 10),
            Text(label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
