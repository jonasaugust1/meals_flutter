import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/categories_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final Category category;

  /* Rota Push 
    void _selectCategory(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CategoriesMealsScreen(category: category),
      ));
    } 
  */

  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoriesMealsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha:0.7),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}