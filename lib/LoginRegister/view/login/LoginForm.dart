
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_apaga/Home/Home/HomeScreen.dart';


import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginState.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/ForgotScreen.dart';
import 'package:smart_apaga/LoginRegister/view/register/RegScreen.dart';


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

    
  final TextEditingController _emailController = TextEditingController(text: 'aa@aa.aa');
  final TextEditingController _passwordController = TextEditingController(text: 'aaaaaa');

  UserRepository _userRepository;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Register Failure'),
                        Icon(Icons.error),
                      ],
                    ),
                    backgroundColor: Color(0xffffae88),
                  ),
                );
            }

            if (state.isSubmitting) {
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Registering...'),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: Color(0xffffae88),
                  ),
                );
            }

            if (state.isSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Text(
                              "Welcome to SmartApaga",
                              style: TextStyle(color: Colors.lightGreen, fontSize: 24),         
                            ),
                            Image(
                              height: MediaQuery.of(context).size.width * 0.5,
                              image: AssetImage('assets/images/login.png')
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[

                                _emailField(state),

                                _passwordField(state),
                                
                                _forgotButton(context),
                                
                                _loginButton(state),
                                
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [

                                      _signUpButton(context),
                                      
                                      Row(children: <Widget>[
                                          Expanded(
                                            child: new Container(
                                                margin: const EdgeInsets.only(left: 30.0, right: 20.0),
                                                child: Divider(
                                                  color: Colors.black,
                                                  // height: 36,
                                                )),
                                          ),
                                          Text("or"),
                                          Expanded(
                                            child: new Container(
                                                margin: const EdgeInsets.only(left: 20.0, right: 30.0),
                                                child: Divider(
                                                  color: Colors.black,
                                                  // height: 36,
                                                )),
                                          ),
                                        ]
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            MaterialButton(
                                              onPressed: () {},
                                              
                                              color: Colors.grey,
                                              child: Text(                                      
                                                'f', 
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  ), 
                                                ),
                                              // padding: EdgeInsets.all(5),
                                              shape: CircleBorder(),
                                            ),

                                            MaterialButton(
                                              onPressed: () {},
                                              color: Colors.grey,
                                              textColor: Colors.white,
                                              child: Icon(
                                                Icons.mail,
                                                size: 23,
                                              ),
                                              shape: CircleBorder(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        child: Row(                                                                                                                  
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: null, 
                              child: Text('Terms of Use')
                            ),
                            Container(height: 15, child: VerticalDivider(color: Colors.black)),
                            FlatButton(
                              onPressed: null,
                              child: Text('Privacy Policy'),)
                          ],
                        ),
                      ),
                      
                    ],
                  ),

                );
              },
            ),
        );
  }




  Widget _emailField(LoginState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "Email",
          errorText: !state.isEmailValid ? 'Invalid Email' : null,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green[700]),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
      ),
    );
  }

  Widget _passwordField(LoginState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 0.0,
      ),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: !state.isPasswordValid ? 'Invalid Password' : null,
        ),
        obscureText: true,
        autocorrect: false,
      ),
    );
  }

  Widget _loginButton(LoginState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: state.isSuccess && state.isPasswordValid ? null : _login,
        color: Colors.green,
        disabledColor: Colors.green[800],
        disabledTextColor: Colors.white60,
        padding: EdgeInsets.all(15.0),
        child: Text(
          'Log In',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white
          ),
        ),
      ),
    );
  }
  
  Widget _forgotButton(BuildContext context) {
    return FlatButton(
      textColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
      splashColor: Colors.greenAccent,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPassword()),
        );
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Forgot password",
          style: TextStyle(fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegScreen()),
        );
      }, 
      textTheme: ButtonTextTheme.normal,
      child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.green),),
    );
  }

   void _onEmailChange() {
    _loginBloc.add(LoginEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _login() {
    var email = _emailController.text;
    var password = _passwordController.text;

    Map userMap = {'email': email, 'password': password};
    _loginBloc.add(LoginSubmitted(user: userMap));
  }

}
