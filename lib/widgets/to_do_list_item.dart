

import 'dart:developer';

import 'package:ecommerce_flutter/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ToDoListItem extends StatelessWidget {

  final Function(ToDo) onDelete;

  final ToDo todo;

  const ToDoListItem({super.key, required this.todo, required this.onDelete});

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(child:
       Container(
        
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        
        padding: const EdgeInsets.all(16),
        
        
        child: Padding(
      
          padding: const EdgeInsets.all(8.0),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            
      
            Text(
              DateFormat('dd/MM/yyyy').format(todo.dateTime),
              style: TextStyle(
                fontSize: 12,
              ),
              ),
      
              Text(
              todo.title  ,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
              ),
            
          ],),
        ),
         ),
        actionExtentRatio: 0.25,
        actionPane: const SlidableBehindActionPane(),
        secondaryActions: [
      IconSlideAction(
        color:Colors.red,
        icon: Icons.delete,
        caption: 'Deletar',
        onTap: (){
          onDelete(todo);


        },
      ),
      
         ],
      
      
      
      ),
    );
  }
   
}


 


// ignore_for_file: sort_child_properties_last

// import 'package:ecommerce_flutter/models/todo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class ToDoListItem extends StatelessWidget {


//   final Function(ToDo) onDelete;
//   final ToDo todo ;

//   const ToDoListItem({super.key, required this.onDelete, required this.todo});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Slidable(
       
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.grey[200],
//           ),
          
//           child:
//            Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Text(
//                   todo.title,
//                   style: TextStyle(
//                     fontSize: 16
//                   ),
//                   ),
//                   Text(
//                     '12/11/2023',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600
//                     ),
//                     )
//                ],
//              ),
//            ), 
//            ),
//             actionPane: SlidableBehindActionPane(),
//         actionExtentRatio: 0.25,
//         secondaryActions: [
//       IconSlideAction(
//         color:Colors.red,
//         icon: Icons.delete,
//         caption: 'Deletar',
//         onTap: (){
//           onDelete(todo);
//         },
//         )
//         ],
//       ),
//     );
//   }
// }


// import 'package:ecommerce_flutter/models/todo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:intl/intl.dart';

// class ToDoListItem extends StatelessWidget {

//   final ToDo todo;
//   final Function(ToDo)onDelete;



//   const ToDoListItem({super.key, required this.todo, required this.onDelete });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: Slidable(
//           actionPane: const SlidableBehindActionPane(),
//                   secondaryActions: [
//       IconSlideAction(
//         color:Colors.red,
//         icon: Icons.delete,
//         caption: 'Deletar',
//          onTap: () => onDelete(todo),
//       ),
      
//          ],
//           child: Container(
          
            
//             decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(3)
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: Column(
                
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     todo.title,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     DateFormat('dd/MM/yyyy').format(todo.dateTime),
//                     style: TextStyle(
//                       fontSize: 12,
//                       ),
//                   )
                  
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


