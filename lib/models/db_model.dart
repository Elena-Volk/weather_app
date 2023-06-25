
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';

import '../db/map.dart';

class DataBaseModel extends ChangeNotifier {

  final Store _store;
  List<dynamic> citiesList = [];
  String? searchString;



  DataBaseModel(this._store) {
    getCitiesList();
  }

  search(String search) {
    searchString = search;
    notifyListeners();
  }

   Future<List<dynamic>> getCitiesList() async {
    var response = await rootBundle.loadString('assets/cities/city_list.json');
    citiesList = await jsonDecode(response);
    notifyListeners();
    return citiesList;
  }

  List<dynamic> citiesListFunc(){
    if (searchString != null) {
      List<dynamic> newPointList = [];
      return citiesList.where((element) =>
          element['name'].contains(searchString)).toList();
      }

    return citiesList;

  }}