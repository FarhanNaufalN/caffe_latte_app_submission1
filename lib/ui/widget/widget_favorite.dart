import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonFavorite extends StatefulWidget {
  @override
  _ButtonFavoriteState createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: isFavorite
              ? Text('Favorited')
              : Text('UnFavorite'),
        ));
      },
    );
  }
}