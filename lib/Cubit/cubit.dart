import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Cubit/State.dart';
import 'package:to_do_app/Secreens/Archive.dart';
import 'package:to_do_app/Secreens/Done.dart';
import 'package:to_do_app/Secreens/Task.dart';

class AppCubit extends Cubit<CounterStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;
  bool isbottomsheetshowed = false;
  IconData fabicon = Icons.edit;
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivetasks = [];
  List screens = [
    Task(),
    Done(),
    Archive(),
  ];
  List title = [
    "Tasks",
    "Done",
    "Archive",
  ];
  int currentindex = 0;
  void ChangeIndex(index) {
    currentindex = index;
    emit(ChangeNavbarIndex());
  }

  void ChangeFAB({
    required bool? isshowed,
    required IconData? icon,
  }) {
    isbottomsheetshowed = isshowed!;
    fabicon = icon!;
    emit(ChangeFloatingActionButton());
  }

  void CreateDatabase() {
    openDatabase('New.db', version: 1, onCreate: (database, vesrion) async {
      print('database created');

      database
          .execute(
              'CREATE TABLE TASK(id INTEGER PRIMARY KEY, name TEXT,date TEXT, time Text ,state TEXT)')
          .then((value) {
        print("TASK table is created ");
      }).catchError((error) {
        print("That is an error : ${error.toString()}");
      });
    }, onOpen: (database) {
      print("database opend");
      GetDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  Insertdata(
      {required String title,
      required String date,
      required String time}) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              "INSERT INTO TASK(name,date,time,state)VALUES('$title','$date','$time','New')")
          .then((value) {
        print('$value is inserted into database');
        emit(AppInsertIntoDatabase());
        GetDataFromDatabase(database);
      }).catchError((error) {
        print("Failed to insert data ${error.toString()}");
      });
    });
  }

  void GetDataFromDatabase(database) {
    database.rawQuery('SELECT * FROM TASK').then((value) {
      Newtasks=[];
      Donetasks=[];
      Archivetasks=[];
      value.forEach((element) {
        if(element['state']=="New"){
          Newtasks.add(element);
        }else if (element['state']=="done"){
          Donetasks.add(element);
        }else{
          Archivetasks.add(element);
        }
      });
      emit(AppGetDataFromDatabase());
    });
  }

  void updatedata({required String Statue ,required int id}) {
    database!.rawUpdate('UPDATE TASK SET state = ? WHERE id = ?',['$Statue', id]).then((value) {
          GetDataFromDatabase(database);
          emit(UpdateDatabase());
        });
        
  }
  void deletedata({required int id}) {
    database!.rawDelete('DELETE FROM TASK WHERE id = ?',[id]).then((value) {
          GetDataFromDatabase(database);
          emit(DeleteFromDatabase());
        });
        
  }
}
