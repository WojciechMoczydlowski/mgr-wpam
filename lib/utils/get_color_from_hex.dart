import 'package:flutter/painting.dart';

Color getColorFromHex(String hexColor) {
  return Color(int.parse(hexColor.replaceAll('#', '0xff')));
}
