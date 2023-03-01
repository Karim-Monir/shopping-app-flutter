abstract class ShopAppStates {}

class AppInitialState extends ShopAppStates {}

class AppThemeState extends ShopAppStates {}

class AppLoginInitialState extends ShopAppStates {}

class AppLoginLoadingState extends ShopAppStates {}

class AppLoginSuccessState extends ShopAppStates {}

class AppLoginErrorState extends ShopAppStates {

  final String? error;

  AppLoginErrorState(this.error);
}

class AppShowPasswordState extends ShopAppStates {}