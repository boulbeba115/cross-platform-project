import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_edit_meal_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/meals.dart';

class UserMealsScreen extends StatelessWidget {
  static const routeName = '/user-meals';
  const UserMealsScreen({Key? key}) : super(key: key);

  Future<void> refreshMeals(BuildContext context) async {
    Provider.of<Meals>(context, listen: false).fetchAndSetMeals();
  }

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<Meals>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meals'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditMealScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView.builder(
            itemBuilder: (context, index) => UserMealsItem(
              id: mealsProvider.items[index].id as String,
              title: mealsProvider.items[index].title,
              imgUrl: mealsProvider.items[index].imageUrl,
            ),
            itemCount: mealsProvider.items.length,
          ),
        ),
        onRefresh: () => refreshMeals(context),
      ),
    );
  }
}
