import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Components/constants.dart';
import 'package:to_do_app/Secreens/Home.dart';


void main(){
  Bloc.observer = const SimpleBlocObserver();
  return runApp(HomeScreen());
} 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To Do App With Sqflite and Cubit",
      home: Home(),
    );
  }
}