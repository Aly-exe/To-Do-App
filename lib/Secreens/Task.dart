import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Cubit/State.dart';
import 'package:to_do_app/Cubit/cubit.dart';
class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,CounterStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        List tasks =cubit.Newtasks;
        return ListView.separated(
            itemBuilder: (context, index) => Dismissible(
              key: Key(tasks[index]['id'].toString()),
              onDismissed: (direction){
                  AppCubit.get(context).deletedata(id: tasks[index]['id']);
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      child: Text("${tasks[index]['time']}"),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${tasks[index]['name']}",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${tasks[index]['date']}",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                )
              ],
                      ),
                    ),
                    IconButton(onPressed: (){
                      AppCubit.get(context).updatedata(Statue: "done", id:tasks[index]['id'] );
                    }, icon: Icon(Icons.done_all_outlined,size: 35.0,),color: Colors.green,),
                    IconButton(onPressed: (){
                      AppCubit.get(context).updatedata(Statue: "archived", id:tasks[index]['id'] );
                    }, icon: Icon(Icons.archive_outlined ,size: 30,),color: Colors.black38,),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
            itemCount: tasks.length);
      },
    );
  }
}

  
