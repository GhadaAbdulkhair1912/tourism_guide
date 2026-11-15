import 'package:flutter/material.dart';
import '../models/attraction.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Attraction> _favorites = [];

  List<Attraction> get favorites => _favorites;

  bool isFavorite(Attraction attraction) {
    return _favorites.any(
          (item) =>
      item.title == attraction.title &&
          item.location == attraction.location,
    );
  }

  void toggleFavorite(Attraction attraction) {
    if (isFavorite(attraction)) {
      _favorites.removeWhere(
            (item) =>
        item.title == attraction.title &&
            item.location == attraction.location,
      );
    } else {
      _favorites.add(attraction);
    }

    notifyListeners();
  }
}