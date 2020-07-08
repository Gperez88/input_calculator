import 'package:example/utils.dart';
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
    setState(() {
      _value = value;
    });
  }

  String valueFormat(double value) {
    return CurrencyFormat.format(value, symbol: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: CalculatorTextField(
          initialValue: _value,
          valueFormat: valueFormat,
          theme: CalculatorThemes.curve,
          inputDecoration: InputDecoration(
            labelText: 'Value',
            icon: Icon(Icons.attach_money),
          ),
          onSubmitted: (value) {
            this.value = value;
            print('value: $value');
          },
        ),
      ),
    );
  }
}
