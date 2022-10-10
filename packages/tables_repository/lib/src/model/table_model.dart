class TableModel {
  String? name;
  List<Students>? students;
  TableModel({this.name, this.students});

  TableModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
}

TableModel getClearTableModel() {
  Students fake_student =
      new Students(studentName: '', endScore: '', scores: getFilledScore(17));
  return new TableModel(
      name: '', students: getFilledStudents(40, fake_student));
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
