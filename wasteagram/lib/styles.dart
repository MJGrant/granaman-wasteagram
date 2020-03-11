import 'package:flutter/material.dart';

class Styles {

  static const _textSizeBigger = 18.0;

  static get appTitle =>
      TextStyle(
        fontFamily: 'OleoScript',
        color: Colors.white,
        fontSize: 28,
      );

  static get postTitle =>
      TextStyle(
        fontSize: 22,
      );

  static get detailsItemsCount =>
      TextStyle(
        fontSize: 18,
      );

  static get detailsCoords =>
      TextStyle(
        fontSize: 14,
        color: Colors.grey,
      );
}