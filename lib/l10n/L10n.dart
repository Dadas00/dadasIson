import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('hy'),
    const Locale('ru'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'hy':
        return 'π¦π²';
      case 'ru':
        return 'π·πΊ';
      case 'en':

      default:
        return 'πΊπΈ';
    }
  }
}
