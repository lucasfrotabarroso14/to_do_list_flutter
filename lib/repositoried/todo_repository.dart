import 'dart:convert';

import 'package:ecommerce_flutter/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const todoListkey = 'todo_list';

class TodoRepository {

  



  // TodoRepository(){
  //   SharedPreferences.getInstance().then((value) => {
  //     sharedPreferences = value,
      
  //   });
  // }

  late SharedPreferences sharedPreferences;

  Future <List> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //se ele nao encontrar retorna []
    final String jsonString = sharedPreferences.getString(todoListkey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => ToDo.fromJson(e)).toList(); 
  }

  void saveToDoList(List<ToDo> todos){
    final String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }


  


}