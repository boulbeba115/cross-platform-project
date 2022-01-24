import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meals.dart';
import '../screens/add_edit_meal_screen.dart';

class UserMealsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  const UserMealsItem({
    required this.id,
    required this.title,
    required this.imgUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<Meals>(context, listen: false);
    final scaffold = ScaffoldMessenger.of(context);
    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AddEditMealScreen.routeName,
                      arguments: id,
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.orangeAccent,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text(
                              'Are you sure',
                              textAlign: TextAlign.center,
                            ),
                            content: const Text(
                              'Do you want to remove this meal',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop(true);
                                  try {
                                    await mealsProvider.deleteMeal(id);
                                  } catch (exception) {
                                    scaffold.showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: const Icon(
                                                Icons.error,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              exception.toString(),
                                            ),
                                          ],
                                        ),
                                        backgroundColor:
                                            Colors.redAccent.shade700,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text(
                                  'No',
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).errorColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
