import 'package:firebase_auth/firebase_auth.dart';

class MOUser {
  User firebaseData;
  int age, schoolType, gender, grade, session;
  bool hasPerformanceData;

  MOUser(this.age, this.schoolType, this.gender, this.grade,
      this.hasPerformanceData);

  Map<String, dynamic> toJsonPrediction() => {
        'edad': this.age,
        'tipoEscuela': this.schoolType,
        'genero': this.gender,
        'grado': this.grade,
      };

  Map<String, dynamic> toJson() => {
        'age': this.age,
        'schoolType': this.schoolType,
        'gender': this.gender,
        'grade': this.grade,
      };

  factory MOUser.fromJson(Map<String, dynamic> map) {
    return MOUser(map['age'], map['schoolType'], map['gender'], map['grade'],
        map['hasPerformanceData']);
  }
}
