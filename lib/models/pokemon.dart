class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final int baseExperience;
  final List<String> abilities;
  final Map<String, int> stats;
  final int id;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.abilities,
    required this.stats,
    required this.id,
  });

  // Construtor para detalhes completos
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final Map<String, int> statsMap = {};
    for (var stat in json['stats']) {
      statsMap[stat['stat']['name']] = stat['base_stat'];
    }

    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] 
          ?? json['sprites']['front_default'] 
          ?? '',
      types: (json['types'] as List)
          .map((e) => e['type']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'] ?? 0,
      abilities: (json['abilities'] as List)
          .map((e) => e['ability']['name'] as String)
          .toList(),
      stats: statsMap,
      id: json['id'],
    );
  }

  // Construtor para dados básicos (name e id extraído da url)
  factory Pokemon.fromBasicJson(Map<String, dynamic> json) {
    final String url = json['url'];
    final id = int.parse(url.split('/')[url.split('/').length - 2]);
    return Pokemon(
      name: json['name'],
      imageUrl: '', // Não disponível na listagem básica
      types: [],
      height: 0,
      weight: 0,
      baseExperience: 0,
      abilities: [],
      stats: {},
      id: id,
    );
  }
}
