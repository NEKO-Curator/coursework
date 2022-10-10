import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tables_repository/src/model/table_model.dart';
import 'package:tables_repository/src/utils/dataBase_service.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
late List<Students> _students;
getDataFromDatabase() async {
  DBService dbService = DBService();
  return await dbService
      .getCurrentTableModel(_firebaseAuth.currentUser!.uid.toString());
}

final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
Future<void> exportDataGrid() async {
  DBService dbService = DBService();
  // final TableModel document = _key.currentState!.e;
  // final List<int> bytes = document.save();
  // await helper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
  // document.dispose();
  TableModel tm = TableModel(name: '', students: _students);
  dbService.updateTableModel(tm, _firebaseAuth.currentUser!.uid.toString());
  log(_students[1].toString());
}

class DetailTablePage extends StatefulWidget {
  const DetailTablePage({super.key});

  @override
  State<DetailTablePage> createState() => _DetailTablePageState();
}

class _DetailTablePageState extends State<DetailTablePage> {
  late StudentsDataSource _studentsDataSource;
  EditingGestureType editingGestureType = EditingGestureType.tap;
  //late List<GridColumn> _scoresGridColumns;
  @override
  initState() {
    getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getDataFromDatabase(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                TableModel showData = snapshot.data;
                // Map<dynamic, dynamic> values = showData.value;
                // List<dynamic> key = values.keys.toList();
                _students = showData.getStudentsList()!;
                _studentsDataSource = StudentsDataSource(_students);
                return SfDataGrid(
                  frozenColumnsCount: 1,
                  frozenRowsCount: 1,
                  allowEditing: true,
                  navigationMode: GridNavigationMode.cell,
                  selectionMode: SelectionMode.single,
                  editingGestureType: editingGestureType,
                  allowSorting: true,
                  source: _studentsDataSource,
                  //controller: ,
                  columns: [
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
                    GridColumn(
                      columnName: '1',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '1',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '2',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '2',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '3',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '3',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '4',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '4',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '5',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '5',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '6',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '6',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '7',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '7',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '8',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '8',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '9',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '9',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '10',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '10',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '11',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '11',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '12',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '12',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '13',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '13',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '14',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '14',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '15',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '15',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '16',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '16',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '17',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          '17',
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'sum',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'всего',
                        ),
                      ),
                    ),
                  ],
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

class StudentsDataSource extends DataGridSource {
  StudentsDataSource(List<Students> students) {
    dataGridRows = students
        .map<DataGridRow>(
          (dataGridRows) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'name', value: dataGridRows.studentName),
            DataGridCell<String>(
                columnName: '1', value: dataGridRows.scores?[0] ?? ''),
            DataGridCell<String>(
                columnName: '2', value: dataGridRows.scores?[1] ?? ''),
            DataGridCell<String>(
                columnName: '3', value: dataGridRows.scores?[2] ?? ''),
            DataGridCell<String>(
                columnName: '4', value: dataGridRows.scores?[3] ?? ''),
            DataGridCell<String>(
                columnName: '5', value: dataGridRows.scores?[4] ?? ''),
            DataGridCell<String>(
                columnName: '6', value: dataGridRows.scores?[5] ?? ''),
            DataGridCell<String>(
                columnName: '7', value: dataGridRows.scores?[6] ?? ''),
            DataGridCell<String>(
                columnName: '8', value: dataGridRows.scores?[7] ?? ''),
            DataGridCell<String>(
                columnName: '9', value: dataGridRows.scores?[8] ?? ''),
            DataGridCell<String>(
                columnName: '10', value: dataGridRows.scores?[9] ?? ''),
            DataGridCell<String>(
                columnName: '11', value: dataGridRows.scores?[10] ?? ''),
            DataGridCell<String>(
                columnName: '12', value: dataGridRows.scores?[11] ?? ''),
            DataGridCell<String>(
                columnName: '13', value: dataGridRows.scores?[12] ?? ''),
            DataGridCell<String>(
                columnName: '14', value: dataGridRows.scores?[13] ?? ''),
            DataGridCell<String>(
                columnName: '15', value: dataGridRows.scores?[14] ?? ''),
            DataGridCell<String>(
                columnName: '16', value: dataGridRows.scores?[15] ?? ''),
            DataGridCell<String>(
                columnName: '17', value: dataGridRows.scores?[16] ?? ''),
            DataGridCell<String>(
                columnName: 'sum', value: GetScoreSum(dataGridRows.scores)),
          ]),
        )
        .toList();
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

  //EDIT TEXT 2 ovverides

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// DataGridCell on onCellSubmit method.
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
    } else if (column.columnName == '17') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '17', value: newCellValue);
      _students[dataRowIndex].scores![16] = newCellValue.toString();
    } else if (column.columnName == '1') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '1', value: newCellValue);
      _students[dataRowIndex].scores![0] = newCellValue.toString();
    } else if (column.columnName == '2') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '2', value: newCellValue);
      _students[dataRowIndex].scores![1] = newCellValue.toString();
    } else if (column.columnName == '3') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '3', value: newCellValue);
      _students[dataRowIndex].scores![2] = newCellValue.toString();
    } else if (column.columnName == '4') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '4', value: newCellValue);
      _students[dataRowIndex].scores![3] = newCellValue.toString();
    } else if (column.columnName == '5') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '5', value: newCellValue);
      _students[dataRowIndex].scores![4] = newCellValue.toString();
    } else if (column.columnName == '6') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '6', value: newCellValue);
      _students[dataRowIndex].scores![5] = newCellValue.toString();
    } else if (column.columnName == '7') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '7', value: newCellValue);
      _students[dataRowIndex].scores![6] = newCellValue.toString();
    } else if (column.columnName == '8') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '8', value: newCellValue);
      _students[dataRowIndex].scores![7] = newCellValue.toString();
    } else if (column.columnName == '9') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '9', value: newCellValue);
      _students[dataRowIndex].scores![8] = newCellValue.toString();
    } else if (column.columnName == '10') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '10', value: newCellValue);
      _students[dataRowIndex].scores![9] = newCellValue.toString();
    } else if (column.columnName == '11') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '11', value: newCellValue);
      _students[dataRowIndex].scores![10] = newCellValue.toString();
    } else if (column.columnName == '12') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '12', value: newCellValue);
      _students[dataRowIndex].scores![11] = newCellValue.toString();
    } else if (column.columnName == '13') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '13', value: newCellValue);
      _students[dataRowIndex].scores![12] = newCellValue.toString();
    } else if (column.columnName == '14') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '14', value: newCellValue);
      _students[dataRowIndex].scores![13] = newCellValue.toString();
    } else if (column.columnName == '15') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '15', value: newCellValue);
      _students[dataRowIndex].scores![14] = newCellValue.toString();
    } else if (column.columnName == '16') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: '16', value: newCellValue);
      _students[dataRowIndex].scores![15] = newCellValue.toString();
    } else if (column.columnName == 'sum') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'sum', value: newCellValue);
      _students[dataRowIndex].endScore = newCellValue.toString();
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
