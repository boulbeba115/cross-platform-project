import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meals.dart';
import 'meal_item.dart';

class MealGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const MealGrid({
    required this.showFavoriteOnly,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<Meals>(context);
    final loadedMeals = !showFavoriteOnly
        ? mealProvider.items
        : mealProvider.getFavoriteMeals();
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedMeals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: loadedMeals[index],
          child: const MealItem(),
        );
      },
    );
  }
}
