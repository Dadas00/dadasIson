import 'package:flutter/cupertino.dart';

class Address {
  @required
  String streetName;
  @required
  String bdg;
  String apt;
  String floor;
  String entry;
  String comment;
  @required
  double latitude;
  @required
  double longitude;
  String placeId;
  int id;

  Address(
      {this.streetName,
      this.bdg,
      this.latitude,
      this.longitude,
      this.apt,
      this.floor,
      this.entry,
      this.comment,
      this.placeId,
      this.id});

  Map toMap() {
    return {
      'streetName': streetName,
      'bdg': bdg,
      'apt': apt ?? '',
      'floor': floor ?? '',
      'entry': entry ?? '',
      'comment': comment ?? '',
      'latitude': latitude,
      'longitude': longitude,
      'placeId': placeId ?? '',
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    //TODO: - address key from json
    return Address(
        streetName: json['order_date'],
        bdg: json['order_start_time'],
        apt: json['order_time_end'],
        floor: json['order_time_end'],
        entry: json['order_time_end'],
        longitude: json['id'],
        latitude: json['id'],
        placeId: json['id'],
        id: json['id']);
  }
}
