enum KitType {
  home,
  away,
  third,
  goalkeeper;

  static KitType fromString(String value) {
    return KitType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => KitType.home,
    );
  }

  String toDisplayString() {
    return switch (this) {
      KitType.home => 'Local',
      KitType.away => 'Visitante',
      KitType.third => 'Alterna',
      KitType.goalkeeper => 'Arquero',
    };
  }
}

class Kit {
  final String id;
  final String teamId;
  final String season;
  final KitType type;
  final String imageUrl;
  final String brand;
  final String sponsor;
  final String description;
  final String tournament;

  const Kit({
    required this.id,
    required this.teamId,
    required this.season,
    required this.type,
    required this.imageUrl,
    required this.brand,
    required this.sponsor,
    required this.description,
    required this.tournament,
  });

  String get typeLabel => type.toDisplayString();

  String get title => '$season · $typeLabel';
}
