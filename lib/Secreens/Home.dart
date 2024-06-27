// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/Cubit/State.dart';
import 'package:to_do_app/Cubit/cubit.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
    @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context ) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, CounterStates>(
        listener: (context, state) {
          if(state is AppInsertIntoDatabase){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          
      AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            //App Bar 
            appBar: AppBar(
              title: Text("${cubit.title[cubit.currentindex]}")
            ),
            body:cubit.screens[cubit.currentindex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isbottomsheetshowed) {
                  if (formkey.currentState!.validate()) {
                    cubit.Insertdata(
                            title: titlecontroller.text,
                            date: datecontroller.text,
                            time: timecontroller.text)
                        .then((value) {
                      cubit.ChangeFAB( isshowed:false,icon: Icons.edit);
                    });
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet((context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: titlecontroller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title must be not empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "Title",
                                      hintText: 'add title',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.title),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: timecontroller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Time must be not empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    scribbleEnabled: false,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) => timecontroller.text =
                                          value!.format(context).toString());
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      labelText: "Task Time",
                                      hintText: 'add time',
                                      border: OutlineInputBorder(),
                                      prefixIcon:
                                          Icon(Icons.watch_later_outlined),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: datecontroller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Date must be not empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    scribbleEnabled: false,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse("2030-01-01"))
                                          .then((value) => datecontroller.text =
                                              DateFormat.yMMMEd()
                                                  .format(value!));
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      labelText: "Task Date",
                                      hintText: 'add date',
                                      border: OutlineInputBorder(),
                                      prefixIcon:
                                          Icon(Icons.calendar_month_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.ChangeFAB( isshowed:false,icon: Icons.edit);
                  });
                  cubit.ChangeFAB( isshowed:true,icon: Icons.add);
                }
              },
              child: Icon(cubit.fabicon),
            ),
            //NAVBAR
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.ChangeIndex(index);
                },
                elevation: 10.0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Task',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done_all_outlined),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archive',
                  ),
                ]),
          );
        },
      ),
    );
  }


}
