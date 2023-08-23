class PokemonStats {
  final String name;
  final num weight;
  final List<Common> abilities;
  final String url;
  final List<Stats> stats;

  const PokemonStats({
    required this.name,
    required this.weight,
    required this.abilities,
    required this.url,
    required this.stats,
  });

  factory PokemonStats.fromJson(Map<String, dynamic> json) {
    print(json['sprites']);
    return PokemonStats(
      name: json['name'] as String,
      weight: json['weight'] as int,
      abilities: (json['abilities'] as List).map((e) => Common.fromJson(Map.from(e))).toList(),
      stats: (json['stats'] as List).map((e) => Stats.fromJson(Map.from(e))).toList(),
      url: json['sprites']['back_default']
    );
  }

  @override
  String toString() {
    return 'name: $name/nWeight: $weight';
  }
}

class Common {
  final String name;
  final String url;

  const Common({required this.name, required this.url});

  factory Common.fromJson(Map<String, Object> json) {
    final abiity = json['ability'] as Map;
    return Common(name: abiity['name'] as String, url: abiity['url'] as String);
  }
}

class Stats {
  final int baseStat;
  final int effort;

  const Stats({required this.baseStat, required this.effort});

  factory Stats.fromJson(Map<String, Object> json) {
    return Stats(baseStat: json['base_stat'] as int, effort: json['effort'] as int);
  }
}
