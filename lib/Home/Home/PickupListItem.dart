import 'package:flutter/material.dart';
import 'package:smart_apaga/Home/Home/PickupListManager.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBlocWithEnum.dart';
import 'package:smart_apaga/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PickupListItem extends StatelessWidget {
  final Pickup pickup;
  final bool isPassed;

  PickupListItem(
    this.pickup,
    this.isPassed,
  );
  PickupListManagerState pickupListManagerState = PickupListManagerState();

  final _pickupBloc = PickupBlocs();

  // ignore: missing_return
  List<int> westCounter(List<Waste> wastes) {
    var counts = [0, 0, 0];
    wastes.forEach((element) {
      switch (element.type) {
        case 'plastic':
          {
            counts[0] += 1;
          }
          break;
        case 'paper':
          {
            counts[1] += 1;
          }
          break;
        case 'glass':
          {
            counts[2] += 1;
          }
          break;
      }
    });
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    //List<int> westCounts = westCounter(pickup.waste);
    // int plasticCount = westCounts[0];
    // int paperCount = westCounts[1];
    // int glassCount = westCounts[2];
    // int bagCount = pickup.bagCount;

    var screenSize = MediaQuery.of(context).size;
  }

  // Widget _addressList() {
  //   return FutureBuilder(
  //       future: pickupListManagerState.getAddressLIst(),
  //       builder: (context, snapshot) {
  //         List<Widget> children;
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: Text(
  //               'Empty',
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           );
  //         } else if (snapshot.hasData) {
  //           return Text(snapshot.data.toString());
  //         }
  //         return Row(
  //           children: children,
  //         );
  //       });
  // }
}
