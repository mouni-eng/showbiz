class LocationStates {}

class LocationLoadingState extends LocationStates {}

class LocationSuccessState extends LocationStates {}

class FindLocationSuccessState extends LocationStates {}

class LocationErrorState extends LocationStates {
  String? error;
  LocationErrorState({required this.error});
}

class OnChangeState extends LocationStates {}
