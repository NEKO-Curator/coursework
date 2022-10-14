import 'dart:developer';

class TableModel {
  String? id;

  String? title;
  String? creatorId;
  List<Students>? students;
  TableModel({this.creatorId, this.students, this.title, this.id});

  TableModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    creatorId = json['creatorId'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['creatorId'] = this.creatorId;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return students.toString();
  }

  List<Students>? getStudentsList() {
    return students;
  }

  int getNumOfStudents() {
    return students!.length;
  }

  int? getNumOfWeeks() {
    try {
      return students![0].scores!.length;
    } catch (e) {}
    return null;
  }
}

class Students {
  String? studentName;
  List<String>? scores;
  String? endScore;

  Students({this.studentName, this.scores, this.endScore});

  Students.fromJson(Map<String, dynamic> json) {
    studentName = json['studentName'];
    scores = json['scores'].cast<String>();
    endScore = json['endScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentName'] = this.studentName;
    data['scores'] = this.scores;
    data['endScore'] = this.endScore;
    return data;
  }

  @override
  String toString() {
    return '[${studentName.toString()}]';
  }

  int getNumOfWeeks() {
    return scores!.length;
  }
}

TableModel getClearTableModel(
    String cId, int weeks, int numOfStudents, String newTitle) {
  Students fake_student = new Students(
      studentName: '', endScore: '', scores: getFilledScore(weeks));
  return new TableModel(
      creatorId: cId,
      students: getFilledStudents(numOfStudents, fake_student),
      title: newTitle);
}

List<String> getFilledScore(int elements) {
  final List<String> array = [];
  for (var i = 0; i < elements; i++) {
    array.add('');
  }
  return array;
}

List<Students> getFilledStudents(int elements, Students fakeStudents) {
  List<Students> array = [];
  for (var i = 0; i < elements; i++) {
    array.add(fakeStudents);
  }
  return array;
}
