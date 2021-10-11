import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_apaga/globals.dart';
import 'package:smart_apaga/Home/Home/NoPickupItem.dart';
import 'package:smart_apaga/Home/Home/OrderBagsItem.dart';
// import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBlocWithEnum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_apaga/Home/pickupList_container.dart';

class PickupListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PickupListManagerState();
  }
}

class PickupListManagerState extends State<PickupListManager> {
  int groupedValue = 0;
  List<Pickup> pickups = [];

  Future<List<Pickup>> futurePickupList;
  // List<Pickup> _pickups = [
  //   Pickup(
  //     date: '21.10.20',
  //     timeBegin: '18:30',
  //     timeEnd: '19:30',
  //     waste: [],
  //     noteForDriver: 'sdfsdf',
  //     bagCount: 12,
  //   ),
  //   Pickup(
  //     date: '21.10.20',
  //     timeBegin: '18:30',
  //     timeEnd: '19:30',
  //     waste: [],
  //     noteForDriver: 'sdfsdf',
  //     bagCount: 7,
  //   ),
  //   Pickup(
  //     date: '21.10.20',
  //     timeBegin: '18:30',
  //     timeEnd: '19:30',
  //     waste: [],
  //     noteForDriver: 'laladen',
  //     bagCount: 5,
  //   ),
  // ];

  final pickupBloc = PickupBlocs();
  int purchasedBagCount = 5;
  bool isPassed = false;

  int _itemCount() {
    int count = pickups.length == 0 ? pickups.length + 1 : pickups.length;
    return purchasedBagCount != 0 ? count + 1 : count;
  }

  void _changeSegmentedControl(int value) {
    if (value == 0) {
      pickupBloc.eventSink.add(ApiEndpoints.pickupsOngoing);
      isPassed = false;
    } else {
      isPassed = true;
      pickupBloc.eventSink.add(ApiEndpoints.pickupsPassed);
    }
  }

  @override
  void initState() {
    pickupBloc.eventSink.add(ApiEndpoints.pickupsOngoing);
    super.initState();
    futurePickupList = getPickupLIst();
  }

  @override
  void dispose() {
    pickupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> segmentedItemList = {
      0: Text(AppLocalizations.of(context).ongoingText,
          style: TextStyle(color: Colors.black)),
      1: Text(AppLocalizations.of(context).passedText,
          style: TextStyle(color: Colors.black))
    };

    return FutureBuilder(
        future: futurePickupList,
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.data != null) {
            pickups = snapshot.data;
            isPassed = groupedValue == 0 ? false : true;
          }

          //var screenSize;
          return Column(children: [
            Container(
              width: 300,
              child: CupertinoSegmentedControl<int>(
                  borderColor: Colors.grey,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.grey,
                  children: segmentedItemList,
                  groupValue: groupedValue,
                  onValueChanged: (int value) {
                    groupedValue = value;

                    setState(() {
                      _changeSegmentedControl(groupedValue);
                    });
                  }),
            ),

            //List items
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemCount: _itemCount(),
                    itemBuilder: (BuildContext context, int index) {
                      if (purchasedBagCount != 0 && index == 0) {
                        return OrderBagsItem(purchasedBagCount);
                      }

                      if (pickups.length != 0) {
                        int i = purchasedBagCount != 0 ? index - 1 : index;

                        return PickupList(
                          isPassed: isPassed,
                          pickup: pickups[i],
                        );
                      }

                      return NoPickupItem();
                    })),
          ]);
        });
  }

  List<Pickup> parsePickups(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Pickup>((json) => Pickup.fromJson(json)).toList();
  }

  Future<List<Pickup>> getPickupLIst() async {
    dynamic token = await FlutterSession().get('token');
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.pickupsOngoing),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var body = jsonDecode(response.body);
      // parsePickups(response.body);

      if (body['status'] == 1) {
        dynamic data = body['data'];
        data.forEach((element) {
          Pickup address = Pickup.fromJson(element);
          pickups.add(address);
        });
        //pickups = List<Pickup>.from(data.map((e) => Pickup.fromJson(e)));
        inspect(pickups);
        return pickups;
      } else {
        print("Error ");
      }
    } catch (error) {
      print(error);
    }
    return pickups;
  }

  // Future<List<Pickup>> getPickupLIst() async {
  //   dynamic token = await FlutterSession().get('token');

  //   dynamic response = await http.get(
  //     Uri.parse(ApiEndpoints.pickupsOngoing),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   return parsePickups(response.body);
  // }

  // List<Address> parseAddress(String reponseAddress) {
  //   final parsed = jsonDecode(reponseAddress).cast<Map<String, dynamic>>();
  //   return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  // }
  // Future<List<Pickup>> fetchPhotos() async {
  //   dynamic token = await FlutterSession().get('token');
  //   final response = await http.get(
  //     Uri.parse(ApiEndpoints.pickupsOngoing),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   return parsePickups(response.body);
  // }
}
