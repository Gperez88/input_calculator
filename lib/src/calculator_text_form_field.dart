import 'package:flutter/material.dart';

import 'base_text_field.dart';

class CalculatorTextFormField extends StatefulWidget with BaseTextField {
  CalculatorTextFormField({
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
    this.validator,
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
  final FormFieldValidator<String> validator;

  @override
  _CalculatorTextFormFieldState createState() =>
      _CalculatorTextFormFieldState();
}

class _CalculatorTextFormFieldState extends State<CalculatorTextFormField> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      readOnly: true,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      validator: widget.validator,
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
