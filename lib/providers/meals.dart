// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exception.dart';
import '../configs/configuration.dart';
import 'meal.dart';

class Meals with ChangeNotifier {
  List<Meal> _items = [];
  late bool _showFavoriteOnly = false;

  List<Meal> get items {
    return [..._items];
  }

  Future<void> fetchAndSetMeals() async {
    var url = Uri.https(API_URL, '/meals.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<Meal> mealsList = [];
      responseData.forEach((key, value) {
        mealsList.add(Meal(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isfavorite: value['isfavorite']));
      });
      _items = mealsList;
      print("hhh");
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addMeal(Meal meal) async {
    var url = Uri.https(API_URL, '/meals.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': meal.title,
          'description': meal.description,
          'price': meal.price,
          'imageUrl': meal.imageUrl,
          'isfavorite': meal.isfavorite
        }),
      );
      meal = Meal(
        id: json.decode(response.body)['name'],
        title: meal.title,
        description: meal.description,
        price: meal.price,
        imageUrl: meal.imageUrl,
      );
      _items.add(meal);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void updateMeal(Meal meal) {
    final index = _items.indexWhere((itemm) => itemm.id == meal.id);
    _items[index] = meal;
    notifyListeners();
  }

  List<Meal> getFavoriteMeals() {
    return _items.where((item) => item.isfavorite).toList();
  }

  Meal getMealById(String mealId) {
    return items.firstWhere((item) => item.id == mealId);
  }

  Future<void> deleteMeal(String mealId) async {
    final url = Uri.https(API_URL, '/meals/$mealId');
    final existingMealIndex = _items.indexWhere((item) => item.id == mealId);
    var existingMeal = _items[existingMealIndex];
    _items.removeAt(existingMealIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingMealIndex, existingMeal);
      notifyListeners();
      throw HttpException("could not remove meal");
    }
  }

  void toggleFavoriteOnly(bool flag) {
    _showFavoriteOnly = flag;
    notifyListeners();
  }
}
