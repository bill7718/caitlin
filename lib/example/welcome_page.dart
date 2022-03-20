import 'package:caitlin/caitlin.dart';
import 'package:caitlin/example/example_controller.dart';
import 'package:flutter/material.dart';
import 'package:waterloo/beta/waterloo_event_button.dart';



///
/// The main Landing Page for the application
///
class WelcomePage extends StatelessWidget {
  static const String route = 'welcomePage';

  const WelcomePage({ key }) : super(key: key);


  @override
  Widget build(BuildContext context) {



    return SingleChildScrollScaffold(
        title: 'Welcome Page',
        child: Column(
          children: const [
            WaterlooEventButton(text: 'Register', event: ExampleController.registerEvent)
          ],
        ));
  }
}
