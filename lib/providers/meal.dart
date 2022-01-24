import 'package:flutter/foundation.dart';

class Meal with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite;

  Meal({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isfavorite = false,
  });

  void toggleFavoriteSatus() {
    isfavorite = !isfavorite;
    notifyListeners();
  }
}
