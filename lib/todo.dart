import 'package:flutter/material.dart';
class Todo {

  String ? id;
  String? details;
  late bool isDone;


  Todo({required this.id, required this.details,this.isDone = false});

  static List<Todo> todolist(){
    return[

      Todo(id: "01", details: "Morning Excersize",isDone: true),
      Todo(id: "02", details: "Meditation",isDone: true),
      Todo(id: "03", details: "Shower",),
      Todo(id: "04", details: "Team Meeting",),
      Todo(id: "05", details: "Reading",),

    ];
  }
}