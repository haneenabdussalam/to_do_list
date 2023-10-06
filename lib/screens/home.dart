import 'package:flutter/material.dart';
import 'package:to_do_list/constants/colors.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/widgets/todo_item.dart';


class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  //we need to add a controller to add a new item
  final _todoController = TextEditingController();
  //creating list to search for the items
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    // TODO: implement initState
    //assign todolist to foundtodo, to use it as data 
    _foundToDo = todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(
                  children: <Widget>[
                    //identifying a new widget 
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only (top: 25,bottom:20),
                            child: Text(
                              'To Do List',
                            style: TextStyle (
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                           )
                          ),
                          //my widget items in another file called todo_item(stateless widget)
                          for(ToDo todo in _foundToDo)
                          ToDoItem(
                            todo: todo,
                            onToDoChange: _handleToDoChange,
                            onDeleteitem: _deleteToDoItem,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: 
                    Container(
                  margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow (color: Colors.grey,offset: Offset(0.0, 0.0), blurRadius: 10.0, spreadRadius: 0.0,),],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none,
                    ),
                  ),
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30, right: 20,top: 20),
                    child: 
                    RaisedButton(
                    onPressed: (){
                      _addToDoItem (_todoController.text);
                    },
                    shape: 
                    CircleBorder(),
                    //RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                    color: tdBlue,
                    child: Text('+', style: TextStyle(fontSize: 45,),),),
                  ),

                ],
              ),
              
            ),
          ],
        ),
    );
  }
  void _handleToDoChange(ToDo todo){
    setState(() {
       todo.isDone = !todo.isDone;
    });
   
  }
  //delete item using removeWhere function
  void _deleteToDoItem(String id){
    setState(() {
     todosList.removeWhere((item) => item.id == id); 
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo,));

    });
    // to delete the text field after adding new item
    _todoController.clear();
  }
  
void _runFilter(String enteredKeyword){
  List<ToDo> results = [];

  //if blank just show all the list
  if(enteredKeyword.isEmpty){
    results = todosList;
  }
  else {
    results = todosList
    .where((item) => item.todoText
    .toLowerCase()
    .contains(enteredKeyword.toLowerCase()))
    .toList();
  }
  setState(() {
    _foundToDo = results;
  });
}

Widget searchBox(){
  return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  //Appearance:
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), 
                  ),
                  //writing(content):
                 child: TextField(
                  onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                     // contentPadding: EdgeInsets.only(top: 13),
                      prefixIcon: Icon(Icons.search, color: tdBlack, size: 20,),
                      // to organize the written words according to the search icon, instead of using (content padding)
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      //to hide the blue line under the search container
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: tdGrey),
                    ),
                  ), 
                );
}
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu, color: tdBlack, size: 30),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/Capture.jpg'),
          ),
          /* not efficient method:
          Container(height: 50,width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/Capture.png'),
          ),
          ),*/
        ],
      ),
      );
  }
}