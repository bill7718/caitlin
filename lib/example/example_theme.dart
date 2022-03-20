
import 'package:flutter/material.dart';

ThemeData exampleTheme() {
  var theme = ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal,
      // the background color for the body widgets in the scaffold
      backgroundColor: Colors.white
  ));

  var subtitle1 = theme.textTheme.subtitle1;


  var bodyText1 = theme.textTheme.bodyText1;


  theme = theme.copyWith(textTheme: theme.textTheme.copyWith(subtitle1: subtitle1));
  theme = theme.copyWith(textTheme: theme.textTheme.copyWith(bodyText1: bodyText1));
  theme = theme.copyWith(cardTheme: theme.cardTheme.copyWith(elevation: 10));
  theme = theme.copyWith(iconTheme: theme.iconTheme.copyWith(color: theme.primaryColor));
  theme = theme.copyWith(listTileTheme: theme.listTileTheme.copyWith(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      tileColor: Colors.white60) );


  return theme;
}

