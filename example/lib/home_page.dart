import 'package:flutter/material.dart';

import 'package:input_calculator/input_calculator.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();

  double _value = 0.0;

  set value(double value) {
    _value = value;
    _inputController.text = '$value';
  }

  @override
  void dispose() {
    _inputController.dispose();

    super.dispose();
  }

  void _showInputCalculator(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(
      InputCalculator.id,
      arguments: InputCalculatorArgs(
        title: 'Example',
        initialValue: _value,
        operatorButtonColor: Colors.amber,
        operatorTextButtonColor: Colors.white,
        normalButtonColor: Colors.white,
        normalTextButtonColor: Colors.grey,
        doneButtonColor: Colors.blue,
        doneTextButtonColor: Colors.white,
      ),
    );

    value = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: TextField(
          controller: _inputController,
          readOnly: true,
          onTap: () => _showInputCalculator(context),
        ),
      ),
    );
  }
}
