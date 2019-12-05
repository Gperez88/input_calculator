import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import 'numeric_text_field.dart';

class CalculatorOperator {
  static const none = 'none';
  static const sum = '+';
  static const subtraction = '-';
  static const multiplication = 'x';
  static const division = '/';
  static const clear = 'C';
  static const del = 'DEL';
  static const equal = '=';
  static const submit = "DONE";

  static const main = [
    clear,
    del,
    equal,
  ];

  static const all = [
    sum,
    subtraction,
    multiplication,
    division,
    clear,
    del,
    equal,
  ];
}

const List<List<String>> _keyRows = [
  const [
    'C',
    'DEL',
    '=',
  ],
  const [
    '.',
    '0',
    '00',
    '+',
  ],
  const [
    '1',
    '2',
    '3',
    '-',
  ],
  const [
    '4',
    '5',
    '6',
    'x',
  ],
  const [
    '7',
    '8',
    '9',
    '/',
  ],
];

class InputCalculatorArgs {
  String title;
  double initialValue;
  BoxDecoration decoration;
  Color appBarBackgroundColor;
  Color operatorButtonColor;
  Color normalButtonColor;
  Color operatorTextButtonColor;
  Color normalTextButtonColor;
  Color doneButtonColor;
  Color doneTextButtonColor;

  InputCalculatorArgs({
    this.title,
    this.initialValue,
    this.decoration,
    this.appBarBackgroundColor,
    this.operatorButtonColor,
    this.normalButtonColor,
    this.operatorTextButtonColor,
    this.normalTextButtonColor,
    this.doneButtonColor,
    this.doneTextButtonColor,
  });
}

class InputCalculator extends StatefulWidget {
  static const id = 'input_calculator';

  final InputCalculatorArgs args;

  InputCalculator({
    this.args,
  });

  @override
  _InputCalculatorState createState() => _InputCalculatorState();
}

class _InputCalculatorState extends State<InputCalculator> {
  static const ZERO = '0';
  static const ZERO_ZERO = '00';
  static const POINT = '.';

  final TextEditingController _inputNumberController = TextEditingController();

  String _equalTitleBtn = CalculatorOperator.submit;

  get equalTitleBtn => _equalTitleBtn;
  set equalTitleBtn(value) {
    setState(() {
      _equalTitleBtn = value;
    });
  }

  String _developmentOperationText = '';

  bool _clickArithmeticOperator = false;
  bool _clearInput = false;

  double _firstValue;
  double _secondValue;

  String _operatorExecute = CalculatorOperator.none;
  String _prevOperatorExecute = CalculatorOperator.none;

  @override
  void initState() {
    super.initState();

    double initialValue = widget.args?.initialValue ?? 0;
    var parts = '$initialValue'.split(POINT);

    if (parts.length > 1 && parts[1] == '0') {
      _inputNumberController.text =
          NumberFormat.decimalPattern().format(double.parse(parts[0]));
    } else {
      _inputNumberController.text =
          NumberFormat.decimalPattern().format(initialValue);
    }
  }

  @override
  void dispose() {
    _inputNumberController.dispose();
    super.dispose();
  }

  // listeners
  void _numberBtnOnPressed(value) {
    _concatNumeric(value);
    _clickArithmeticOperator = false;
  }

  void _operatorBtnOnPressed(value) {
    switch (value) {
      case CalculatorOperator.sum:
      case CalculatorOperator.subtraction:
      case CalculatorOperator.multiplication:
      case CalculatorOperator.division:
        if (_inputNumberController.text.isEmpty ||
            _inputNumberController.text == POINT) return;

        equalTitleBtn = CalculatorOperator.equal;
        _operatorExecute = value;

        if (!_clickArithmeticOperator) {
          _clickArithmeticOperator = true;
          _prepareOperation(false);
        } else {
          _replaceOperator(value);
        }
        break;
      case CalculatorOperator.clear:
        _clear();
        break;

      case CalculatorOperator.del:
        _removeLastNumber();
        break;

      case CalculatorOperator.equal:
      case CalculatorOperator.submit:
        if (_inputNumberController.text == POINT) {
          String temp = _developmentOperationText;
          _clear();
          _inputNumberController.text = temp;
          break;
        }

        if (_operatorExecute == CalculatorOperator.submit ||
            _firstValue == null) {
          _returnResultOperation();
        } else {
          _prepareOperation(true);
          _clearInput = false;
          _clickArithmeticOperator = false;
          _operatorExecute = CalculatorOperator.submit;
          _prevOperatorExecute = CalculatorOperator.none;
          _firstValue = null;
          _secondValue = null;
        }
        break;
    }
  }

  // operation functions
  void _prepareOperation(bool isEqualExecute) {
    _clearInput = true;

    if (isEqualExecute) {
      equalTitleBtn = CalculatorOperator.submit;
      _developmentOperationText = '';
    } else {
      _concatDevelopingOperation(
          _operatorExecute, _inputNumberController.text, false);
    }

    if (_firstValue == null) {
      _firstValue =
          double.parse(_inputNumberController.text.replaceAll(',', ''));
    } else if (_secondValue == null) {
      _secondValue =
          double.parse(_inputNumberController.text.replaceAll(',', ''));

      _executeOperation(_prevOperatorExecute);
    }

    _prevOperatorExecute = _operatorExecute;
  }

  void _concatDevelopingOperation(
      String calculatorOperator, String value, bool clear) {
    bool noValidCharacter = calculatorOperator == CalculatorOperator.clear ||
        calculatorOperator == CalculatorOperator.del ||
        calculatorOperator == CalculatorOperator.equal;

    if (!noValidCharacter) {
      String oldValue = clear ? '' : _developmentOperationText;
      _developmentOperationText = '$oldValue $value $calculatorOperator';
    }
  }

  void _executeOperation(String calculatorOperator) {
    if (_firstValue == null || _secondValue == null) return;

    double resultOperation = 0.0;

    switch (calculatorOperator) {
      case CalculatorOperator.sum:
        resultOperation = _firstValue + _secondValue;
        break;

      case CalculatorOperator.subtraction:
        resultOperation = _firstValue - _secondValue;
        break;

      case CalculatorOperator.multiplication:
        resultOperation = _firstValue * _secondValue;
        break;

      case CalculatorOperator.division:
        if (_secondValue > 0) resultOperation = _firstValue / _secondValue;
        break;
    }

    _inputNumberController.text = _formatValue(resultOperation);
    _firstValue = resultOperation;
    _secondValue = null;
  }

  void _concatNumeric(String value) {
    if (value == null || _inputNumberController.text == null) return;

    String oldValue = _inputNumberController.text;
    String newValue = _clearInput || (oldValue == ZERO && value != POINT)
        ? value
        : oldValue + value;

    newValue = (oldValue == ZERO && value == ZERO_ZERO) ? oldValue : newValue;

    _inputNumberController.text = newValue;
    _clearInput = false;
  }

  void _returnResultOperation() {
    final value = _inputNumberController.text;
    final parts = value.split(POINT);

    String result = parts.length > 1 && parts[1] == '' ? parts[0] : value;

    Navigator.of(context)
        .pop(double.parse(result == '' ? '0' : result.replaceAll(',', '')));
  }

  void _replaceOperator(String calculatorOperator) {
    String operationValue = _developmentOperationText;

    if (operationValue.isEmpty) return;

    String oldOperator = operationValue.substring(
        operationValue.length - 1, operationValue.length);

    if (oldOperator == calculatorOperator) return;

    String operationNewValue =
        operationValue.substring(0, operationValue.length - 2);

    _concatDevelopingOperation(calculatorOperator, operationNewValue, true);
  }

  String _formatValue(double value) {
    String valueStr = NumberFormat.simpleCurrency(name: '').format(value);

    String integerValue = valueStr.substring(0, valueStr.indexOf(POINT));
    String decimalValue =
        valueStr.substring(valueStr.indexOf(POINT) + 1, valueStr.length);

    if (decimalValue == ZERO_ZERO || decimalValue == ZERO) return integerValue;

    return valueStr;
  }

  void _removeLastNumber() {
    String value = _inputNumberController.text;

    if (value.length != 0)
      _inputNumberController.text = value.substring(0, value.length - 1);
  }

  void _clear() {
    equalTitleBtn = CalculatorOperator.submit;

    _firstValue = null;
    _secondValue = null;
    _operatorExecute = CalculatorOperator.none;
    _prevOperatorExecute = CalculatorOperator.none;

    _developmentOperationText = '';
    _inputNumberController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final inputContainerHeight = MediaQuery.of(context).size.height / 3;
    final keyboardTopOverlad =
        (inputContainerHeight - (MediaQuery.of(context).size.height / 4) + 16);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(widget.args?.initialValue ?? 0);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.args?.title ?? ''),
          backgroundColor: widget.args?.appBarBackgroundColor,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: inputContainerHeight,
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 72.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _developmentOperationText,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    NumericTextField(
                      controller: _inputNumberController,
                      textAlign: TextAlign.end,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                      ),
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: inputContainerHeight - keyboardTopOverlad,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                decoration: widget.args?.decoration ??
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(48)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(0, -1),
                            blurRadius: 4)
                      ],
                    ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildKeyRows(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildKeyRows(BuildContext context) {
    List<Widget> keyRows = [];
    final screenHeight = MediaQuery.of(context).size.height;
    var padding = EdgeInsets.all(8.0);

    if (screenHeight <= 550) {
      padding = EdgeInsets.all(1.0);
    } else if (screenHeight > 550 && 600 >= screenHeight) {
      padding = EdgeInsets.all(4.0);
    }

    _keyRows.reversed.forEach((keyRow) => keyRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildKeyRow(keyRow, padding, context),
          ),
        ));

    return keyRows;
  }

  List<Widget> _buildKeyRow(
      List<String> row, EdgeInsets padding, BuildContext context) {
    List<Widget> keyRow = [];

    row.forEach(
      (key) => keyRow.add(
        _buildButtom(_isEqualOperator(key) ? equalTitleBtn : key,
            circle: !_isMainOperator(key),
            titleColor: _isOperator(key)
                ? widget.args?.operatorTextButtonColor
                : widget.args?.normalTextButtonColor,
            color: _isOperator(key)
                ? widget.args?.operatorButtonColor
                : widget.args?.normalButtonColor,
            onPressed: () => _isOperator(key)
                ? _operatorBtnOnPressed(key)
                : _numberBtnOnPressed(key),
            padding: padding,
            context: context),
      ),
    );
    return keyRow;
  }

  bool _isSumitOperator(String key) => key == CalculatorOperator.submit;

  bool _isEqualOperator(String key) => key == CalculatorOperator.equal;

  bool _isMainOperator(String key) => CalculatorOperator.main.contains(key);

  bool _isOperator(String key) => CalculatorOperator.all.contains(key);

  Widget _buildButtom(String title,
      {bool circle = true,
      Color titleColor,
      Color color,
      EdgeInsets padding,
      Function onPressed,
      BuildContext context}) {
    return Expanded(
      child: Container(
        padding: padding,
        child: _KeyboardButton(
          title: title,
          titleColor: _isSumitOperator(title)
              ? widget.args?.doneTextButtonColor
              : titleColor,
          color: _isSumitOperator(title) ? widget.args?.doneButtonColor : color,
          circle: circle,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _KeyboardButton extends RawMaterialButton {
  _KeyboardButton({
    title,
    titleColor,
    circle = true,
    color,
    elevation = 0.0,
    onPressed,
  }) : super(
          fillColor: color ?? Colors.white,
          constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
          elevation: elevation,
          shape: circle ? CircleBorder() : StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title ?? ' ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: titleColor ?? Colors.grey,
              ),
            ),
          ),
          onPressed: onPressed,
        );
}
