import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(AppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(AppThemeState());

    } else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value){
        emit(AppThemeState());
      });
    }
  }
}