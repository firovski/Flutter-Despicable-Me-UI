import 'package:flutter/material.dart';
import 'package:flutter_app_despicable_me_ui/pages/character_listing_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despicable Me Chaeacters',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          canvasColor: Colors.white,
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.white
          )
      ),
      home: CharacterListingScreen(),
    );
  }
}
