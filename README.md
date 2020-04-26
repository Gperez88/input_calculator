# input_calculator

With Input Calculator widget you can add functionality of calculation in an TextField.

## examples

<p align="center">
<img src="https://raw.githubusercontent.com/Gperez88/input_calculator/master/images/screen_shot.png" width="140" height="280" hspace="20"/>
</p>

## Usage

CalculatorTextField

```dart
...

CalculatorTextField(
  initialValue: _value,
  onSubmitted: (value) {
    _value = value;
    print('value: $_value');
  },
)

...
```

CalculatorTextFormField

```dart
...

CalculatorTextFormField(
  initialValue: _value,
  validator: (value) {
    if (value.isEmpty) {
      return 'Madatory field';
    }
    return null;
  }, 
  onSubmitted: (value) {
    _value = value;
    print('value: $_value');
  },
)

...
```

## Let's customize it !

- `title`: title to show on appbar.
  
- `initialValue`: initial value to show.
  
- `appBarBackgroundColor`: appbar color.

- `boxDecoration`: decotation of panel buttons.
  
- `operatorButtonColor`: color operator button.
  
- `operatorTextButtonColor`: color text of operator button.

- `normalButtonColor`: color normal button.
  
- `normalTextButtonColor`: color text of normal button.

- `doneButtonColor`: color done button.
  
- `doneTextButtonColor`: color text of done button.

