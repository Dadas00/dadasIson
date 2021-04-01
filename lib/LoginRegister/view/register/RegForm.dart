import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:smart_apaga/Extention/GradientButton.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterState.dart';

import 'package:smart_apaga/LoginRegister/model/Company.dart';
import 'package:smart_apaga/LoginRegister/model/User.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegisterForm> {

  final TextEditingController _fullNameController = TextEditingController(text: 'asdfasd');
  final TextEditingController _phoneNumberController = TextEditingController(text: '093335588');
  final TextEditingController _emailController = TextEditingController(text: 'sdfsd@sdf');
  final TextEditingController _passwordController = TextEditingController(text: 'sdfgsdfg');
  final TextEditingController _legalNameController = TextEditingController();
  final TextEditingController _taxCodeController = TextEditingController();
  final TextEditingController _legalAddressController = TextEditingController();
  final TextEditingController _sdnController = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();


  bool isCompany = false;
  bool disclimer = true;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state, BuildContext context) {
    if (disclimer) {
      showAlert(context);
      return !disclimer;
    }
    return true;//state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    
    _fullNameController.addListener(_onFullNameChange);
    _phoneNumberController.addListener(_onPhoneChange);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
    _legalNameController.addListener(_onLegalNameChange);
    _taxCodeController.addListener(_onTaxCodeChange);
    _legalAddressController.addListener(_onLegalAddressChange);
    _sdnController.addListener(_onSdnChange);
    _companyEmailController.addListener(_onCompanyEmailChange);
  }
  

  @override
  Widget build(BuildContext context) {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);

    String upDown = isCompany ? 'down' : 'up';
    return BlocListener<RegisterBloc, RegisterState>(
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
          // BlocProvider.of<AuthenticationBloc>(context).add(
          //   AuthenticationLoggedIn(),
          // );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
            // child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      errorText: !state.isFullNameValid ? 'Invalid Full Name' : null, 
                    ),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                  ),

                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      errorText: !state.isPhoneValid ? 'Invalid Phone Number' : null,
                    ),
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                  ),

                  TextFormField(
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
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: !state.isPasswordValid ? 'Invalid Password' : null,
                    ),
                    obscureText: true,
                    autocorrect: false,
                  ),

                  SizedBox(height: 15,),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 20,
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Image(image: AssetImage('assets/images/$upDown.png')),
                                  SizedBox(width: 20),
                                  Text('Sign-up as an organization', style: TextStyle(color: Colors.green[300]),)
                                ],
                              ),
                              onTap: () => setState(() {
                                isCompany = !isCompany;
                              }),
                            )
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    )
                  ),
                  
                  Container(
                    child: isCompany ? Column(
                      children: [
                        
                        TextFormField(
                          controller: _legalNameController,
                          decoration: InputDecoration(
                            labelText: "Company Legal Name",
                            errorText: !state.isLegalNameValid ? 'Invalid Company Legal Name' : null,
                          ),
                          keyboardType: TextInputType.name,
                        ),

                        TextFormField(
                          controller: _taxCodeController,
                          decoration: InputDecoration(
                            // icon: Icon(Icons.email),
                            labelText: "Tax Code",
                            errorText: !state.isTaxCodeValid ? 'Invalid Tax Code' : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),

                        TextFormField(
                          controller: _legalAddressController,
                          decoration: InputDecoration(
                            labelText: "Legal Address",
                            errorText: !state.isLegalAddressValid ? 'Invalid Company Legal Address' : null,
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),

                        TextFormField(
                          controller: _sdnController,
                          decoration: InputDecoration(
                            labelText: "Signing Director's Name",
                            errorText: !state.isSdnValid ? 'Invalid Signing Director' : null,
                          ),
                        ),

                        TextFormField(
                          controller: _companyEmailController,
                          decoration: InputDecoration(
                            labelText: "Company Email",
                            errorText: !state.isCompanyEmailValid ? 'Invalid Company Email' : null,
                          ),
                        ),

                      ]
                    ) : null,
                  ),
                  
                  SizedBox(height: 15),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: GestureDetector(
                              child: disclimer ? null : Icon(Icons.check, size: 18, color: Colors.green[500],),
                              onTap: () => setState(() {
                                disclimer = !disclimer;
                              }),
                            )
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text('''
I am authorized to complete this from and I 
have read and agreed to SmartApaga’s terms
of use and privacy policy
                      ''',
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    )
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  GradientButton(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 45,
                    onPressed: () {
                      if (isButtonEnabled(state, context)) {
                        _onFormSubmitted();
                      }
                    },
                    text: Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            // ),
          );
        },
      ),
    );
  }

  void _onFullNameChange() {
    _registerBloc.add(RegisterFullNameChanged(fullName: _fullNameController.text));
  }

  void _onPhoneChange() {
    _registerBloc.add(RegisterPhoneChanged(phone: _phoneNumberController.text));
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc.add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onLegalNameChange() {
    _registerBloc.add(RegisterLegalNameChanged(legalName: _legalNameController.text));
  }

  void _onTaxCodeChange() {
    _registerBloc.add(RegisterTaxCodeChanged(taxCode: _taxCodeController.text));
  }

  void _onLegalAddressChange() {
    _registerBloc.add(RegisterLegalAddressChanged(legalAddress: _legalAddressController.text));
  }

  void _onSdnChange() {
    _registerBloc.add(RegisterSdnChanged(sdn: _sdnController.text));
  }

  void _onCompanyEmailChange() {
    _registerBloc.add(RegisterCompanyEmailChanged(companyEmail: _companyEmailController.text));
  }

  showAlert(BuildContext context) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('Click Disclimer.'),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
     },
    );
  }

  void _onFormSubmitted() {
    final fullName = _fullNameController.text;
    final phone =  _phoneNumberController.text;
    final email =  _emailController.text; 
    final password =  _passwordController.text;
    final legalName =  _legalNameController.text;
    final taxCodde =  _taxCodeController.text;
    final legalAddress =  _legalAddressController.text;
    final sdn =  _sdnController.text;
    final companyEmail = _companyEmailController.text; 

    Company company = Company(
      name: legalName,
      taxCode: taxCodde,
      legalAddress: legalAddress,
      signingDirector: sdn,
      email: companyEmail
    );

    User user = User(
      fullname: fullName,
      phoneNumber: phone,
      email: email, 
      password: password,
      company: isCompany ? company : null 
    );

    _registerBloc.add(RegisterSubmitted(user: user));
  }


}
