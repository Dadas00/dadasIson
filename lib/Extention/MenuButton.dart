import 'package:flutter/material.dart';

class MenuButton extends MaterialButton {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () { print(77); },
      child: Image(
        width: 50,
        height: 50,
        image: AssetImage('assets/images/menu.png')
      )
    );
  }
}