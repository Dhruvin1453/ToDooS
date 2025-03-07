import 'package:flutter/material.dart';
import 'package:todoo/todo.dart';
class TodoItem extends StatelessWidget{

  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onToggle;
  const TodoItem({required this.todo,required this.onDelete,required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20,left: 10,right: 10),
      child: Card(
        elevation: 5,
        child: ListTile(
          onTap: onToggle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        
          tileColor: Colors.white,
          leading: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,color: Colors.lightBlueAccent,),
          title: Text(todo.details!,style: TextStyle(fontSize:20,fontWeight:FontWeight.w500),),
          trailing: IconButton(icon: Icon(Icons.delete),color:Colors.red,onPressed: onDelete,),
        ),
      ),
    );
  }

}


