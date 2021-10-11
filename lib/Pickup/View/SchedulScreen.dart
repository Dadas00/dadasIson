import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBloc.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupEvent.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupState.dart';
import 'package:smart_apaga/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedulScreen extends StatefulWidget {
  final Address value;
  final List<int> countwast;
  final int gestureTag;
  SchedulScreen({Key key, this.value, this.countwast, this.gestureTag})
      : super(key: key);
  @override
  _SchedulScreenState createState() =>
      _SchedulScreenState(value, countwast, gestureTag);
}

class _SchedulScreenState extends State<SchedulScreen> {
  List<Address> _addressesList = [];
  List<Waste> wastes = [];
  //String _myaddress;
  //List<Address> _address = [];
  Future<List<Address>> _futureAddres;
  List<Address> addresLs = [];
  Address address;
  List<dynamic> types = ['plastic', 'paper', 'glass'];
  final items = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5'];
  Address value;
  List<int> countwast = [0, 0, 0];
  int gestureTag;
  String _selectedLocation;
  //var countwast;
  _SchedulScreenState(this.value, this.countwast, this.gestureTag);

  PickupBloc _pickupBloc;

  bool isShowAddresses = false;
  String addressImageName;
  int selectedAddressIndex = 0;

  DateTime selectedDate = DateTime.now();
  String date;
  Pickup pickup;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String timeBegin;
  String timeEnd;
  //List<int> wastCounts = [0, 0, 0];

  //WastTypeScreenState _wastTypeScreenState = new WastTypeScreenState();
  TextEditingController _noteTextFieldController =
      TextEditingController(text: 'Dadas');

  int get tag => null;

  @override
  void initState() {
    // //var x = Address(streetName: value);
    // var b = Address(streetName: value);

    // //addresses.add(x);
    // addresses.add(b);
    _pickupBloc = BlocProvider.of<PickupBloc>(context);
    _futureAddres = fetchAddress();

    date = DateFormat.yMd().format(DateTime.now());
    timeBegin = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn]).toString();
    timeEnd = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn]).toString();

    super.initState();

    _noteTextFieldController.addListener(_onNoteFieldChanged);
  }

  Future<Null> _selectTime(BuildContext context, bool timeBegin) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        if (timeBegin) {
          this.timeBegin = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn]).toString();
        } else {
          this.timeEnd = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn]).toString();
        }
      });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        date = DateFormat.yMd().format(selectedDate);
      });
  }

  // ignore: missing_return
  Future<List<Address>> fetchAddress() async {
    dynamic token = await FlutterSession().get('token');

    //List<Address> addList = [];
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.address),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var body = json.decode(response.body);

      // print(body);
      if (body['status'] == 1) {
        dynamic data = body['data'];
        data.forEach((element) {
          Address addresses = Address.fromJson(element);
          addresLs.add(addresses);
        });
      }
    } catch (error) {
      print(error);
    }
    //addresLs.add(addressList);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // ignore: unused_local_variable
    var screenSizeHeight = screenSize.height - AppBar().preferredSize.height;

    addressImageName = isShowAddresses ? "addressesUp" : "addressesDown";

    return BlocBuilder<PickupBloc, PickupState>(
        bloc: BlocProvider.of<PickupBloc>(context),
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  title: Text(AppLocalizations.of(context).shchedulMenuText),
                  backgroundColor: Colors.grey[400],
                  automaticallyImplyLeading: true,
                  //actions: [MenuButton()],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, true),
                  )),
              endDrawer: MenuButton(),
              // body: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     _dropDownMenu(),
              //   ],
              // ));
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      height: screenSize.height - 14,
                      width: screenSize.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          /**

                Addresses

                    */
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          // DropdownButton<String>(
                          //   items: items.map(buidMenuItem).toList(),
                          //   onChanged: (value) =>
                          //       setState(() => this.value = value),
                          // ),
                          // getPickupAddressList(),
                          // _dropDownMenu(),
                          //   ],
                          // ),

                          Row(
                            children: [
                              SizedBox(
                                  width: screenSize.width * 0.45,
                                  child: Text("Enter Add")),
                              MaterialButton(
                                  child: Image(
                                    width: 30,
                                    height: 30,
                                    image: AssetImage(
                                        "assets/images/$addressImageName.png"),
                                  ),
                                  onPressed: () => setState(() {
                                        isShowAddresses = !isShowAddresses;
                                      })),
                              // MaterialButton(
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(18.0),
                              //   ),
                              //   child: Text('Add'),
                              //   color: Colors.green[300],
                              //   onPressed: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 AddressConfirmationScreen()));
                              //   },
                              // )
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: screenSize.width * 0.5,
                              child: Column(
                                children: [
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: isShowAddresses ? 100 : 0,
                              width: screenSize.width * 0.5,
                              color: Colors.grey[200],
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text('1'),
                                          Text('2'),
                                          Text('3'),
                                        ],
                                      ),
                                    ),

                                    // getPickupAddressList(),
                                  ],
                                ),
                              ),

                              // child: ListView.builder(
                              //   padding: EdgeInsets.all(5.0),
                              //   itemCount: addresses.length,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return MaterialButton(
                              //       color: Colors.grey[200],
                              //       onPressed: () => setState(() {
                              //         selectedAddressIndex = index;
                              //         isShowAddresses = false;
                              //       }),
                              //       child: Text(addresses[index].streetName ??
                              //           'added your address'),
                              //     );
                              //   },
                              //   // separatorBuilder: (BuildContext context, int index) =>
                              //   //     Divider(),
                              // ),
                            ),
                          ),
                          // getPickupAddressList(),

                          /**

                 Date

                 */
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).pickupDateText,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[300])),
                                    child: Text(
                                      date,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Image(
                                  image:
                                      AssetImage("assets/images/calendar.png"),
                                ),
                              ],
                            ),
                          ),
                          /**

                 Time

                 */
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context).pickupTimeText,
                                  style: TextStyle(fontSize: 15),
                                ),
                                // Text(
                                //   AppLocalizations.of(context).pickupTimeText,
                                //   style: TextStyle(fontSize: 18),
                                // ),
                                // Text(
                                //   AppLocalizations.of(context).intervalText,
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   AppLocalizations.of(context).intervalText,
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300])),
                                  child: MaterialButton(
                                    child: Text(
                                      timeBegin,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      _selectTime(context, true);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "To",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300])),
                                  child: MaterialButton(
                                    child: Text(
                                      timeEnd,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      _selectTime(context, false);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Image(
                                image: AssetImage("assets/images/clock.png"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context).intervalText,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),

                          // Text(
                          //   AppLocalizations.of(context).intervalText,
                          //   style: TextStyle(fontSize: 12),
                          // ),
                          /**

                 Type Count

                 */
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/plastic1.png"),
                                      // height: 70,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    // Text(
                                    //   // ignore: unnecessary_brace_in_string_interps
                                    // countwast == null ?? "x ${countwast[0]}": '0',
                                    //   style: TextStyle(
                                    //       color: Colors.green, fontSize: 20),
                                    // ),
                                    gestureTag == 0
                                        ? Text(
                                            'x 1',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20),
                                          )
                                        : Text(
                                            'x 0',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20),
                                          ),
                                    //initlaWast(0),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/paper1.png"),
                                      // height: 70,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    gestureTag == 1
                                        ? Text(
                                            'x 1',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20),
                                          )
                                        : Text(
                                            'x 0',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20),
                                          ),
                                    // initlaWast(1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/glass1.png"),
                                      // height: 70,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    gestureTag == 2
                                        ? Text(
                                            'x 1',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20),
                                          )
                                        : Text(
                                            'x 0',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20),
                                          ),
                                    // initlaWast(2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /**

                 Note For Driver

                 */
                          SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey[300])),
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    color: Colors.grey,
                                    child: Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).noteText,
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
                                      controller: _noteTextFieldController,
                                      maxLines: 100,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .noteCommentText,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 13),
                                        border: InputBorder.none,
                                      ),
                                      autocorrect: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          /**

                 Bottom Buttons

                 */

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  // constraints: BoxConstraints(
                                  //     minWidth: screenSize.width * 0.3),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.green),
                                      ),
                                      primary: Colors.green,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).cancelText,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.green)),
                                      primary: Colors.green,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      // getValues(pickup);
                                      _buttonSumbitted();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             HomeScreen()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .confirmText,
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  void _buttonSumbitted() {
    final dates = date;
    final timeBegins = timeBegin;
    final timeEnds = timeEnd;
    final noteText = _noteTextFieldController.text;
    final bagsCount = 2;
    wastes.add(Waste(type: types[gestureTag]));
    print("Wastes_dadas-$wastes");

    Pickup pickup = Pickup(
        address: addresLs,
        date: dates,
        timeBegin: timeBegins,
        timeEnd: timeEnds,
        noteForDriver: noteText,
        bagCount: bagsCount,
        waste: wastes);
    _pickupBloc.add(PickupSumbited(pickup: pickup));
    // _getValues(pickup);
  }

  // Widget initlaWast(int count) {
  //   if (countwast == null) {
  //     return Text('x 0', style: TextStyle(color: Colors.green, fontSize: 20));
  //   }
  //   switch (count) {
  //     case 0:
  //       return Text('x ${countwast[0]}',
  //           style: TextStyle(color: Colors.green, fontSize: 20));
  //     case 1:
  //       return Text('x ${countwast[1]}',
  //           style: TextStyle(color: Colors.green, fontSize: 20));
  //     case 2:
  //       return Text('x ${countwast[2]}',
  //           style: TextStyle(color: Colors.green, fontSize: 20));
  //       break;
  //     default:
  //   }
  //   return Text('x 0', style: TextStyle(color: Colors.green, fontSize: 20));
  // }

  // Future<List<Pickup>> _getValues(Pickup pickup) async {
  //   List<Pickup> pickup = [];
  //   try {
  //     dynamic token = FlutterSession().get('token');
  //     var url = Uri.parse(ApiEndpoints.pickupAdd);
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: json.encode(this.pickup),
  //     );

  //     // print(response.body);

  //     var body = jsonDecode(response.body);
  //     inspect(body);

  //     if (response.statusCode == 200) {
  //       return pickup = List<Pickup>.from(body.map((e) => Pickup.fromJson(e)));
  //     } else {
  //       throw Exception("Failed create");
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //   return pickup;
  // }

  _onNoteFieldChanged() {
    _pickupBloc.add(PicupNoteChanged(note: _noteTextFieldController.text));
  }

  Widget getPickupAddressList() {
    return FutureBuilder(
        future: fetchAddress(),
        builder: (context, snapshot) {
          List<Widget> children;
          if (!snapshot.hasData) {
            return Center(
              child: Text('Davaditios'),
            );
          } else if (snapshot.hasData) {
            // snapshot.data.forEach((element) {
            //   addresses.add(element);
            //   inspect(object)(addresses);
            // });
            //int addressId;
            children = <Widget>[
              // DropdownButton<Address>(items: snapshot.data.map<dynamic>((e) {
              //   return DropdownMenuItem(
              //     value: e,
              //     child: Text(
              //       "${e.streetName}",
              //       style:
              //           TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              //     ),
              //   );
              // }))
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: snapshot.data.length,
              //     scrollDirection: Axis.vertical,
              //     itemBuilder: (context, index) {
              //       return SingleChildScrollView(
              //           child: MaterialButton(
              //         color: Colors.grey[200],
              //         onPressed: () => setState(() {
              //           selectedAddressIndex = index;
              //           isShowAddresses = false;
              //         }),
              //         child: Text(snapshot.data[index].toString()),
              //       ));
              //     }),
              // Text('dadas jan')
            ];
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        });
  }

  Widget _dropDownMenu() {
    if (_addressesList == null) {
      return FutureBuilder<List<Address>>(
          future: _futureAddres,
          // ignore: missing_return
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Dadass'),
              );
            } else if (snapshot.hasData) {
              for (var item in snapshot.data) {
                _addressesList.add(item);
                _selectedLocation = snapshot.data.toString();
                return _createDropdownMenu();
              }
            } else
              return CircularProgressIndicator();
          });
    }
    return _createDropdownMenu();
  }

  Widget _createDropdownMenu() {
    return DropdownButton<String>(
      hint: Text('Please help me'),
      value: _selectedLocation,
      onChanged: (newValue) {
        setState(() {
          _selectedLocation = newValue;
        });
      },
      items: _addressesList.map((data) {
        print("AAAAsssaaaalLLAa" + data.id.toString());
        return DropdownMenuItem<String>(
          child: new Text("${data.id}"),
          value: data.id.toString(),
        );
      }).toList(),
    );
  }

  List<Address> parseAddresses(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();
    return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  }

  // ignore: missing_return
  Widget initalWasteCount(int int) {
    if (int == null) {
      Text('0');
    } else {
      Text('${countwast[0]}');
    }
  }

  @override
  void dispose() {
    _noteTextFieldController.dispose();
    super.dispose();
  }

  DropdownMenuItem<Address> buidMenuItem(Address item) => DropdownMenuItem(
          child: Text(
        item.streetName,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ));
}
