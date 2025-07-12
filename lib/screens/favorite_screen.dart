import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.favoriteMeals});

  static const routeName = '/favorites';
  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoriteMeals[index].title),
        );
      },
    );
  }
}