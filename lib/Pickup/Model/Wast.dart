import 'package:flutter/foundation.dart';

class Waste {
  String bagCode;
  String type;

  Waste({this.bagCode, @required this.type});

  Map toMap() {
    return {
      'bagCode': bagCode ?? '',
      'type': type,
    };
  }
}
