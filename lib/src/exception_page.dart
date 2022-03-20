import 'package:flutter/material.dart';
import 'package:waterloo/waterloo.dart';

import 'single_child_scroll_scaffold.dart';


///
/// The main Landing Page for the application
///
class ExceptionPage extends StatelessWidget {
  static const String titleRef = 'exceptionPage';

  final dynamic ex;
  final StackTrace? st;

  const ExceptionPage(this.ex, {Key? key, this.st})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    final error = FormError();

    return SingleChildScrollScaffold(
        title: 'Exception Page',
        child: Column(
          children: [
            Container(margin: const EdgeInsets.all(10), child: Headline6(ex.toString())),
            Container(margin: const EdgeInsets.all(10), child: Text(st.toString())),
          ],
        ));
  }
}
