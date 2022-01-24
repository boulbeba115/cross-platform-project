import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meals.dart';
import '../widgets/show_error.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/Badge.dart';
import '../widgets/meal_grid.dart';

enum FilterOptions { favorites, all }

class MealsOverviewScreen extends StatefulWidget {
  static const routeName = '/overview';
  const MealsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<MealsOverviewScreen> createState() => _MealsOverviewScreenState();
}

class _MealsOverviewScreenState extends State<MealsOverviewScreen> {
  var _showFavoriteOnly = false;
  var _isInit = false;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _isLoading = true;
      Provider.of<Meals>(context)
          .fetchAndSetMeals()
          .then((value) => _isLoading = false)
          .catchError((error) {
        showDialog(
            context: context,
            builder: (context) {
              return const ShowError(
                title: 'An error occured !',
                content: 'Error when attempting to load meals',
              );
            });
        _isLoading = false;
      });
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
              const PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOptions.favorites,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, child) => Badge(
              child: child!,
              value: cartData.itemCount.toString(),
              color: Colors.red.shade700,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScrenn.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MealGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
