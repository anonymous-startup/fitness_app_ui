import 'dart:ffi';

class Macro {
  String macroName;
  double macroQuantity;
  Macro({this.macroName = "", this.macroQuantity = 0});

  set quantity(double val) {
    macroQuantity = val;
  }

  set name(String val) {
    macroName = val;
  }

  String get name => macroName;
  double get quantity => macroQuantity;
}
