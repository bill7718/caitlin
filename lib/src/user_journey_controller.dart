import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:waterloo/waterloo.dart';

import 'event_handler.dart';
import 'exception_page.dart';

abstract class UserJourneyController implements WaterlooEventHandler {
  static const String initialEvent = 'initial';
  static const String startEvent = 'start';
  static const String nextEvent = 'next';
  static const String backEvent = 'back';
  static const String cancelEvent = 'cancel';
  static const String confirmEvent = 'confirm';
  static const String homeEvent = 'home';
  static const String saveEvent = 'save';

  static const StepOutput emptyOutput = EmptyStepOutput();

  ///
  /// The current route in this journey
  ///
  ///
  /// A route specifies the page which is to be shown to the user. Normally each page has it's own unique route'
  ///
  String get currentRoute;

  final UserJourneyNavigator _navigator;

  UserJourneyController(this._navigator);

  ///
  /// Handles an exception by showing the [ExceptionPage]
  ///
  @override
  void handleException(dynamic context, dynamic ex, StackTrace? st) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ExceptionPage(ex, st: st);
    }));
  }

  UserJourneyNavigator get navigator => _navigator;
}

///
/// A class that controls the flow of a journey via the contents of a Map
///
abstract class MappedJourneyController extends UserJourneyController {
  /// see [handleEvent]
  static const String goUp = 'goUp';

  /// see [handleEvent]
  static const String goDown = 'goDown:';

  /// The value for the route that applies on entry to this journey
  static const String initialRoute = '';

  ///
  /// Maps the route and event to the action taken by the system in response to that event.
  ///
  /// See [handleEvent] which provides an explanation of how this data is used.
  ///
  Map<String, Map<String, dynamic>> get functionMap;

  Map<String, dynamic> get globalEvents => <String, dynamic>{};

  MappedJourneyController(UserJourneyNavigator navigator) : super(navigator);

  /// Gets the state object used in the journey. This is used as the [StepInput] when this class navigates to a page.
  StepInput get state;

  set currentRoute(String s);

  ///
  /// Handles Events based on the data in the [functionMap]
  ///
  /// This method looks up an entry in the Map for the current route and event
  /// - if the entry is a [Function] the the system calls the function
  /// - if the entry is [goUp] then the system navigates up the Navigation tree. This action normally completes this journey
  /// - if the entry starts with [goDown] then the system navigates down the Navigation tree to the route in the entry
  /// - otherwise the system navigates to the route corresponding to the entry
  ///
  /// Throws a [UserJourneyException] if no entry can be found in the map for the route/event combination.
  ///
  @override
  Future<void> handleEvent(context,
      {String event = '',
      dynamic output = UserJourneyController.emptyOutput}) async {
    var globalEventAction = globalEvents[event];
    if (globalEventAction != null) {
      if (globalEventAction is Function) {
        return globalEventAction(context, output);
      } else {
        if (globalEventAction is String) {
          currentRoute = globalEventAction;
          navigator.goTo(context, currentRoute, this, state);
          return;
        } else {
          throw UserJourneyException(
              'Invalid global event for current Journey $event : $currentRoute : $globalEvents');
        }
      }
    }

    var m = functionMap[currentRoute];
    if (m == null) {
      throw UserJourneyException(
          'Invalid current route for current Journey $currentRoute : $functionMap');
    } else {
      var action = m[event];
      if (action == null) {
        throw UserJourneyException(
            'Invalid event $event for current Journey : route $currentRoute : $functionMap');
      } else {
        if (action is Function) {
          return action(context, output);
        }
        if (action is String) {
          if (action == goUp) {
            navigator.goUp(context);
          } else {
            if (action.startsWith(goDown)) {
              currentRoute = action.substring(goDown.length);
              navigator.goDownTo(context, currentRoute, this, state);
            } else {
              currentRoute = action;
              navigator.goTo(context, currentRoute, this, state);
            }
          }
        }
      }
    }
  }
}

class UserJourneyException implements Exception {
  final String _message;

  UserJourneyException(this._message);

  @override
  String toString() => _message;
}

abstract class UserJourneyNavigator {
  Future<void> goTo(dynamic context, String route, WaterlooEventHandler handler,
      StepInput input) {
    var c = Completer<void>();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MultiProvider(
        providers: [
          Provider<WaterlooEventHandler>.value(value: handler),
          Provider<StepInput>.value(value: input),
          Provider<JourneyRoute>(create: (context) => JourneyRoute(route)),
        ],
        child: Injector.appInstance.get<Widget>(dependencyName: route),
      );
    }));

    c.complete();
    return c.future;
  }

  Future<void> goDownTo(dynamic context, String route,
      WaterlooEventHandler handler, StepInput input) {
    var c = Completer<void>();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MultiProvider(
        providers: [
          Provider<WaterlooEventHandler>.value(value: handler),
          Provider<StepInput>.value(value: input),
          Provider<JourneyRoute>(
            create: (context) => JourneyRoute(route),
          )
        ],
        child: Injector.appInstance.get<Widget>(dependencyName: route),
      );
    }));

    c.complete();
    return c.future;
  }

  Future<void> goUp(dynamic context) {
    var c = Completer<void>();
    Navigator.pop(context);
    c.complete();
    return c.future;
  }
}

class JourneyRoute {
  String route;
  JourneyRoute(this.route);
}
