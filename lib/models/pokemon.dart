class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final int baseExperience;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.baseExperience,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'] ?? '',
      types: (json['types'] as List)
          .map((e) => e['type']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
    );
  }
}
