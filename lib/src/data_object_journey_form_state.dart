

import 'package:serializable_data/serializable_data.dart';
import 'package:waterloo/waterloo.dart';

import 'event_handler.dart';


class DataObjectJourneyFormInputState extends StepInput {
  static const EventSpecification nextEvent =
  EventSpecification(event: 'next', description: 'Next');
  static const EventSpecification previousEvent =
  EventSpecification(event: 'back', description: 'Back', mustValidate: false);

  static const List<EventSpecification> defaultEvents = <EventSpecification>[
    previousEvent,
    nextEvent
  ];

  static const defaultDataSpecification = <String, DataSpecification>{};
  static const defaultRelationshipSpecification = <String, RelationshipSpecification>{};

  final dynamic data;
  final Map<String, DataSpecification> specifications;
  final List<EventSpecification> events;
  final String formContextTitle;
  final Map<String, RelationshipSpecification> relationships;
  final String? initialError;
  final String formMessage;


  DataObjectJourneyFormInputState(this.data,  {
    this.formContextTitle = '',  this.specifications = defaultDataSpecification, this.events = defaultEvents,
    this.relationships = defaultRelationshipSpecification, this.initialError, this.formMessage = '' }
      );
}
