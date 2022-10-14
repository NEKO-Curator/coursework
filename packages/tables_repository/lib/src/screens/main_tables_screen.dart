import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tables_repository/src/model/table_model.dart';
import 'package:tables_repository/src/screens/detail_table_screen.dart';
import 'package:tables_repository/src/utils/dataBase_service.dart';

class MainTablesScreen extends StatefulWidget {
  const MainTablesScreen({super.key});

  @override
  State<MainTablesScreen> createState() => _MainTablesScreenState();
}

class _MainTablesScreenState extends State<MainTablesScreen> {
  TextEditingController tableModelTitleController = TextEditingController();
  TextEditingController tableModelStudentsController = TextEditingController();
  TextEditingController tableModelWeeksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<TableModel>>(
            future: DBService().retrieveEmployees(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<TableModel>? tableModel = snapshot.data;
              return Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Все классы",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Divider(
                    //   color: Colors.grey[600],
                    // ),
                    SizedBox(height: 20),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[800],
                      ),
                      shrinkWrap: true,
                      itemCount: tableModel!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(tableModel[index].id!),
                          background: Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                          onDismissed: (direction) async {
                            if (tableModel[index].creatorId ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              await DBService()
                                  .deleteTableModel(tableModel[index].id!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Вы не можете удалить чужой журнал!')));
                            }
                          },
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTablePage(
                                          tableModel: tableModel[index],
                                        )),
                              );
                            },
                            leading: Container(
                              padding: EdgeInsets.all(2),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: tableModel[index].creatorId ==
                                      FirebaseAuth
                                          .instance.currentUser!.uid //заменить
                                  ? Icon(
                                      Icons.edit,
                                      color: Colors.black54,
                                    )
                                  : Container(),
                            ),
                            title: Text(
                              tableModel[index].title ?? 'нулевое значение',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Text(
                        "Добавить журнал",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  children: [
                    Divider(),
                    TextFormField(
                      controller: tableModelTitleController,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "название",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: tableModelStudentsController,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "число студентов",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: tableModelWeeksController,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "число занятий",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: const TextStyle(color: Colors.black54),
                        ),
                        child: Text("Добавить"),
                        onPressed: () async {
                          if (tableModelTitleController.text.isNotEmpty &&
                              int.tryParse(tableModelStudentsController.text) !=
                                  null &&
                              int.tryParse(tableModelWeeksController.text) !=
                                  null) {
                            await DBService().addTableModel(getClearTableModel(
                                FirebaseAuth.instance.currentUser!.uid,
                                int.tryParse(tableModelWeeksController.text)!,
                                int.tryParse(
                                    tableModelStudentsController.text)!,
                                tableModelTitleController.text));
                            setState(() {
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
