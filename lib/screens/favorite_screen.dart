import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Minhas Receitas Favoritas',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}