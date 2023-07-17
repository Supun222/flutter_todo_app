import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TodosList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = TodosList;
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 30, 
                          bottom: 20),
                        child: Text(
                          'All Todos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),  
                      ),
                      for ( Todo todo in _foundTodo.reversed) 
                        TodoItem(
                          todo: todo,
                          onTodoChange: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        )
                    ],
                  ),
                )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: 
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0
                        ),],
                        borderRadius: BorderRadius.circular(10)
                      ) ,
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration (
                          hintText: 'add new todo item',
                          border: InputBorder.none
                        ),
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize:  40,),),
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      elevation: 10,
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }

void _handleTodoChange(Todo todo) { 
  setState(() {
    todo.isDone = !todo.isDone;
  });

}

void _deleteTodoItem(String id) {
  setState(() {
    TodosList.removeWhere((item) => item.id == id);
  });
}

void _addTodoItem(String itemName) {
  setState(() {
    TodosList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), TodoText: itemName));
  });
  _todoController.clear();
}

void _runFilter(String enteredKeyword) {
  List<Todo> results = [];
  if(enteredKeyword.isEmpty) {
    results = TodosList;
  }
  else {
    results = TodosList
      .where((item) => item.TodoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
      .toList();
  }

  setState(() {
    _foundTodo = results;
  });
}

Widget searchBox() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20)
    ),
    child: TextField( 
      onChanged: (value) => _runFilter(value),
      decoration: const InputDecoration(
        contentPadding:  EdgeInsets.all(0),
        prefixIcon:  Icon(
          Icons.search,
          color: tdBlack,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 20,
          minWidth: 25
        ),
        border: InputBorder.none,
        hintText: 'search here',
        hintStyle: TextStyle(
          color: tdGrey
        ) 
      ),
    ),
  );
}

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.png'),
            ),
          )
        ]
      ),
    );
  }
}