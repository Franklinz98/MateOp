import 'dart:convert';

import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/models/intensities.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'mateop.herokuapp.com';

// Calculate next intensity level with the bayesian model
Future<Intensity> getNextIntensityLevel(Map map) async {
  map = PerformanceVectors.firebaseToJson(map);
  var uri = Uri.https(baseUrl, '/model/nextIntensity');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(map),
  );
  if (response.statusCode == 200) {
    var updatedPerformance = json.decode(response.body);
    var intensity = Intensity.fromJson(updatedPerformance['Intensities']);
    PerformanceVectors currentPerformanceVectors =
        PerformanceVectors.fromJson(map);
    currentPerformanceVectors.setBinLoPerformanceVectors(
        updatedPerformance['binLO0'],
        updatedPerformance['binLO1'],
        updatedPerformance['binLO2'],
        updatedPerformance['binLO3'],
        updatedPerformance['binLO4']);
    currentPerformanceVectors
        .setBinperPerformanceVectors(updatedPerformance['binPer']);
    currentPerformanceVectors.setMulLoformanceVectors(
        updatedPerformance['mulLO0'],
        updatedPerformance['mulLO1'],
        updatedPerformance['mulLO2'],
        updatedPerformance['mulLO3'],
        updatedPerformance['mulLO4']);
    currentPerformanceVectors
        .setMulPerPerformanceVectors(updatedPerformance['mulPer']);
    currentPerformanceVectors.setIntensities(intensity.toJson);
    await currentPerformanceVectors.writeObjectInFile(await localPath);
    return intensity;
  } else {
    throw Exception('Error on request');
  }
}

// Calculate initial intensity level with the bayesian model using user metadata
Future<Intensity> predictInicitalIntensity(MOUser user) async {
  var uri = Uri.https(baseUrl, '/model/predict');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(user.toJsonPrediction()),
  );
  if (response.statusCode == 200) {
    var intensity = Intensity.fromJson(json.decode(response.body));
    return intensity;
  } else {
    throw Exception('Error on request');
  }
}

Future<List> getLeaderboard(String score) async {
  var queryParameters = {
    'score': score,
  };
  var uri = Uri.https(baseUrl, '/data/leaderboard', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    List leaderboard = json.decode(response.body);
    return leaderboard;
  } else {
    return [];
  }
}
