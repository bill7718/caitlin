

import 'package:waterloo/waterloo.dart';

class SimpleTextProvider implements WaterlooTextProvider {
  @override
  String? get(String? reference)=>reference;

  @override
  bool has(String? reference)=>true;
}

class InitialisedTextProvider implements WaterlooTextProvider {

  final Map<String, String> _textMap = <String, String>{};

  InitialisedTextProvider(List<Map<String, String>>? data) {
    for (var map in data ?? []) {
      _textMap.addAll(map);
    }
  }

  @override
  String? get(String? reference)=>reference == null ? null : _textMap[reference] ?? reference;

  @override
  bool has(String? reference)=>reference == null ? false : true;
}