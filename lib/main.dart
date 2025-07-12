import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Meal> _favoriteMeals = [];

  Settings _settings = Settings(
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
  );

  List<Meal> _availableMeals = DUMMY_MEALS;

  _filterMeals(Settings settings) {
    setState(() {
      _settings = settings;

      _availableMeals = DUMMY_MEALS.where((meal) {
        final isGlutenFree = _settings.isGlutenFree && meal.isGlutenFree;
        final isLactoseFree = _settings.isLactoseFree && meal.isLactoseFree;
        final isVegan = _settings.isVegan && meal.isVegan;
        final isVegetarian = _settings.isVegetarian && meal.isVegetarian;

        return isGlutenFree || isLactoseFree || isVegan || isVegetarian;
      }).toList();
    });
  }

  _showSnackBarMessage(
    BuildContext context,
    String message,
    {Color? backgroundColor}
  ) 
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  }

  _addFavoriteMeal(BuildContext context, Meal meal) {
    setState(() {
      if (!_favoriteMeals.contains(meal)) {
        _favoriteMeals.add(meal);

        _showSnackBarMessage(
          context,
          '${meal.title} adicionado aos favoritos!'
        );
      }
      else {
        _showSnackBarMessage(
          context,
          '${meal.title} já está nos favoritos!',
          backgroundColor: Theme.of(context).colorScheme.error
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber
        ),
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.pink,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.green,
          contentTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        TabsScreen.routeName: (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        CategoriesMealsScreen.routeName: (ctx) => CategoriesMealsScreen(meals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(onFavoriteMeal: _addFavoriteMeal),
        SettingsScreen.routeName: (ctx) => SettingsScreen(
          settings: _settings, 
          onSettingsChanged: _filterMeals
        ),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => CategoriesScreen(),
      ),
    );
  }
}