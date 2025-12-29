sealed class OccasionEvents {}

class LoadInitialEvent extends OccasionEvents {
  final String? initialOccasion;
  LoadInitialEvent({this.initialOccasion});
}

class TabChangedEvent extends OccasionEvents {
  final String tab;
  TabChangedEvent(this.tab);
}


