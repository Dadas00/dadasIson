import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBloc.dart';
import 'package:smart_apaga/globals.dart';

class PickupListItem extends StatelessWidget {
  final Pickup pickup;
  final bool isPassed;

  PickupListItem(this.pickup, this.isPassed);

  final _pickupBloc = PickupBloc();

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
    // TODO: implement build
    List<int> westCounts = westCounter(pickup.waste);
    int plasticCount = westCounts[0];
    int paperCount = westCounts[1];
    int glassCount = westCounts[2];
    int bagCount = pickup.bagCount;

    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage('assets/images/calendar.png')),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    pickup.date,
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image(image: AssetImage('assets/images/clock.png')),
                  Text(
                    pickup.timeBegin,
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('To'),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    pickup.timeEnd,
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          //Address
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      pickup.address.streetName,
                      style: TextStyle(backgroundColor: Colors.white),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),
          //waste type
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pickup Description',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image(image: AssetImage('assets/images/plastic1.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'x $plasticCount',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image(image: AssetImage('assets/images/paper1.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'x $paperCount',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image(image: AssetImage('assets/images/glass1.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'x $glassCount',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),
          //Bags
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bags',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 83,
                    ),
                    Image(image: AssetImage('assets/images/bag_icon.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'x $bagCount',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),

          isPassed
              ? SizedBox(
                  height: 0,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: screenSize.width * 0.3),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green)),
                        color: Colors.green[400],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Edi This Pickup",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.1),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: screenSize.width * 0.3),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red[800])),
                        onPressed: () {
                          _pickupBloc.eventSink
                              .add(ApiEndpoints.pickupCancel(pickup.id));
                        },
                        color: Colors.red[800],
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Cancel This Pickup",
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                  ],
                ),

          SizedBox(height: isPassed ? 5 : 20),
        ],
      ),
    );
  }
}
