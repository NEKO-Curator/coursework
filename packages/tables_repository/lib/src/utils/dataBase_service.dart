import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tables_repository/src/model/table_model.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addTableModel(TableModel tableModelData) async {
    await _db.collection("Classes").add(tableModelData.toJson());
  }

  updateTableModel(TableModel tableModelData, String id) async {
    await _db.collection("Classes").doc(id).update(tableModelData.toJson());
  }

  Future<TableModel> getCurrentTableModel(String docID) async {
    var snapshot = (await _db.collection("Classes").doc(docID));

    //log('cleared table');
    return snapshot.get().then(
      (DocumentSnapshot value) {
        TableModel tableModel =
            TableModel.fromJson(value.data() as Map<String, dynamic>);
        return tableModel;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> deleteTableModel(String documentId) async {
    await _db.collection("Classes").doc(documentId).delete();
  }

  //https://stackoverflow.com/questions/62968486/how-do-i-get-documentid-of-a-firestore-document-in-flutter
  Future<List<TableModel>>? retrieveEmployees() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Classes").get();
    return snapshot.docs.map((docSnapshot) {
      var tm = TableModel.fromJson(docSnapshot.data());
      tm.id = docSnapshot.id;
      return tm;
    }).toList();
  }
}
