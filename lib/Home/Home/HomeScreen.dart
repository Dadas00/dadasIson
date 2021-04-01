import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_apaga/Extention/GradientButton.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/Extention/PrivacyPolicy.dart';
import 'package:smart_apaga/Home/Home/PickupListManager.dart';
import 'package:smart_apaga/Pickup/View/QRScanScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: MediaQuery.of(context).size.width * 0.14,
                image: AssetImage('assets/images/logo.png'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              Text(
                'Pickups',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              MenuButton()
            ],
          ),
          SizedBox(height: 30),
          Expanded(child: PickupListManager()),
          GradientButton(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 45,
            onPressed: () async {
              // SharedPreferences pref = await SharedPreferences.getInstance();
              // pref.setBool('login', false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRScanScreen()),
              );
            },
            text: Text(
              'Schedul a pickup'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
