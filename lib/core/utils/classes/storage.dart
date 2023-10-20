// ignore_for_file: constant_identifier_names, non_constant_identifier_names, unused_element

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

const _current_location = '/current_location';
const _saved_locations = '/saved_location';

class Storage {
  static Storage? _instance;
  Storage._(this.preferences);
  SharedPreferences? preferences;

  factory Storage() {
    if (_instance == null) {
      log('Storage needs init');
    }
    return _instance!;
  }

  static Future init() async {
    if (_instance != null) {
      throw 'Storage had inited';
    }
    _instance = Storage._(await SharedPreferences.getInstance());
    return;
  }

  getInstance() {
    return _instance;
  }

  Future<void> deleteAll() async {
    preferences?.remove(_current_location);
    preferences?.remove(_saved_locations);
  }

  saveLocation(String location) {
    preferences?.setString(_current_location, location);
  }

  getCurrentLocation() {
    return preferences?.getString(_current_location);
  }
}
