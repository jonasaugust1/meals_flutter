import 'package:flutter/material.dart';
import 'package:meals/components/app_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });

  static const routeName = '/settings';
  final Settings settings;
  final Function(Settings) onSettingsChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Settings _settings;

  @override
  initState() {
    super.initState();
    _settings = widget.settings;
  }
  
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
          isGlutenFree: _settings.isGlutenFree,
          isLactoseFree: _settings.isLactoseFree,
          isVegan: _settings.isVegan,
          isVegetarian: _settings.isVegetarian,
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
            _settings.isGlutenFree,
            (value) {
              setState(() {
                _settings.isGlutenFree = value;
              });
            },
          ),
          _createSwitchListTile(
            context,
            'Sem Lactose',
            'Só exibe refeições sem lactose',
            _settings.isLactoseFree,
            (value) {
              setState(() {
                _settings.isLactoseFree = value;
              });
            },
          ),
          _createSwitchListTile(
            context,
            'Vegana',
            'Só exibe refeições veganas',
            _settings.isVegan,
            (value) {
              setState(() {
                _settings.isVegan = value;
              });
            },
          ),
          _createSwitchListTile(
            context,
            'Vegetariana',
            'Só exibe refeições vegetarianas',
            _settings.isVegetarian,
            (value) {
              setState(() {
                _settings.isVegetarian = value;
              });
            },
          ),
        ],
      ),
    );
  }
}