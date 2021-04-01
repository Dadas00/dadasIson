import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';

class AddressConfirmationScreen extends StatefulWidget {
  @override
  State<AddressConfirmationScreen> createState() => _AddressConfirmationState();
}

class _AddressConfirmationState extends State<AddressConfirmationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1872, 44.5152),
    zoom: 12,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  double mapHeight = 0;

  TextEditingController _streetNameController = TextEditingController();
  TextEditingController _bdgController = TextEditingController();
  TextEditingController _aptController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  TextEditingController _entrController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    mapHeight = screenSize.height * 0.4;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Address Confirmation'),
        backgroundColor: Colors.grey[400],
        automaticallyImplyLeading: false,
        // actions: <Widget>[MenuButton()],
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context, false),
        // )
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            // Map
            Container(
              height: mapHeight,
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (position) async {
                      final coordinates = Coordinates(
                          position.target.latitude, position.target.longitude);

                      // var addresses = await Geocoder.local
                      //     .findAddressesFromCoordinates(coordinates);
                      // var first = addresses.first;
                      setState(() {
                        _streetNameController.text =
                            "${coordinates.latitude} : ${coordinates.longitude}";
                      });
                    },
                  ),
                  Positioned(
                      left: screenSize.width / 2 - 25,
                      bottom: mapHeight / 2,
                      child: Icon(
                        Icons.pin_drop_outlined,
                        size: 50,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _streetNameController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Street Name*",
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 13),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green[700]),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  Row(
                    children: [
                      // 1
                      Expanded(
                        child: TextFormField(
                          controller: _bdgController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: "Bdg*",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[700]),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      // 2
                      Expanded(
                        child: TextFormField(
                          controller: _aptController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: "Apt",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[700]),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      // 3
                      Expanded(
                        child: TextFormField(
                          controller: _floorController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: "Floor",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[700]),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      // 4
                      Expanded(
                        child: TextFormField(
                          controller: _entrController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: "Entr",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[700]),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /**
                 


                 Address Comment

                  
                 */

                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[300])),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              Text(
                                "Address comment",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              Expanded(
                                child: SizedBox.shrink(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            maxLines: null,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Address Comment",
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 13),
                              border: InputBorder.none,
                            ),
                            autocorrect: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.width * 0.1,
                  ),
                  /**
                 


                 Bottom Buttons

                
                 */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //cancel
                      Expanded(
                        // constraints: BoxConstraints(
                        //     minWidth: screenSize.width * 0.3),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          color: Colors.green,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      //confirm
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SchedulScreen()));
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text("Confirm", style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
