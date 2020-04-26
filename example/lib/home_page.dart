import 'package:flutter/material.dart';

import 'package:input_calculator/input_calculator.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _value = 0.0;

  set value(double value) {
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: CalculatorTextField(
          initialValue: _value,
          onSubmitted: (value) {
            this.value = value;
            print('value: $value');
          },
        ),
      ),
    );
  }
}
