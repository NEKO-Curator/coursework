import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tables_repository/src/model/table_model.dart';
import 'package:tables_repository/src/utils/dataBase_service.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
late String? id;
late int? numOfStudents;
late int? weeks;
late List<Students> _students;
getDataFromDatabase(TableModel tableModel) async {
  // //заглушка, должно получать
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  // DBService dbService = DBService();
  // await _db
  //     .collection("Classes")
  //     .where("creatorId", isEqualTo: _firebaseAuth.currentUser!.uid.toString())
  //     .get();
  // return await dbService.getCurrentTableModel();
  return tableModel;
}

Future<void> exportDataGrid() async {
  DBService dbService = DBService();
  TableModel tm = TableModel(
      creatorId: FirebaseAuth.instance.currentUser!.uid, students: _students);
  log(id!);
  dbService.updateTableModel(tm, id!);
  //log(_students[1].toString());
}

class DetailTablePage extends StatefulWidget {
  final TableModel? tableModel;
  const DetailTablePage({super.key, this.tableModel});

  @override
  State<DetailTablePage> createState() =>
      _DetailTablePageState(tableModel: tableModel);
}

class _DetailTablePageState extends State<DetailTablePage> {
  TableModel? tableModel;
  _DetailTablePageState({this.tableModel});
  late StudentsDataSource _studentsDataSource;
  EditingGestureType editingGestureType = EditingGestureType.tap;
  //late List<GridColumn> _scoresGridColumns;
  @override
  initState() {
    //getDataFromDatabase();
    id = tableModel!.id!;
    _students = tableModel!.students!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(tableModel?.title ?? 'Неизвестный класс'),
        ),
        body: FutureBuilder(
            future: getDataFromDatabase(tableModel!),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                TableModel showData = snapshot.data;
                // Map<dynamic, dynamic> values = showData.value;
                // List<dynamic> key = values.keys.toList();
                _students = showData.getStudentsList()!;
                _studentsDataSource = StudentsDataSource(_students);
                return SfDataGrid(
                  frozenColumnsCount: 1,
                  allowEditing: true,
                  navigationMode: GridNavigationMode.cell,
                  selectionMode: SelectionMode.single,
                  editingGestureType: editingGestureType,
                  allowSorting: true,
                  source: _studentsDataSource,
                  columns: getGridColumnsWidgets(tableModel!),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

List<GridColumn> getGridColumnsWidgets(TableModel tableModel) {
  List<GridColumn> gColumnList = <GridColumn>[];
  gColumnList.add(
    GridColumn(
      columnName: 'name',
      minimumWidth: 130,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          'ФИО',
        ),
      ),
    ),
  );
  for (var i = 1; i < tableModel.getNumOfWeeks()! + 1; i++) {
    gColumnList.add(
      GridColumn(
        allowSorting: false,
        columnName: i.toString(),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            i.toString(),
          ),
        ),
      ),
    );
  }
  gColumnList.add(
    GridColumn(
      allowEditing: false,
      columnName: 'sum',
      label: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          'всего',
        ),
      ),
    ),
  );
  return gColumnList;
}

class StudentsDataSource extends DataGridSource {
  StudentsDataSource(List<Students> students) {
    dataGridRows = students
        .map<DataGridRow>(
          (dataGridRows) => DataGridRow(cells: getListForDG(dataGridRows)),
        )
        .toList();
  }

  List<DataGridCell<dynamic>> getListForDG(Students students) {
    List<DataGridCell<dynamic>> dGList = <DataGridCell<dynamic>>[];
    dGList.add(
      DataGridCell<String>(columnName: 'name', value: students.studentName),
    );
    for (var i = 0; i < students.scores!.length; i++) {
      dGList.add(
        DataGridCell<String>(
            columnName: (i + 1).toString(), value: students.scores?[i] ?? ''),
      );
    }
    dGList.add(
      DataGridCell<String>(
          columnName: 'sum', value: GetScoreSum(students.scores)),
    );
    return dGList;
  }

  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.clip,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
        );
      }).toList(),
    );
  }

  dynamic newCellValue;

  TextEditingController editingController = TextEditingController();
  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'name', value: newCellValue);
      _students[dataRowIndex].studentName = newCellValue.toString();
    } else if (column.columnName == 'sum') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'sum', value: newCellValue);
      _students[dataRowIndex].endScore = newCellValue.toString();
    } else {
      elifOnCellSubmit(dataRowIndex, rowColumnIndex, column);
    }
  }

  DataGridCell<String> getRowCells(String name) =>
      DataGridCell<String>(columnName: name, value: newCellValue);

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: TextInputType.text,
        onEditingComplete: () {
          exportDataGrid();
        },
        onChanged: (String value) {
          if (value.isNotEmpty) {
            newCellValue = value;
          } else {
            newCellValue = null;
          }
          exportDataGrid();
        },
        onSubmitted: (String value) {
          if (value.isNotEmpty) {
            newCellValue = value;
          } else {
            newCellValue = null;
          }

          submitCell();
          exportDataGrid();
        },
      ),
    );
  }

  void elifOnCellSubmit(
    int dataRowIndex,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
  ) {
    int i = 1;
    while (column.columnName != i.toString()) {
      i++;
    }
    dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
        DataGridCell<String>(columnName: i.toString(), value: newCellValue);
    _students[dataRowIndex].scores![i - 1] = newCellValue.toString();
  }
}

String GetScoreSum(List<String>? score) {
  double ans = 0;
  for (int i = 0; i < score!.length; i++) {
    if (double.tryParse(score[i]) != null) {
      //log('Значение {${score[i]}} число');
      ans += double.parse(score[i]);
    }
    // else
    //   log('Значение {${score[i]}} не число');
  }
  return ans.toString();
}
