
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/timeline_screen.dart';
import 'screens/types_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Timeline Pokémon',
    theme: ThemeData(
      primarySwatch: Colors.red,
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: Color(0xFFF3F4F6),
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor: Colors.red.shade600,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    home: HomePage(),
    routes: {
      '/pokemons': (_) => TimelineScreen(),
      '/types': (_) => TypesScreen(),
    },
  ));
}
