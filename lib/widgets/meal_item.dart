import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/meal_detail_screen.dart';
import '../providers/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Meal meal = Provider.of<Meal>(context, listen: false);
    final cartContainer = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 10,
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MealDetailScreen.routeName, arguments: meal.id);
            },
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.indigo,
            leading: Consumer<Meal>(
              builder: (context, currentMeal, _) => IconButton(
                icon: currentMeal.isfavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                onPressed: () {
                  currentMeal.toggleFavoriteSatus();
                },
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: Text(
                  meal.title,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                cartContainer.addItem(meal, 1);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Added Item to cart'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.orange,
                      onPressed: () {
                        cartContainer.removeSingleItem(meal.id as String);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
