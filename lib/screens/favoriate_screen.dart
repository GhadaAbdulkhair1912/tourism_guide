import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../widgets/attraction_card.dart';

class FavoriateScreen extends StatelessWidget {
  const FavoriateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, child) {

        final favorites = provider.favorites;

        if (favorites.isEmpty) {
          return const Center(
            child: Text(
              'No favorite attractions yet ❤️',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: favorites.length,

          itemBuilder: (context, index) {
            return AttractionCard(
              attraction: favorites[index],
            );
          },
        );
      },
    );
  }
}