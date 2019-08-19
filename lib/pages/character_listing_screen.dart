import 'package:flutter/material.dart';
import 'package:flutter_app_despicable_me_ui/styleguide.dart';
import 'package:flutter_app_despicable_me_ui/widgets/CharacterWidget.dart';

class CharacterListingScreen extends StatefulWidget {
  @override
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 30,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              size: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 8.0),
              child: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(text: "Despicable Me", style: AppTheme.display1),
                  TextSpan(text: "\n"),
                  TextSpan(text: "Characters", style: AppTheme.display2),
                ],
              )),
            ),
            Expanded(
              child: CharacterWidget(),
            )
          ],
        ),
      ),
    );
  }
}
