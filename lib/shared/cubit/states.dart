import 'package:shopping_app/models/login_model.dart';

abstract class ShopAppStates {}

class AppInitialState extends ShopAppStates {}

class AppThemeState extends ShopAppStates {}

class AppLoginInitialState extends ShopAppStates {}

class AppLoginLoadingState extends ShopAppStates {}

class AppLoginSuccessState extends ShopAppStates {
  final ShopUserLoginModel loginModel;

  AppLoginSuccessState(this.loginModel);

}

class AppLoginErrorState extends ShopAppStates {

  final String? error;

  AppLoginErrorState(this.error);
}

class AppShowPasswordState extends ShopAppStates {}