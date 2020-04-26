import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calculator.dart';

mixin BaseTextField {
  // calculator
  String get title;
  double get initialValue;
  BoxDecoration get boxDecoration;
  Color get appBarBackgroundColor;
  Color get operatorButtonColor;
  Color get normalButtonColor;
  Color get operatorTextButtonColor;
  Color get normalTextButtonColor;
  Color get doneButtonColor;
  Color get doneTextButtonColor;

  Future<double> showInputCalculator(BuildContext context) async {
    final args = InputCalculatorArgs(
      title: title ?? '',
      initialValue: initialValue,
      boxDecoration: boxDecoration,
      appBarBackgroundColor: appBarBackgroundColor,
      operatorButtonColor: operatorButtonColor,
      operatorTextButtonColor: operatorTextButtonColor,
      normalButtonColor: normalButtonColor,
      normalTextButtonColor: normalTextButtonColor,
      doneButtonColor: doneButtonColor,
      doneTextButtonColor: doneTextButtonColor,
    );

    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Calculator(args: args)),
    );

    return result;
  }
}