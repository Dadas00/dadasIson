import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';

class Pickup {
  List<Address> address;
  String date;
  String timeBegin;
  String timeEnd;
  List<Waste> waste;
  String noteForDriver;
  int bagCount;
  int id;

  Pickup({
    this.address,
    this.date,
    this.timeBegin,
    this.timeEnd,
    this.waste,
    this.noteForDriver,
    this.bagCount,
    this.id,
  });

  Map toMap() {
    Map wasteMap = {};
    // Map addressMap = {};
    // address.forEach((element) {
    //   addressMap.addAll(element.toMap());
    // });
    waste.forEach((element) {
      wasteMap.addAll(element.toMap());
    });

    return {
      'address': address ?? 1,
      'date': date,
      'timeBegin': timeBegin,
      'timeEnd': timeEnd,
      'waste': wasteMap,
      'noteForDriver': noteForDriver,
      'bagCount': bagCount,
    };
  }

  factory Pickup.fromJson(Map<String, dynamic> json) {
    List<Waste> waste = [];
    dynamic jsonWaste = json['pickup_bag'];
    jsonWaste.forEach((element) {
      dynamic bagCode = element['bag_code'];
      dynamic type = element['waste_type'];
      Waste ws = Waste(bagCode: bagCode, type: type);
      waste.add(ws);
    });

    return Pickup(
        address: json['address'],
        date: json['order_date'],
        timeBegin: json['order_start_time'],
        timeEnd: json['order_time_end'],
        waste: waste,
        noteForDriver: json['order_time_end'],
        bagCount: json['id'],
        id: json['id']);
  }
}
