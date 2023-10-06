
import 'package:to_do_list/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/model/todo.dart';


class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteitem;

  const ToDoItem({Key key, this.todo, this.onToDoChange, this.onDeleteitem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //one to do 
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          onTap: () {
            //print('taptap');
            onToDoChange(todo);
          },
          //check icon
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
          title: Text(todo.todoText ,style: TextStyle(fontSize: 16, color: tdBlack,
          decoration: todo.isDone? TextDecoration.lineThrough : null,
            ),
          ),
          //delete icon inside container
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35, width: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                //print('Delete');
                onDeleteitem(todo.id);
              },
            ),
          ),
      ),
      ), 
          
    );
  }
  
}