import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';

class WastTypeScreen extends StatefulWidget {
  final String barcode;
  final List<Waste> wastes;
  WastTypeScreen({this.barcode, this.wastes});

  @override
  _WastTypeScreenState createState() =>
      _WastTypeScreenState(barcode: barcode, wastes: wastes);
}

class _WastTypeScreenState extends State<WastTypeScreen> {
  String barcode;

  int gestureTag = 0;

  List<Waste> wastes;

  List<String> types = ['plastic', 'paper', 'glass'];

  _WastTypeScreenState({this.barcode, this.wastes});

  int selectedState = 0;
  int previewSelectedState = 0;

  void _onGesturTap(int tag) {
    if (selectedState != 0) {
      wastes.removeLast();
    }
    selectedState = gestureTag;
    wastes.add(Waste(bagCode: barcode, type: types[gestureTag]));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text('Wast Type'),
          backgroundColor: Colors.green[300],
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Column(
            children: [
              Text('''
Below, plase approximate how many 100L
bags of waste you have for each type of
waste
                ''',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    //
                    //
                    //
                    //Plastic
                    Container(
                      decoration: BoxDecoration(
                          color: gestureTag == 1
                              ? Colors.green[100]
                              : Colors.white,
                          border: Border.all(color: Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gestureTag = 1;
                                      _onGesturTap(gestureTag);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/plastic2.png")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Plastic',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //
                                barcode != null
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 25,
                                                width: 50,
                                                child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.red)),
                                                  color: Colors.red,
                                                  textColor: Colors.black,
                                                  padding: EdgeInsets.all(1.0),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 25,
                                                width: 50,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.green)),
                                                  onPressed: () {},
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  child: Text("+",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 30,
                    ),
                    //
                    //
                    //
                    //
                    //Paper
                    Container(
                      decoration: BoxDecoration(
                          color: gestureTag == 2
                              ? Colors.green[100]
                              : Colors.white,
                          border: Border.all(color: Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gestureTag = 2;
                                      _onGesturTap(gestureTag);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/paper2.png")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Paper',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //
                                barcode != null
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 25,
                                                width: 50,
                                                child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.red)),
                                                  color: Colors.red,
                                                  textColor: Colors.black,
                                                  padding: EdgeInsets.all(1.0),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 25,
                                                width: 50,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.green)),
                                                  onPressed: () {},
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  child: Text("+",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 30,
                    ),
                    //
                    //
                    //
                    //
                    //Glass
                    Container(
                      decoration: BoxDecoration(
                          color: gestureTag == 3
                              ? Colors.green[100]
                              : Colors.white,
                          border: Border.all(
                            color: Colors.green,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gestureTag = 3;
                                      _onGesturTap(gestureTag);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/glass2.png")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Glass',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //
                                barcode != null
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 25,
                                                width: 50,
                                                child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.red)),
                                                  color: Colors.red,
                                                  textColor: Colors.black,
                                                  padding: EdgeInsets.all(1.0),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 25,
                                                width: 50,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.green)),
                                                  onPressed: () {},
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  child: Text("+",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    //buy bag
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
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
                              "Order Bags",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                  Navigator.pop(context, wastes);
                                },
                                child: Text(
                                  "ADD Another bag",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              // constraints: BoxConstraints(
                              //     minWidth: screenSize.width * 0.4),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SchedulScreen()));
                                },
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Next",
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
