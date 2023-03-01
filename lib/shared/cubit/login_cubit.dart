import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';

import '../network/endpoints.dart';

class ShopAppLoginCubit extends Cubit<ShopAppStates>
{
  ShopAppLoginCubit() : super(AppLoginInitialState());

  static ShopAppLoginCubit get(context) => BlocProvider.of(context);

  void userLogin
      ({
    required String email,
    required String password
})
  {
    emit(AppLoginLoadingState());

    DioHelper.postData(
        path: logIn,
        data: {
          'email' : email,
          'password': password
        },
    ).then((value){
      print(value);
      emit(AppLoginSuccessState());
    }).catchError((error){
      emit(AppLoginErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppShowPasswordState());
  }
}