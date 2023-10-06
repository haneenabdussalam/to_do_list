import 'package:to_do_list/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/model/todo.dart';
//model directory
class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    this.id,
    this.todoText,
    this.isDone =false,
  }); 
static List<ToDo> todoList() {
  return [
    ToDo(id: '01', todoText: 'Morning Exercises', isDone: true),
    ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
    ToDo(id: '03', todoText: 'Check Emails', ),
    ToDo(id: '04', todoText: 'Team Meeting', ),
    ToDo(id: '05', todoText: 'work on Mobile Apps for 2 hours', ),


  ];
}
}
