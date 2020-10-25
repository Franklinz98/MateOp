import 'dart:convert';

import 'package:mate_op/models/intensities.dart';
import 'package:mate_op/models/user.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'mate-op.herokuapp.com';

// Calculate next intensity level with the bayesian model
Future<Intensity> getNextIntensityLevel(Map map) async {
  Uri uri = Uri.https(baseUrl, 'nextIntensity');
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(map),
  );
  if (response.statusCode == 200) {
    return Intensity.fromJson(json.decode(response.body));
  }else{
    throw Exception('Error on request');
  }
}

// Calculate initial intensity level with the bayesian model using user metadata
Future<Intensity> predictInicitalIntensity(MOUser user) async {
  Uri uri = Uri.https(baseUrl, 'onNewPlayer');
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(user.toJsonPrediction()),
  );
  if (response.statusCode == 200) {
    return Intensity.fromJson(json.decode(response.body));
  }else{
    throw Exception('Error on request');
  }
}
