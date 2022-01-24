import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/no_items.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Order;

class OrderScreen extends StatelessWidget {
  static const routename = 'orders';
  OrderScreen({Key? key}) : super(key: key);
  bool isInit = false;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final ordersContainer = Provider.of<Order>(context, listen: false);

    if (!isInit) {
      Provider.of<Order>(context)
          .fetchAndSetProducts()
          .then((value) => isLoading = false)
          .catchError((error) {});
      isInit = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: ordersContainer.orders.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  OrderItem(order: ordersContainer.orders[index]),
              itemCount: ordersContainer.orders.length)
          : const NoIteams(
              title: 'No Order Found',
              icon: Icons.shopping_basket,
            ),
    );
  }
}
