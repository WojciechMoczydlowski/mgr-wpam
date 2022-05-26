import 'dart:ui';

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2, 8)}';
}
