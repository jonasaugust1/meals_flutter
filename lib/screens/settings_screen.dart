import 'package:flutter/material.dart';
import 'package:meals/components/app_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key,required this.onSettingsChanged});

  static const routeName = '/settings';

  final Function(Settings) onSettingsChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Map<String, bool> settings = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false,
  };

  Widget _createSwitchListTile(
      BuildContext context, 
      String title, 
      String subtitle, 
      bool value, 
      Function(bool) onChanged
  )
  {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(Settings(
          isGlutenFree: settings['glutenFree'] ?? false,
          isLactoseFree: settings['lactoseFree'] ?? false,
          isVegan: settings['vegan'] ?? false,
          isVegetarian: settings['vegetarian'] ?? false,
        ));
      },
      activeColor: Colors.green,
      inactiveTrackColor: Theme.of(context).colorScheme.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          _createSwitchListTile(
            context,
            'Sem Glúten',
            'Só exibe refeições sem glúten',
            settings['glutenFree'] ?? false,
            (value) {
              setState(() {
                settings['glutenFree'] = value;
              });
            },
          ),
          _createSwitchListTile(
            context,
            'Sem Lactose',
            'Só exibe refeições sem lactose',
            settings['lactoseFree'] ?? false,
            (value) {
              setState(() {
                settings['lactoseFree'] = value;
              });
            },
          ),
          _createSwitchListTile(
            context,
            'Vegana',
            'Só exibe refeições veganas',
            settings['vegan'] ?? false,
            (value) {
              setState(() {
                settings['vegan'] = value;
              });
            },
          ),
          _createSwitchListTile(
            context,
            'Vegetariana',
            'Só exibe refeições vegetarianas',
            settings['vegetarian'] ?? false,
            (value) {
              setState(() {
                settings['vegetarian'] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}