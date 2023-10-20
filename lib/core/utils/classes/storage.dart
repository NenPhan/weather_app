// ignore_for_file: constant_identifier_names, non_constant_identifier_names, unused_element

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

const _current_location = '/current_location';
const _saved_locations = '/saved_location';
const _temp_unit = '/temp_unit';

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

  saveLocation(String city, String country) {
    preferences?.setString(_current_location, city);
    var savedLocations = preferences?.getStringList(_saved_locations) ?? [];
    if (savedLocations.length == 10) {
      savedLocations.removeAt(0);
    }
    if (!savedLocations.contains('$country, $city')) {
      savedLocations.add('$country, $city');
    }
    preferences?.setStringList(_saved_locations, savedLocations);
  }

  getCurrentLocation() {
    return preferences?.getString(_current_location);
  }

  List<String> getSavedLocations() {
    return preferences?.getStringList(_saved_locations) ?? [];
  }

  initUnit() {
    var val = preferences?.getBool(_temp_unit);
    if (val == null) preferences?.setBool(_temp_unit, true);
  }

  changeUnit() {
    var val = preferences?.getBool(_temp_unit) ?? true;
    preferences?.setBool(_temp_unit, !val);
  }

  isCelsius() {
    return preferences?.getBool(_temp_unit);
  }
}
