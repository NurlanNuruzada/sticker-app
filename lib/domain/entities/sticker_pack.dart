import 'package:equatable/equatable.dart';

class StickerPack extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> stickers;
  final String category;
  final bool isPopular;
  final DateTime createdAt;

  const StickerPack({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.stickers,
    required this.category,
    required this.isPopular,
    required this.createdAt,
  });

  factory StickerPack.fromJson(Map<dynamic, dynamic> json) {
    return StickerPack(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      stickers: List<String>.from(json['stickers'] as List),
      category: json['category'] as String,
      isPopular: json['isPopular'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        stickers,
        category,
        isPopular,
        createdAt,
      ];
} 