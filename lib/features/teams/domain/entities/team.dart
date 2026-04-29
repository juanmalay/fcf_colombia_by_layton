/// Team entity - Representa un equipo de fútbol
class Team {
  final String id;
  final String name;
  final String shortName;
  final String country;
  final String? logoUrl;
  final String? stadium;
  final String? coach;

  Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.country,
    this.logoUrl,
    this.stadium,
    this.coach,
  });

  Team copyWith({
    String? id,
    String? name,
    String? shortName,
    String? country,
    String? logoUrl,
    String? stadium,
    String? coach,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      country: country ?? this.country,
      logoUrl: logoUrl ?? this.logoUrl,
      stadium: stadium ?? this.stadium,
      coach: coach ?? this.coach,
    );
  }

  @override
  String toString() => 'Team(id: $id, name: $name, shortName: $shortName, country: $country)';
}
