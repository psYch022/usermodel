import 'package:flutter/material.dart';
import 'package:thaartransport/services/services.dart';

class googleService extends Service {
  String kPLACES_API_KEY = "AIzaSyDOVWB_rmq0sd-RpqDuIrsyP4XrRBgzmXY";
  String type = '(cities)';
  String language = "en";
  String components = "country:in";

  String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
}
