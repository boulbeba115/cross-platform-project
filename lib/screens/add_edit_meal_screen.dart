import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal.dart';
import '../providers/meals.dart';

class AddEditMealScreen extends StatefulWidget {
  static const routeName = '/add-edit-meal';
  const AddEditMealScreen({Key? key}) : super(key: key);

  @override
  _AddEditMealScreenState createState() => _AddEditMealScreenState();
}

class _AddEditMealScreenState extends State<AddEditMealScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _initValue = {
    'title': '',
    'description': '',
    'price': 0,
  };
  Meal _meal = Meal(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  void _saveForm() {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    if (_meal.id != null) {
      Provider.of<Meals>(context, listen: false).updateMeal(_meal);
    } else {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Meals>(context, listen: false).addMeal(_meal).then((_) {
        setState(() {
          _isLoading = true;
        });
        Navigator.of(context).pop();
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'An error occured !',
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  'Error when attempting to add Meal',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.orange),
                        )),
                  )
                ],
              );
            });
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final String? mealId =
            ModalRoute.of(context)!.settings.arguments as String;
        if (mealId != null) {
          _meal =
              Provider.of<Meals>(context, listen: false).getMealById(mealId);
          _initValue = {
            'title': _meal.title,
            'description': _meal.description,
            'price': _meal.price.toString(),
          };
          _imageUrlController.text = _meal.imageUrl;
        }
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meal'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValue['title'] as String,
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide a value.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _meal = Meal(
                            id: _meal.id,
                            title: value!,
                            description: _meal.description,
                            price: _meal.price,
                            imageUrl: _meal.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['price'].toString(),
                      decoration: const InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a price.";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number.";
                        }
                        if (double.parse(value) <= 0) {
                          return "Please enter a number greater then 0.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _meal = Meal(
                            id: _meal.id,
                            title: _meal.title,
                            description: _meal.description,
                            price: double.parse(value!),
                            imageUrl: _meal.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['description'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a description.";
                        }
                        if (value.length < 10) {
                          return "description should be at least 10 charecters long.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _meal = Meal(
                            id: _meal.id,
                            title: _meal.title,
                            description: value!,
                            price: _meal.price,
                            imageUrl: _meal.imageUrl);
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Center(child: Text('Enter URL'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image Url'),
                            maxLines: 3,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter ImageUrl.";
                              }
                              if (!value.startsWith('http://') &&
                                  !value.startsWith('https://')) {
                                return "Please provide a valid url";
                              }
                              if (!value.endsWith('png') &&
                                  !value.endsWith('jpg') &&
                                  !value.endsWith('webp') &&
                                  !value.endsWith('gif')) {
                                return "Please provide a valid url";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _meal = Meal(
                                  id: _meal.id,
                                  title: _meal.title,
                                  description: _meal.description,
                                  price: _meal.price,
                                  imageUrl: value!);
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
