import '../../domain/entities/kit.dart';

class KitModel {
  final String id;
  final String teamId;
  final String season;
  final String type;
  final String imageUrl;
  final String brand;
  final String sponsor;
  final String description;
  final String tournament;

  const KitModel({
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

  factory KitModel.fromJson(Map<String, dynamic> json) {
    return KitModel(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      season: json['season'] as String,
      type: json['type'] as String,
      imageUrl: (json['imageUrl'] as String?) ?? '',
      brand: (json['brand'] as String?) ?? '',
      sponsor: (json['sponsor'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      tournament: (json['tournament'] as String?) ?? '',
    );
  }

  Kit toEntity() {
    return Kit(
      id: id,
      teamId: teamId,
      season: season,
      type: KitType.fromString(type),
      imageUrl: imageUrl,
      brand: brand,
      sponsor: sponsor,
      description: description,
      tournament: tournament,
    );
  }
}
