class ClientStates {}

class OnChangeBottomNavIndex extends ClientStates {
    final int index;
  OnChangeBottomNavIndex({required this.index});
}

class GetUserLoadingState extends ClientStates {}

class GetUserSuccessState extends ClientStates {}

class GetUserErrorState extends ClientStates {}