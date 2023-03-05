class AdminStates {}

class OnChangeAdminBottomNavIndex extends AdminStates {
    final int index;
  OnChangeAdminBottomNavIndex({required this.index});
}

class GetAdminLoadingState extends AdminStates {}

class GetAdminSuccessState extends AdminStates {}

class GetAdminErrorState extends AdminStates {}