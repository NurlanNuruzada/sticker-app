import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sticker_pack/sticker_pack_bloc.dart';

class StickerPackDetailsScreen extends StatelessWidget {
  final String packId;

  const StickerPackDetailsScreen({
    super.key,
    required this.packId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StickerPackBloc(
        repository: context.read(),
      )..add(LoadStickerPackDetails(packId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sticker Pack Details'),
          centerTitle: true,
        ),
        body: BlocBuilder<StickerPackBloc, StickerPackState>(
          builder: (context, state) {
            if (state is StickerPackLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is StickerPackError) {
              return Center(child: Text(state.message));
            }

            if (state is StickerPackLoaded && state.selectedPack != null) {
              final pack = state.selectedPack!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      pack.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[700],
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pack.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pack.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Stickers (${pack.stickers.length})',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: pack.stickers.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[800],
                                ),
                                child: Center(
                                  child: Image.network(
                                    pack.stickers[index],
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
