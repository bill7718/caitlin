

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {

  final List<Provider> providers;
  final ThemeData theme;
  final Widget child;

  const MyApp({Key? key, required this.providers, required this.theme, required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: Center(
            child: MaterialApp(
                theme: theme,
                debugShowCheckedModeBanner: false,
                home: child
            )));
  }
}

