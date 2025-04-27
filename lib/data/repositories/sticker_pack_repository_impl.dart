import '../../domain/entities/sticker_pack.dart';
import '../../domain/repositories/sticker_pack_repository.dart';

class StickerPackRepositoryImpl implements StickerPackRepository {
  final List<StickerPack> _mockPacks = [
    StickerPack(
      id: '1',
      name: 'Маньяк',
      description: 'Placeholder description. Please provide your preferred description.',
      imageUrl: 'https://i.imgur.com/8Q2Q5Qb.png', // Use the first sticker as the pack image
      stickers: [
        'https://i.imgur.com/8Q2Q5Qb.png', // ripped shirt
        'https://i.imgur.com/1Q2Q5Qb.png', // shy
        'https://i.imgur.com/2Q2Q5Qb.png', // hug
        'https://i.imgur.com/3Q2Q5Qb.png', // please
        'https://i.imgur.com/4Q2Q5Qb.png', // wave
      ],
      category: 'Funny',
      isPopular: true,
      createdAt: DateTime.now(),
    ),
    StickerPack(
      id: '2',
      name: 'Emoji Pack',
      description: 'Classic emoji stickers',
      imageUrl: 'https://example.com/emoji.jpg',
      stickers: [
        'https://example.com/sticker3.png',
        'https://example.com/sticker4.png',
      ],
      category: 'Emotions',
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    StickerPack(
      id: '3',
      name: 'Funny Faces',
      description: 'Funny face expressions',
      imageUrl: 'https://example.com/faces.jpg',
      stickers: [
        'https://example.com/sticker5.png',
        'https://example.com/sticker6.png',
      ],
      category: 'Funny',
      isPopular: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Future<List<StickerPack>> getPopularStickerPacks() async {
    return _mockPacks.where((pack) => pack.isPopular).toList();
  }

  @override
  Future<List<StickerPack>> getNewestStickerPacks() async {
    return _mockPacks..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<StickerPack>> getStickerPacksByCategory(String category) async {
    return _mockPacks.where((pack) => pack.category == category).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    return ['Funny', 'Animals', 'Emotions'];
  }

  @override
  Future<StickerPack> getStickerPackDetails(String id) async {
    final pack = _mockPacks.firstWhere((pack) => pack.id == id);
    return pack;
  }
} 