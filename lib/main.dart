import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/add_edit_meal_screen.dart';
import './screens/order_screen.dart';
import './screens/user_meals_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/meal_detail_screen.dart';
import './screens/meals_overview_screen.dart';
import './providers/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Meals()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Order()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meal Ordering',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          backgroundColor: Colors.grey[200],
          colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.blue.shade800,
              primary: Colors.indigo,
              background: Colors.grey[200]),
          fontFamily: 'Lato',
        ),
        home: const MealsOverviewScreen(),
        routes: {
          MealDetailScreen.routeName: (context) => const MealDetailScreen(),
          CartScrenn.routeName: (context) => const CartScrenn(),
          OrderScreen.routename: (context) => OrderScreen(),
          UserMealsScreen.routeName: (context) => const UserMealsScreen(),
          AddEditMealScreen.routeName: (context) => const AddEditMealScreen(),
        },
      ),
    );
  }
}
