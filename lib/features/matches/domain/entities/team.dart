/// Entidad de equipo (modelo de dominio)
class Team {
  final String id;
  final String name;
  final String? logoUrl;

  Team({
    required this.id,
    required this.name,
    this.logoUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          logoUrl == other.logoUrl;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logoUrl.hashCode;

  @override
  String toString() => 'Team(id: $id, name: $name, logoUrl: $logoUrl)';
}
