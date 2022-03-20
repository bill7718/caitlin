
import 'package:caitlin/caitlin.dart';
import 'package:caitlin/example/welcome_page.dart';

class ExampleController extends MappedJourneyController {
  static const String registerEvent = 'register';


  @override
  String currentRoute = WelcomePage.route;

  ExampleController(UserJourneyNavigator navigator)
      : super(navigator);

  @override
  Map<String, dynamic> get globalEvents => {

      };

  @override
  Map<String, Map<String, dynamic>> get functionMap => {
    WelcomePage.route: {
          registerEvent : WelcomePage.route
        },

      };

  @override
  ExampleState state = ExampleState();


}

class ExampleState  implements StepInput {
  ExampleState();
}
