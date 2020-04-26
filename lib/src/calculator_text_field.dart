import 'package:flutter/material.dart';

import 'base_text_field.dart';

class CalculatorTextField extends StatefulWidget with BaseTextField {
  CalculatorTextField({
    Key key,
    this.title,
    this.initialValue = 0.0,
    this.boxDecoration,
    this.appBarBackgroundColor,
    this.operatorButtonColor: Colors.amber,
    this.operatorTextButtonColor: Colors.white,
    this.normalButtonColor: Colors.white,
    this.normalTextButtonColor: Colors.grey,
    this.doneButtonColor: Colors.blue,
    this.doneTextButtonColor: Colors.white,
    this.onSubmitted,
    this.inputDecoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final String title;
  final double initialValue;
  final BoxDecoration boxDecoration;
  final Color appBarBackgroundColor;
  final Color operatorButtonColor;
  final Color operatorTextButtonColor;
  final Color normalButtonColor;
  final Color normalTextButtonColor;
  final Color doneButtonColor;
  final Color doneTextButtonColor;
  final ValueChanged<double> onSubmitted;
  final InputDecoration inputDecoration;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;

  @override
  _CalculatorTextFieldState createState() => _CalculatorTextFieldState();
}

class _CalculatorTextFieldState extends State<CalculatorTextField> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      readOnly: true,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      onTap: () async {
        final resutl = await widget.showInputCalculator(context);
        setState(() {
          inputController.text = '${resutl ?? 0.0}';

          if (widget.onSubmitted != null) widget.onSubmitted(resutl);
        });
      },
    );
  }
}
