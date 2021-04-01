import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginState.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/view/login/LoginForm.dart';
import 'package:smart_apaga/LoginRegister/view/register/RegForm.dart';



class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(_userRepository),
        child: LoginForm()
      )
    );
  }

}
