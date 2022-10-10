import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tables_repository/src/model/table_model.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addTableModel(TableModel tableModelData, String id) async {
    await _db.collection("Classes").doc(id).set(tableModelData.toJson());
  }

  updateTableModel(TableModel tableModelData, String id) async {
    await _db.collection("Classes").doc(id).update(tableModelData.toJson());
  }

  Future<TableModel> getCurrentTableModel(String id) async {
    var snapshot = (await _db.collection("Classes").doc(id));

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

  Future<List<TableModel>> retrieveEmployees() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Classes").get();
    return snapshot.docs
        .map((docSnapshot) => TableModel.fromJson(docSnapshot.data()))
        .toList();
  }

  Future<bool> AlreadyExists(String id) async {
    try {
      final snapshot = await _db.collection("Classes").doc(id).get();
      //log(await snapshot.data().toString());
      log(id);
      log('снапшот прошел');
      //snapshot.then((value) => value.data() != null)
      return await snapshot.data() == null;
    } catch (e) {
      log(e.toString());
      log('ошибка при создании');
      return true;
    }
  }
}