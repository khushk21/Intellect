import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  final Function func;
  RectangleButton(this.text, [this.func]);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: func,
      color: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Regular',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
