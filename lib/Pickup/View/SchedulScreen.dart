import 'package:flutter/material.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/Home/Home/HomeScreen.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/LoginRegister/view/overal/AddressConfirmationScreen.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class SchedulScreen extends StatefulWidget {
  @override
  _SchedulScreenState createState() => _SchedulScreenState();
}

class _SchedulScreenState extends State<SchedulScreen> {
  List<Address> addresses = [];

  bool isShowAddresses = false;
  String addressImageName;
  int selectedAddressIndex = 0;

  DateTime selectedDate = DateTime.now();
  String date;
  
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String timeBegin;
  String timeEnd;

  List<int> wastCounts = [0, 0, 0];

  @override
  void initState() {
    var x = Address(streetName: "Adonc");
    var b = Address(streetName: "Baxramyan");
    addresses.add(x);
    addresses.add(b);

    date = DateFormat.yMd().format(DateTime.now());
    timeBegin = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn]).toString();
    timeEnd = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn]).toString();

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenSizeHeight = screenSize.height - AppBar().preferredSize.height;

    addressImageName = isShowAddresses ? "addressesUp" : "addressesDown";

    return Scaffold(
        appBar: AppBar(
            title: Text('Shedule a pickup'),
            backgroundColor: Colors.grey[400],
            automaticallyImplyLeading: true,
            actions: <Widget>[MenuButton()],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: screenSize.height - 44,
                width: screenSize.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    /**
                     


                    Addresses

                    
                     */
                    Row(
                      children: [
                        SizedBox(
                            width: screenSize.width * 0.45,
                            child: Text(addresses[selectedAddressIndex].streetName ??
                                "sfdsf")),
                        MaterialButton(
                            child: Image(
                              width: 30,
                              height: 30,
                              image:
                                  AssetImage("assets/images/$addressImageName.png"),
                            ),
                            onPressed: () => setState(() {
                                  isShowAddresses = !isShowAddresses;
                                })),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text('Add'),
                          color: Colors.green[300],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddressConfirmationScreen()));
                          },
                        )
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
                        child: ListView.builder(
                          padding: EdgeInsets.all(5.0),
                          itemCount: addresses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MaterialButton(
                              color: Colors.grey[200],
                              onPressed: () => setState(() {
                                selectedAddressIndex = index;
                                isShowAddresses = false;
                              }),
                              child: Text(addresses[index].streetName),
                            );
                          },
                          // separatorBuilder: (BuildContext context, int index) =>
                          //     Divider(),
                        ),
                      ),
                    ),
                    /**
                     


                     Date

                    
                     */
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Row(
                        children: [
                          Text(
                            "Pickup Date",
                            style: TextStyle(fontSize: 18),
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
                                  border: Border.all(color: Colors.grey[300])),
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
                            image: AssetImage("assets/images/calendar.png"),
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pickup Time",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Interval: (min 3 hours)",
                              style: TextStyle(fontSize: 12),
                            ),
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
                                border: Border.all(color: Colors.grey[300])),
                            child: MaterialButton(
                              child: Text(
                                timeBegin,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: () { _selectTime(context, true); },
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
                                border: Border.all(color: Colors.grey[300])),
                            child: MaterialButton(
                              child: Text(
                                timeEnd,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: () {_selectTime(context, false);},
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
                                image: AssetImage("assets/images/plastic1.png"),
                                // height: 70,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "x ${wastCounts[0]}",
                                style: TextStyle(color: Colors.green, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage("assets/images/paper1.png"),
                                // height: 70,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "x ${wastCounts[1]}",
                                style: TextStyle(color: Colors.green, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage("assets/images/glass1.png"),
                                // height: 70,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "x ${wastCounts[2]}",
                                style: TextStyle(color: Colors.green, fontSize: 20),
                              ),
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
                                    "Note For Driver",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Expanded(
                                    child: SizedBox.shrink(),
                                  )
                                ],
                              ),
                            ),
                            TextField(
                              // controller: _noteTextFieldController,

                              maxLines: null,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: """
  Writing any specific details theat will help the driver
  compleate the pickup. Ex: Bags will be at the door, or
  Jiggle the handle. It is not locked.
                                """,
                                hintStyle:
                                    TextStyle(color: Colors.grey[500], fontSize: 13),
                                border: InputBorder.none,
                              ),
                              autocorrect: false,
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
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
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
  }
}
