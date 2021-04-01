import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_apaga/globals.dart';

import 'PickupListItem.dart';
import 'package:smart_apaga/Home/Home/NoPickupItem.dart';
import 'package:smart_apaga/Home/Home/OrderBagsItem.dart';

// import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBloc.dart';

class PickupListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickupListManagerState();
  }
}

class _PickupListManagerState extends State<PickupListManager> {
  int groupedValue = 0;

  final Map<int, Widget> segmentedItemList = {
    0: Text('Ongoing', style: TextStyle(color: Colors.black)),
    1: Text('Passed', style: TextStyle(color: Colors.black))
  };

  List<Pickup> _pickups = [
    // Pickup(
    //   address: Address(
    //     apt: '',
    //     bdg: '',
    //     streetName: 'Abovyan',
    //     floor: '',
    //     comment: '',
    //     latitude: 1,
    //     longitude: 1,
    //     ),
    //   date: '21.10.20',
    //   timeBegin: '18:30',
    //   timeEnd: '19:30',
    //   waste: [],
    //   noteForDriver: '',
    //   bagCount: 1,
    // )
  ];

  final pickupBloc = PickupBloc();
  int purchasedBagCount = 10;
  bool isPassed = false;

  int _itemCount() {
    int count = _pickups.length == 0 ? _pickups.length + 1 : _pickups.length;
    return purchasedBagCount != 0 ? count + 1 : count;
  }

  void _changeSegmentedControl(int value) {
    if (value == 0) {
      pickupBloc.eventSink.add(ApiEndpoints.pickupsOngoing);
      // isPassed = false;
    } else {
      // isPassed = true;
      pickupBloc.eventSink.add(ApiEndpoints.pickupsPassed);
    }
  }

  @override
  void initState() {
    pickupBloc.eventSink.add(ApiEndpoints.pickupsOngoing);
    super.initState();
  }

  @override
  void dispose() {
    pickupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Pickup>>(
        stream: pickupBloc.pickupStream,
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.data != null) {
            _pickups = snapshot.data;
            isPassed = groupedValue == 0 ? false : true;
          }

          return Column(children: [
            //Segmented Control
            Container(
              width: 300,
              child: CupertinoSegmentedControl<int>(
                  borderColor: Colors.grey,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.grey,
                  children: segmentedItemList,
                  groupValue: groupedValue,
                  onValueChanged: (value) {
                    setState(() {
                      groupedValue = value;
                      _changeSegmentedControl(value);
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

                      if (_pickups.length != 0) {
                        int i = purchasedBagCount != 0 ? index - 1 : index;
                        return PickupListItem(_pickups[i], isPassed);
                      }

                      return NoPickupItem();
                    })),
          ]);
        });
  }
}
