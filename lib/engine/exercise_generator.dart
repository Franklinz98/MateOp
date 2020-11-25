import 'dart:convert';
import 'dart:math';

import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/constants/enums.dart';

import '../models/exercise.dart';
import '../models/saved_exercise.dart';
import '../models/intensities.dart';
import 'dart:io' as io;

Random _random = Random();
List<Exercise> generateExercisesFromPerformance(Intensity myPerformance,
    int numberOfExercises, String path, OperationType operationType) {
  List<Exercise> myExercises = List<Exercise>();

  int chosenLO = 0;
  int totalEx = 0;
  double comparator = -1;
  List<int> numberPerLo = List<int>();
  for (var i = 0; i < myPerformance.getNumberOfLo(); i++) {
    int numberExercPerLo =
        (numberOfExercises * myPerformance.loIntensities['LOIN$i']).toInt();
    numberPerLo.add(numberExercPerLo);
    totalEx = totalEx + numberExercPerLo;
    if (comparator < myPerformance.loIntensities['LOIN$i']) {
      comparator = myPerformance.loIntensities['LOIN$i'];
      chosenLO = i;
    }
  }

  if (numberOfExercises > totalEx) {
    numberPerLo[chosenLO] =
        numberPerLo[chosenLO] + (numberOfExercises - totalEx).abs();
  } else if (numberOfExercises < totalEx) {
    numberPerLo[chosenLO] =
        numberPerLo[chosenLO] - (numberOfExercises - totalEx).abs();
  }

  for (var i = 0; i < myPerformance.getNumberOfLo(); i++) {
    int numberOfDF =
        (numberPerLo[i] * myPerformance.loIntensities["LOINDF$i"]).toInt();
    int numberOfDD =
        (numberPerLo[i] * myPerformance.loIntensities["LOINDD$i"]).toInt();
    if (numberOfDD + numberOfDF != numberPerLo[i]) {
      if (myPerformance.loIntensities["LOINDF$i"] >
          myPerformance.loIntensities["LOINDD$i"]) {
        numberOfDF =
            numberOfDF + (numberOfDD + numberOfDF - numberPerLo[i]).abs();
      } else {
        numberOfDD =
            numberOfDD + (numberOfDD + numberOfDF - numberPerLo[i]).abs();
      }
    }

    List<Exercise> myExerciseslo = _generateExercisePerLearningObj(
        numberOfDF, i, 0, operationType, path, myExercises);
    for (Exercise ex in myExerciseslo) {
      myExercises.add(ex);
    }
    myExerciseslo = _generateExercisePerLearningObj(
        numberOfDD, i, 1, operationType, path, myExercises);
    for (Exercise ex in myExerciseslo) {
      myExercises.add(ex);
    }
  }
  String filename = "WrongExercises";
  io.File file = getLocalFile(path, filename);
  if (file.existsSync()) {
    file.deleteSync();
  }
  return myExercises;
}

bool _canBeAddedToList(List<int> list, int newNum, int comparator) {
  int count = 0;
  for (int a in list) {
    if (a == newNum) {
      count++;
    }
  }
  if (count >= comparator) {
    return false;
  }
  return true;
}

List<Exercise> _generateExercisePerLearningObj(
    int numberExerc,
    int learningObjective,
    int dificulty,
    OperationType opType,
    String path,
    List<Exercise> currentList) {
  List<Exercise> myExercises = List<Exercise>();
  List<int> choosenNumbersSum1 = List<int>();
  List<int> choosenNumbersSum2 = List<int>();
  int lO = learningObjective;
  switch (opType) {
    case OperationType.addition:
      lO += 0;
      break;
    case OperationType.subtraction:
      lO += 9;
      break;
    case OperationType.multiplication:
      break;
  }
  myExercises =
      _getPastExercisesFromFile(numberExerc, 'LOIN$lO', dificulty, path);
  numberExerc = numberExerc - myExercises.length;
  int diff = dificulty;
  for (var i = 0; i < numberExerc; i++) {
    int operator1 = 0, operator2 = 0;
    switch (lO) {
      case 0:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(9) + 1;
            operator2 = _random.nextInt(9) + 1;
          } while (operator1 + operator2 < 10 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 3) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 3) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(8) + 1;
            operator2 = _random.nextInt(9 - operator1) + 1;
          } while ((operator1 + operator2) >= 10 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 3) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 3) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 1:
        operator2 = 10;
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(5) + 5;
          } while ((operator1 + operator2) <= 15 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2));
        } else {
          do {
            operator1 = _random.nextInt(5) + 1;
          } while ((operator1 + operator2) > 15 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2));
        }
        break;
      case 2:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(9) + 1;
            operator2 = _random.nextInt(89) + 10;
          } while (operator1 + operator2 >= 100 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(89) + 10;
            operator2 = _random.nextInt(9) + 1;
          } while (operator1 + operator2 >= 100 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 3:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(9) + 1;
            operator2 = _random.nextInt(9) + 91;
          } while (operator1 + operator2 < 100 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(9) + 91;
            operator2 = _random.nextInt(9) + 1;
          } while (operator1 + operator2 < 100 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 4:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(90) + 10;
            operator2 = _random.nextInt(90) + 10;
          } while (operator1 + operator2 < 100 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(80) + 10;
            operator2 = _random.nextInt(90 - operator1) + 10;
          } while (operator1 + operator2 >= 100 ||
              !_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 9:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(9) + 1;
            operator1 = operator1.isOdd ? operator1 : operator1 - 1;
            operator2 = _random.nextInt(9) + 1;
            operator2 = operator2.isOdd ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 4) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 4) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(7) + 2;
            operator1 = operator1.isEven ? operator1 : operator1 - 1;
            operator2 = _random.nextInt(7) + 2;
            operator2 = operator2.isEven ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 4) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 4) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 10:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(9) + 1;
            operator1 = operator1.isOdd ? operator1 : operator1 - 1;
            operator2 = _random.nextInt(7) + 2;
            operator2 = operator2.isEven ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(7) + 2;
            operator1 = operator1.isEven ? operator1 : operator1 - 1;
            operator2 = _random.nextInt(9) + 1;
            operator2 = operator2.isOdd ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 11:
        operator1 = 10;
        int attemps = 0;
        if (diff == 1) {
          do {
            operator2 = _random.nextInt(9) + 1;
            if (i >= (numberExerc ~/ 2) && attemps == 10) {
              operator2 = operator2.isEven ? operator2 : operator2 - 1;
              diff = 0;
            } else {
              operator2 = operator2.isOdd ? operator2 : operator2 - 1;
              attemps++;
            }
            operator2 = operator2.isOdd ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator2 = _random.nextInt(7) + 2;
            if (i >= (numberExerc ~/ 2) && attemps == 10) {
              operator2 = operator2.isOdd ? operator2 : operator2 - 1;
              diff = 1;
            } else {
              operator2 = operator2.isEven ? operator2 : operator2 - 1;
              attemps++;
            }
          } while (!_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 12:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(90) + 10;
            operator2 = _random.nextInt(7) + 2;
            operator2 = operator2.isOdd ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(90) + 10;
            operator2 = _random.nextInt(7) + 2;
            operator2 = operator2.isEven ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
      case 13:
        operator2 = 10;
        do {
          operator1 = _random.nextInt(90) + 10;
        } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
            !_exerciseAlreadyExits(
                myExercises, currentList, operator1, operator2));
        break;
      case 14:
        if (diff == 1) {
          do {
            operator1 = _random.nextInt(90) + 10;
            operator2 = _random.nextInt(89) + 11;
            operator2 = operator2.isEven ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        } else {
          do {
            operator1 = _random.nextInt(90) + 10;
            operator2 = _random.nextInt(89) + 10;
            operator2 = operator2.isEven ? operator2 : operator2 - 1;
          } while (!_canBeAddedToList(choosenNumbersSum1, operator1, 2) ||
              !_canBeAddedToList(choosenNumbersSum2, operator2, 2) ||
              !_exerciseAlreadyExits(
                  myExercises, currentList, operator1, operator2));
        }
        break;
    }
    choosenNumbersSum1.add(operator1);
    choosenNumbersSum2.add(operator2);
    Exercise oneExc = Exercise(
      learningObj: lO,
      firstOperator: operator1.toDouble(),
      secondOperator: operator2.toDouble(),
      answer:
          calculateAnswer(operator1.toDouble(), operator2.toDouble(), opType),
      operation: opType,
    );
    oneExc.dificulty = diff;
    myExercises.add(oneExc);
  }
  return myExercises;
}

List<Exercise> _getPastExercisesFromFile(
    int numberExerc, String loIDString, int dificulty, String path) {
  List<Exercise> myExercises = List<Exercise>();
  String filename = "WrongExercises";
  io.File file = getLocalFile(path, filename);
  try {
    if (file.existsSync()) {
      String content = file.readAsStringSync();
      List savedExercises = jsonDecode(content);
      List tempSavedExercises = List();
      savedExercises.forEach((savedExerciseMap) {
        SavedExercise savedExercise = SavedExercise.fromJson(savedExerciseMap);
        if (savedExercise.intensity == loIDString &&
            savedExercise.dificulty == dificulty &&
            myExercises.length < numberExerc) {
          Exercise previewExercise = savedExercise.exercise;
          myExercises.add(previewExercise);
        } else {
          tempSavedExercises.add(savedExercise.toJson());
        }
      });
      file.writeAsStringSync(jsonEncode(tempSavedExercises),
          mode: io.FileMode.write);
    }
  } catch (e) {
    print(e.toString());
  }
  return myExercises;
}

void saveWrongExercisesOnFile(Exercise myWrongExercise, String path) {
  String filename = "WrongExercises";
  io.File file = getLocalFile(path, filename);
  int dificulty = myWrongExercise.dificulty;
  SavedExercise savedExercise = SavedExercise(
      "LOIN${myWrongExercise.learningObj}", dificulty, myWrongExercise);
  try {
    List savedExercises = [];
    if (file.existsSync()) {
      String read = file.readAsStringSync();
      savedExercises = jsonDecode(read);
    }
    savedExercises.add(savedExercise.toJson());
    file.writeAsStringSync(jsonEncode(savedExercises), mode: io.FileMode.write);
  } catch (e) {
    print(e.toString());
  }
}

bool _exerciseAlreadyExits(
    List<Exercise> currents, List<Exercise> currentList, int a, int b) {
  for (Exercise exercise in currents) {
    if (exercise.firstOperator == a && exercise.secondOperator == b) {
      return false;
    }
  }
  for (Exercise exercise in currentList) {
    if (exercise.firstOperator == a && exercise.secondOperator == b) {
      return false;
    }
  }
  return true;
}

double calculateAnswer(
    double firstOperator, double secondOperator, OperationType type) {
  double answer;
  switch (type) {
    case OperationType.addition:
      answer = firstOperator + secondOperator;
      break;
    case OperationType.subtraction:
      answer = firstOperator - secondOperator;
      break;
    case OperationType.multiplication:
      answer = firstOperator * secondOperator;
      break;
  }
  return answer;
}

List<double> generateAnswerOptions(double answer) {
  int delta = (answer * _random.nextDouble()).round();
  if (delta == 0) {
    delta = 1;
  }
  double extraOption1 = answer - delta;
  double extraOption2 = answer + delta;
  List<double> allOptions = [answer, extraOption1, extraOption2];
  allOptions.shuffle();
  return allOptions;
}
