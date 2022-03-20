
import 'package:caitlin/caitlin.dart';
import 'package:caitlin/example/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:waterloo/waterloo.dart';

import 'example_controller.dart';
import 'example_navigator.dart';
import 'example_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final i = Injector.appInstance;
  registerDependencies(i);

  runApp(MyApp(
      providers: [
        Provider<WaterlooTextProvider>.value(
            value: i.get<WaterlooTextProvider>()),
        Provider<WaterlooTheme>.value(value: i.get<WaterlooTheme>()),
        Provider<WaterlooEventHandler>.value(value: i.get<WaterlooEventHandler>()),
      ],
      theme: exampleTheme(),
      child:
          Injector.appInstance.get<Widget>(dependencyName: WelcomePage.route)));
}

void registerDependencies(Injector i) {
  //var file = File(Directory.current.path + '/data.json');
  //var fb = LocalData(file);
  //var reader = DatabaseReader(fb);
  // var updater = DatabaseUpdater(fb);
  var text = InitialisedTextProvider(<Map<String, String>>[]);

  i.registerSingleton<WaterlooTextProvider>(() => text);
  i.registerSingleton<UserJourneyNavigator>(() => ExampleNavigator());
  i.registerSingleton<WaterlooTheme>(() => WaterlooTheme());

  i.registerSingleton<Widget>(() => const WelcomePage(), dependencyName: WelcomePage.route );

  i.registerSingleton<WaterlooEventHandler>(
      () => ExampleController(i.get<UserJourneyNavigator>()));

}
