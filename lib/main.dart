import 'package:smart_apaga/Home/Home/HomeScreen.dart';
import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/ForgotScreen.dart';
import 'package:smart_apaga/LoginRegister/view/login/LoginScrean.dart';
import 'package:smart_apaga/LoginRegister/view/overal/AddressConfirmationScreen.dart';
import 'package:smart_apaga/LoginRegister/view/register/RegScreen.dart';
import 'package:smart_apaga/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MainScreen());
  });
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isHomeScreen = false;

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isHomeScreen = pref.getBool('login') ?? false;
      super.deactivate();
    });
  }

  @override
  void initState() {
    checkFirstScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isHomeScreen ? HomeScreen() : LoginScreen(),
    );
  }
}
