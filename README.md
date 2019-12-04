# input_calculator

With Input Calculator widget you can add functionality of calculation in an TextField.

## examples

<p align="center">
<img src="https://raw.githubusercontent.com/ThomasEcalle/delayed_display/master/documentation/horizontal.gif" width="140" height="280" hspace="20"/>
  
<img src="https://raw.githubusercontent.com/ThomasEcalle/delayed_display/master/documentation/vertical.gif" width="140" height="280" hspace="20"/>
</p>

## Usage

Initializer `InputCalculator` on `onGenerateRoute`:

```dart
Route<dynamic> _generateRoute(RouteSettings settings) {
  switch (settings.name) {
      
    ...

    case InputCalculator.id:
      final args = settings.arguments;
      return MaterialPageRoute(builder: (_) => InputCalculator(args: args));

    ...
  }
}
```

on the widget that use it

```dart
...

TextField(
    controller: _inputController,
    readOnly: true,
    onTap: () => _showInputCalculator(context),
)

...
```

`_inputController` TextEditingController to pass result value of return of `InputCalculator`

set `readOnly: true` for not show system keyboard

`_showInputCalculator` is the method to show `InputCalculator`

```dart
  void _showInputCalculator(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(
      InputCalculator.id,
      arguments: InputCalculatorArgs(

        ...

      ),
    );

    ...
  }
```


## Let's customize it !

`InputCalculatorArgs` object of arguments supported of the widget for customize it.

```dart
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

  ...
}
```

- `title`: title to show on appbar.
  
- `appBarBackgroundColor`: appbar color.

- `initialValue`: initial value to show on input calculator.

- `decoration`: decotation of panel buttons of input calculator.
  
- `operatorButtonColor`: color operator button of input calculator.
  
- `operatorTextButtonColor`: color text of operator button of input calculator.

- `normalButtonColor`: color normal button of input calculator.
  
- `normalTextButtonColor`: color text of normal button of input calculator.

- `doneButtonColor`: color done button of input calculator.
  
- `doneTextButtonColor`: color text of done button of input calculator.

