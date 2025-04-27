import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sticker_pack/sticker_pack_bloc.dart';
import '../widgets/sticker_pack_card.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StickerPackBloc(
        repository: context.read(),
      )..add(LoadPopularStickerPacks()),
      child: Scaffold(
        backgroundColor: const Color(0xFF7B2FF2),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('StiJoy.com', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B2FF2), Color(0xFFE94057)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<StickerPackBloc, StickerPackState>(
            builder: (context, state) {
              if (state is StickerPackLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is StickerPackError) {
                return Center(child: Text(state.message));
              }

              if (state is StickerPackLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildSection(
                        context,
                        'Найпопулярніші Стікерпаки',
                        state.popularPacks,
                      ),
                      _buildSection(
                        context,
                        'Нові стікерпаки',
                        state.newestPacks,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Категорії Стікерпаків',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildCategories(context),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<dynamic> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final pack = items[index];
              return StickerPackCard(
                pack: pack,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/sticker-details',
                    arguments: pack.id,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = ['Funny', 'Animals', 'Emotions'];
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
            onTap: () {
              // Handle category tap
            },
          );
        },
      ),
    );
  }
}
