import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/cubit_observer.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';
import 'package:shopping_app/shared/styles/themes.dart';
import 'modules/onboarding_screen.dart';

void main() async
{
  // To ensure everything before the run is done
  // and is added as long as the main is async
  WidgetsFlutterBinding.ensureInitialized();
  /*DioHelper.init();*/
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  print(onBoarding);
  // bool isDark = true;
  //CacheHelper.getData(key: 'isDark');
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  //final bool isDark;
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider(create: (BuildContext context) => NewsAppCubit()/*..getBusinessNews()..getSportsNews()..getScienceNews()*/),
        BlocProvider(create: (BuildContext context) => ShopAppCubit()/*..changeMode(fromShared: isDark,)..getBusinessNews()..getSportsNews()..getScienceNews()*/),
      ],
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
          listener: (context, state){},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ShopAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              // light mode theme data
              theme: lightMode,
              // dark mode theme data
              darkTheme: darkTheme,
              home: /*BlocProvider(
              create: (context) => NewsAppCubit(),
              child:*/ const OnBoardingScreen(),
            );
          }),
    );
    //);
  }
}
