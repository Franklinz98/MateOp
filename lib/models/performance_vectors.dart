import 'dart:convert';
import 'dart:io';

import 'package:mate_op/backend/data.dart';
import 'package:mate_op/models/exercise.dart';

class PerformanceVectors {
  List<int> learningObjectives;
  int grado;
  int sesion;
  int tipoEscuela;
  List<double> tiempos;
  List<int> correcto;
  List<int> dificultad;
  List<int> titubeo;

  List<List<double>> binLO0;
  List<List<double>> binLO1;
  List<List<double>> binLO2;
  List<List<double>> binLO3;
  List<List<double>> binLO4;
  List<List<double>> binPer;
  List<List<double>> mulLO0;
  List<List<double>> mulLO1;
  List<List<double>> mulLO2;
  List<List<double>> mulLO3;
  List<List<double>> mulLO4;
  List<List<double>> mulPer;
  String jsonIntensities;
  int numLO;
  PerformanceVectors() {
    binLO0 = List();
    binLO1 = List();
    binLO2 = List();
    binLO3 = List();
    binLO4 = List();
    binPer = List();
    mulLO0 = List();
    mulLO1 = List();
    mulLO2 = List();
    mulLO3 = List();
    mulLO4 = List();
    mulPer = List();
    for (var i = 0; i < 5; i++) {
      binPer[i] = List();
      mulPer[i] = List();
    }
  }

  updatePerformanceVectorsSet(List<Exercise> exercises, int grado, int sesion) {
    learningObjectives = List(exercises.length);
    tiempos = List(exercises.length);
    correcto = List(exercises.length);
    dificultad = List(exercises.length);
    titubeo = List(exercises.length);
    this.grado = grado;
    this.sesion = sesion;
    int i = 0;
    exercises.forEach((exercise) {
      learningObjectives[i] = exercise.loID;
      tiempos[i] = exercise.duration.inSeconds as double;
      dificultad[i] = exercise.dificulty;
      titubeo[i] = exercise.hesitations;

      if (exercise.answer == exercise.playerAnswer) {
        correcto[i] = 1;
      } else {
        correcto[i] = 0;
      }
      i++;
    });
  }

  String getJsonfromMatrix(List<List<double>> matrix) {
    List<String> myjson = List();
    matrix.forEach((element) {
      myjson.add(json.encode(element));
    });
    return json.encode(myjson);
  }

  List<List<double>> getMatrixfromJson(String jsonRead) {
    List<String> jsonList = json.decode(jsonRead);
    List<List<double>> myjson = List();
    jsonList.forEach((element) {
      myjson.add(json.decode(element));
    });
    return myjson;
  }

  setBinloPerformanceVectors(
      List<List<double>> binLO0,
      List<List<double>> binLO1,
      List<List<double>> binLO2,
      List<List<double>> binLO3,
      List<List<double>> binLO4) {
    this.binLO0 = binLO0;
    this.binLO1 = binLO1;
    this.binLO2 = binLO2;
    this.binLO3 = binLO3;
    this.binLO4 = binLO4;
  }

  setBinperPerformanceVectors(List<double> binLO0, List<double> binLO1,
      List<double> binLO2, List<double> binLO3, List<double> binLO4) {
    this.binPer[0] = binLO0;
    this.binPer[1] = binLO1;
    this.binPer[2] = binLO2;
    this.binPer[3] = binLO3;
    this.binPer[4] = binLO4;
  }

  setMulPerformanceVectors(
      List<List<double>> mulLO0,
      List<List<double>> mulLO1,
      List<List<double>> mulLO2,
      List<List<double>> mulLO3,
      List<List<double>> mulLO4) {
    this.mulLO0 = mulLO0;
    this.mulLO1 = mulLO1;
    this.mulLO2 = mulLO2;
    this.mulLO3 = mulLO3;
    this.mulLO4 = mulLO4;
  }

  Map toJson() {
    return {
      "binLO0": getJsonfromMatrix(this.binLO0),
      "binLO1": getJsonfromMatrix(this.binLO1),
      "binLO2": getJsonfromMatrix(this.binLO2),
      "binLO3": getJsonfromMatrix(this.binLO3),
      "binLO4": getJsonfromMatrix(this.binLO4),
      "binPer": getJsonfromMatrix(this.binPer),
      "mulLO0": getJsonfromMatrix(this.mulLO0),
      "mulLO1": getJsonfromMatrix(this.mulLO1),
      "mulLO2": getJsonfromMatrix(this.mulLO2),
      "mulLO3": getJsonfromMatrix(this.mulLO3),
      "mulLO4": getJsonfromMatrix(this.mulLO4),
      "mulPer": getJsonfromMatrix(this.mulPer),
      "Intensities": this.jsonIntensities,
      "numLO": 5,
    };
  }

  writeObjectInFile(String path) {
    Map performanceVectorMap = this.toJson();
    File('$path/PerformanceVectors.json')
        .writeAsStringSync(json.encode(performanceVectorMap));
  }

  factory PerformanceVectors.readObjectFromFile(String path) {
    File file = File('$path/PerformanceVectors.json');
    if (file.existsSync()) {
      Map performanceVectorMap = json.decode(file.readAsStringSync());
      PerformanceVectors myPerformanceVector = PerformanceVectors();
      myPerformanceVector.binLO0 = performanceVectorMap["binLO0"];
      myPerformanceVector.binLO1 = performanceVectorMap["binLO1"];
      myPerformanceVector.binLO2 = performanceVectorMap["binLO2"];
      myPerformanceVector.binLO3 = performanceVectorMap["binLO3"];
      myPerformanceVector.binLO4 = performanceVectorMap["binLO4"];
      myPerformanceVector.binPer = performanceVectorMap["binPer"];
      myPerformanceVector.mulLO0 = performanceVectorMap["mulLO0"];
      myPerformanceVector.mulLO1 = performanceVectorMap["mulLO1"];
      myPerformanceVector.mulLO2 = performanceVectorMap["mulLO2"];
      myPerformanceVector.mulLO3 = performanceVectorMap["mulLO3"];
      myPerformanceVector.mulLO4 = performanceVectorMap["mulLO4"];
      myPerformanceVector.mulPer = performanceVectorMap["mulPer"];
      myPerformanceVector.jsonIntensities = performanceVectorMap["Intensities"];
      myPerformanceVector.numLO = 5;
      return myPerformanceVector;
    } else {
      return null;
    }
  }

  getIntensitiesOfJson(Map performanceVectorsMap) {
    return performanceVectorsMap['Intensities'];
  }
}
