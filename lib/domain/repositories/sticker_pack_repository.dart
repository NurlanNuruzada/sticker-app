import '../entities/sticker_pack.dart';

abstract class StickerPackRepository {
  Future<List<StickerPack>> getPopularStickerPacks();
  Future<List<StickerPack>> getNewestStickerPacks();
  Future<List<StickerPack>> getStickerPacksByCategory(String category);
  Future<List<String>> getCategories();
  Future<StickerPack> getStickerPackDetails(String id);
}
