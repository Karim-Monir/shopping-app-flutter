import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/modules/register_screen.dart';
import 'package:shopping_app/shared/components/components.dart';

import '../shared/cubit/login_cubit.dart';
import '../shared/cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => ShopAppLoginCubit(),
      child: BlocConsumer<ShopAppLoginCubit, ShopAppStates>(
        listener: (context, state){
          if(state is AppLoginSuccessState){
            if(state.loginModel.status == true){
              print(state.loginModel.data?.token);
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }else {
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Dark_bold'
                          ),
                        ),
                        Text(
                          'Login now to catch our hot deals',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Email must be entered';
                            }
                            return null;
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          isPassword: ShopAppLoginCubit.get(context).isPassword,
                          prefix: Icons.lock_outline,
                          suffix: ShopAppLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            ShopAppLoginCubit.get(context).changePasswordVisibility();
                          } ,
                          onSubmit: (value){
                            if(formKey.currentState!.validate())
                            {
                              ShopAppLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopAppLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('You don\'t have an account?'),
                            TextButton(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const RegisterScreen()
                                    )
                                );
                              },
                              child: const Text('Register now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),
          );
        }
      )
    );
  }
}
