import 'dart:async';
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/globals.dart';

enum AddressAction { Ongoing, Passed, Cancel }

class AddressBloc {
  int counter;
  final _stateStreamController = StreamController<List<Address>>();
  StreamSink<List<Address>> get _addressSink => _stateStreamController.sink;
  Stream<List<Address>> get addressStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();
  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get _eventStream => _eventStreamController.stream;

  AddressBloc() {
    _eventStream.listen((event) async {
      try {
        String url;
        if (event == ApiEndpoints.addressAdd) {
          url = ApiEndpoints.pickupsOngoing;
        } else if (event == ApiEndpoints.pickupsPassed) {
          url = ApiEndpoints.pickupsPassed;
        }
        var pickups = await _fetchAddresses(url);
        if (pickups != null)
          _addressSink.add(pickups);
        else
          _addressSink.addError('Samthing went wrong');
      } on Exception catch (e) {
        _addressSink.addError('Samthing went wrong: $e');
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  void _mapLoginSubmittedToState(Map userMap) async {
    try {
      dynamic token = await FlutterSession().get('token');

      final response = await http.post(
        ApiEndpoints.addressAdd,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(userMap),
      );
      print(response.body);
      var body = jsonDecode(response.body);
      // var data = body['data'];

      if (body['status'] == 1) {
      } else {}
    } catch (error) {
      print(error);
    }
  }

  Future<List<Address>> _fetchAddresses(String url) async {
    dynamic token = await FlutterSession().get('token');
    List<Address> addresses = [];

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      var body = jsonDecode(response.body);

      if (body['status'] == 1) {
        dynamic data = body['data'];
        data.forEach((element) {
          Address address = Address.fromJson(element);
          addresses.add(address);
        });
        // pickups = List<Pickup>.from(data.map((e) => Pickup.fromJson(e)));
        return addresses;
      }
    } catch (e) {
      return null; //throw Exception('Failed to load album');
    }
    return addresses;
  }
}
