library event_handler;




abstract class StepOutput {

}

class EmptyStepOutput implements StepOutput {
  const EmptyStepOutput();
}


abstract class StepInput {

}

class EmptyStepInput implements StepInput {
  const EmptyStepInput();
}

class DynamicStepInput implements StepInput {
  dynamic payload;
  DynamicStepInput(this.payload);
}

