import 'package:ecommerce_flutter/models/todo.dart';
import 'package:ecommerce_flutter/repositoried/todo_repository.dart';
import 'package:ecommerce_flutter/widgets/to_do_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToDoListPage extends StatefulWidget {
  ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {



  final TodoRepository todoRepository =  TodoRepository();
  final TextEditingController todoController = TextEditingController();

  List<ToDo> todos = [];
  ToDo? deletedTodo;
  int? deletedTodoPos;
  String? errorText;


  @override
  void initState() {
    super.initState();
    // o gettodolist retorna uma lista com os dados que estavam guardados localmente
    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value.map((e) => e as ToDo).toList();
      });
    });
  }


  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea( // ESSE WIDGET SAFE AREA ELE NAO PERMITE QUE A TELA PASSE DA TELA E FIQUE ESTRANHO
      child: Scaffold(
        body: Center( 
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                               
                  children: [
                    Expanded(
                      flex:4,
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          labelText: 'Digite uma task',
                          errorText: errorText,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00d7f3)
                            )
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff00d7f3)
                          )
                        ),
                        
                        
                      ),
                    ),
                    SizedBox(width: 8,),
                    ElevatedButton(
                      onPressed:(){
                        String text = todoController.text;
                        if(text.isEmpty){
                          setState(() {
                            errorText = 'o titulo nao pode ser vazio!';
                          });
                          return;
                        }
                         errorText =null;
                        setState(() {
                          ToDo newTodo = ToDo(
                            title : text,
                            dateTime: DateTime.now()
                            
                          );
                          todos.add(newTodo);
                        });
                        todoController.clear();
                        todoRepository.saveToDoList(todos);
                        
                  
                      },
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14)
                        
                      ) ,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                       )
                    
                  ],
                ),
                SizedBox(height: 16,),
                Flexible(//flexible vai permitir  ela crescer ate o maximo e se passar ela vira rolavel
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (ToDo todo in todos)
                        ToDoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        )
                   
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Row(children: [
                  Expanded(
                    child: Text(
                      'Voce possui ${todos.length} tarefas pendentes')
                      ),
                  
                   ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog ,
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14)
                        
                      ) ,
                      child:
                       Text('Limpar tudo'),
                       
                        
                      ),
                       
                ],           
                )
              ],
                  
            ),
          ),
        ),
      ),
    );
    
  }


  void onDelete(ToDo todo){

    deletedTodo = todo;
    deletedTodoPos= todos.indexOf(todo); 

    setState(() {
      todos.remove(todo); 
    });
    todoRepository.saveToDoList(todos);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
         Text(
          'tarefa ${todo.title} foi removida com sucesso!', style: TextStyle(color:Color(0xff060708)),),
          backgroundColor: Colors.white ,
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: const Color(0xff00d7f3),
            onPressed: (){
              setState(() {
                todos.insert(deletedTodoPos!, deletedTodo!); //coloca de volta na lista na mesma posicao
              });
              todoRepository.saveToDoList(todos);
            },
            ),
            duration: const Duration(seconds: 5),
          )
    );
    
  }
  void deleteAllTodos(){
    setState(() {
      todos.clear();
    });
    todoRepository.saveToDoList(todos);
  }
  void showDeleteTodosConfirmationDialog(){
    showDialog(
    context: context,
     builder: (builder) => AlertDialog(
      title: Text('Limpar tudo?'),
      content: Text('Voce tem certeza que deseja apagar todas as tarefas?'),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff00d7f3),

          ),
          child: Text('Cancelar')
           ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
            deleteAllTodos();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            
          ),
          child: Text('Limpar tudo'))
      ],
     )
     ); 
  }

}

// passar widget 
// pai --> filho : passa por parametro
// filho --> pai : passa por funcao (callback)



//--------------------------------------

// import 'package:ecommerce_flutter/models/todo.dart';
// import 'package:ecommerce_flutter/widgets/to_do_list_item.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

// class ToDoListPage extends StatefulWidget {
  



//   const ToDoListPage({super.key});

//   @override
//   State<ToDoListPage> createState() => _ToDoListPageState();
// }

// class _ToDoListPageState extends State<ToDoListPage> {
  

//    List <ToDo> todos = []; 
//    final TextEditingController textController = TextEditingController();
 

  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
        
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
                  
                  
//                   children: [
//                   SizedBox(width: 20,),
//                   Expanded(
//                     flex: 2,
//                     child: TextField(
//                       controller: textController,
               
//                       decoration: InputDecoration(
//                         hintText: 'Digite uma Task'
//                       ),
                      
//                     ),
//                   ),
//                   SizedBox(width: 20,),
                  
//                   ElevatedButton(onPressed: (){
//                     setState(() {
//                       String text = textController.text;
//                       ToDo todo = ToDo(
//                         title: text,
//                         dateTime: DateTime.now()
//                         );
//                       todos.add(todo);
//                     });
//                   }, child: Text('+'))
                
                
//                 ],
//                 ),
//                 Flexible(
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       for( ToDo todo in todos)
//                         ToDoListItem(
//                           todo: todo,
//                           onDelete: onDelete,
//                         ),
//                         SizedBox(height: 20,),
//                         Row(children: [
                          
//                           Expanded(
                            
//                             child:                   
//                             Text('Voce possui ${todos.length} tarefas pendentes'),
                            
//                            ),
                           
//                            ElevatedButton(
//                             onPressed: showDeleteTodosConfirmationDialog,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.amber,
//                               padding: EdgeInsets.all(16)
//                             ),
//                             child: Text('Limpar tudo '))
//                         ],)
                  
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ),
//     );
//   }

//   void onDelete(ToDo todo){
//     setState(() {
//       showDeleteTodosConfirmationDialog();
 
//       todos.remove(todo);
//     });
//   }

//   void deleteAll(){
//     setState(() {
//       todos.clear();
//     });
//   }

//   void showDeleteTodosConfirmationDialog(){
//     showDialog(
//       context: context,
//       builder: (builder)=> AlertDialog(
//         title: Text('Limpar tudo?'),
//         content: Text('Voce tem certeza que deseja apagar todas as tarefas?'),
//         actions: [
//           TextButton(
//             onPressed: (){Navigator.of(context).pop();},
//              child:Text('Cancelar')),

//           TextButton(onPressed: (){
//             Navigator.of(context).pop();
//             deleteAll();
//           }, child: Text('Sim'))
//         ],

      
//       )
//       );

//   }




// }



// import 'package:ecommerce_flutter/models/todo.dart';
// import 'package:ecommerce_flutter/widgets/to_do_list_item.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ToDoListPage extends StatefulWidget {




//   const ToDoListPage({super.key});
  

//   @override
//   State<ToDoListPage> createState() => _ToDoListPageState();
// }

// class _ToDoListPageState extends State<ToDoListPage> {
//   final TextEditingController textController =TextEditingController();

//    List <ToDo> todos = [];
   
 

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//               Row(
              
//                 children: [
//                 Expanded(
//                   flex: 2,
//                   child: TextField(
//                     controller: textController,
//                     decoration: InputDecoration(
//                       hintText: "Digite uma task"
//                     ),
//                   ),
                  
//                 ),
//                 SizedBox(width: 20,),
//                 ElevatedButton(
//                   onPressed: (){
//                     setState(() {
//                       ToDo todo = ToDo(
//                         title: textController.text,
//                         dateTime: DateTime.now()
//                       );
//                       todos.add(todo);
                      
//                     });
//                     textController.clear();

//                   },
//                    child: Icon(Icons.add))
               
//               ],
//               ),
//               SizedBox(height: 20,),
//               Flexible(
//                 child: ListView(
//                   shrinkWrap: true,
//                   children: [
//                   for (ToDo todo in todos)
//                   // texto = textController.text,
//                   ToDoListItem(
//                     todo:todo,
//                     onDelete: onDelete,
//                     ),
                
//                   ],
                  
                
//                 ),
//               ),
//               Row(children: [
//                 Expanded(child: Text('voce possui ${todos.length} tarefas pendentes')),
               
                
//                 ElevatedButton(
//                 onPressed: (){}, 
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16),
//                   backgroundColor: Colors.amber
//                 ),
//                 child: Text(
//                   'Limpar tudo',
                  
//                 ))
//               ],)
              
             
//             ],),
//           ),
//         )
//       ),
      
//     );
    
    
//   }

//   void onDelete(ToDo todo){
//     setState(() {
//       todos.remove(todo);
//     });
//   }
  
  

  

  
// }
