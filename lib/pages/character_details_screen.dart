import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_despicable_me_ui/models/character.dart';
import 'package:flutter_app_despicable_me_ui/styleguide.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;
  final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;

  const CharacterDetailsScreen({Key key, this.character}) : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen>
    with AfterLayoutMixin<CharacterDetailsScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${characters[0].name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.character.colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            transitionOnUserGestures: true,
          ),
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Platform.isIOS ? SizedBox(height: 40) : SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      setState(() {
                        _bottomSheetBottomPosition =
                            widget._completeCollapsedBottomSheetBottomPosition;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Hero(
                        tag: "image-${characters[0].name}",
                        child: Image.asset(widget.character.imagePath,
                            height: screenHeight * 0.45)),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                      tag: "name-${characters[0].name}",
                      child: Material(
                          color: Colors.transparent,
                          child: Container(
                              child: Text(widget.character.name,
                                  style: AppTheme.heading)))),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 8, 85),
                      child: Hero(
                          tag: "description-${characters[0].name}",
                          child: Material(
                              color: Colors.transparent,
                              child: Container(
                                  child: Text(widget.character.description,
                                      style: AppTheme.subHeading)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut,
            bottom: _bottomSheetBottomPosition,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: _onTap,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      height: 60,
                      child: Text(
                        "Clips (${widget.character.catalogPath.length})",
                        style: AppTheme.subHeading.copyWith(
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _clipsWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: <Widget>[
          _getCatalog(widget.character.catalogPath),
        ],
      ),
    );
  }

  Widget _getCatalog(List<String> strings) {
    List<Widget> list = new List<Widget>();
    if (strings.length % 2 != 0) {
      for (var i = 0; i < (strings.length ~/ 2) + 1; i++) {
        if (strings.length % 2 != 0 && i == (strings.length ~/ 2)) {
          list.add(Column(
            children: <Widget>[
              roundedContainer(
                  Colors.redAccent, widget.character.catalogPath[i + i]),

            ],
          ));
        } else {
          list.add(Column(
            children: <Widget>[
              roundedContainer(
                  Colors.redAccent, widget.character.catalogPath[i + i]),
              SizedBox(height: 20),
              roundedContainer(
                  Colors.greenAccent, widget.character.catalogPath[i + 1 + i]),
            ],
          ));
        }

        list.add(new SizedBox(
            width: 40
        )

        );
      }
    } else {
      for (var i = 0; i < strings.length / 2; i++) {
        list.add(Column(
          children: <Widget>[
            roundedContainer(
                Colors.redAccent, widget.character.catalogPath[i]),
            SizedBox(height: 20),
            roundedContainer(
                Colors.greenAccent, widget.character.catalogPath[i + 1]),
          ],
        ));
        list.add(new SizedBox(
            width: 40
        )

        );
      }
    }
    return Row(children: list);
  }


  Widget roundedContainer(Color color, String url) {
    return GestureDetector(
      onTap: () {
        _showDialog(url);
      },
      child: Material(
        color: Colors.transparent,
        elevation: 20,
        child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child:
                new Image.asset(url, fit: BoxFit.cover, height: 100))
        ),
      ),
    );
  }

  _onTap() {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expandedBottomSheetBottomPosition
          : widget._collapsedBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetBottomPosition = widget._collapsedBottomSheetBottomPosition;
      });
    });
  }

  void _showDialog(String url) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new Image.asset(url, fit: BoxFit.fitWidth, width: (MediaQuery
                .of(context)
                .size
                .width / 3) * 2.2, alignment: Alignment.center,
            ),

          ],
        );
      },
    );
  }
}
