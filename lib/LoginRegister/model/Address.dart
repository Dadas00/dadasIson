import 'package:flutter/cupertino.dart';

class Address {
  String streetName;
  String bdg;
  String apt;
  String floor;
  String entry;
  String comment;
  String latitude;

  String longitude;
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

  bool isExpanded = false;
  Map toMap() {
    return {
      'streetName': streetName ?? '',
      'bdg': bdg,
      'apt': apt ?? '',
      'floor': floor ?? '',
      'entry': entry ?? '',
      'comment': comment ?? '',
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'placeId': placeId ?? '',
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetName: json['streetName'] as String,
      bdg: json['bdg'] as String,
      apt: json['apt'] as String,
      floor: json['floor'] as String,
      entry: json['entry'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      placeId: json['placeId'] as String,
      id: json['id'] as int,
    );
  }
}
