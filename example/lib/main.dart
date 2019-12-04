import 'package:flutter/material.dart';

import 'home_page.dart';
import 'package:input_calculator/src/input_calculator.dart';

Route<dynamic> _generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.id:
      return MaterialPageRoute(builder: (_) => HomePage());
    case InputCalculator.id:
      final args = settings.arguments;
      return MaterialPageRoute(builder: (_) => InputCalculator(args: args));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.id,
      onGenerateRoute: _generateRoute,
    );
  }
}
