import 'package:flutter/material.dart';
import 'restaurant_model.dart';
import 'detailPage.dart';

class Restaurant extends StatelessWidget {
  const Restaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: ListView.builder(
        itemCount: restaurantList.length,
        itemBuilder: (context, index) {
          final item = restaurantList[index];
          return Card(
            child: ListTile(
              leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: Image.asset(item.image, fit: BoxFit.cover),
                ), 
              // CircleAvatar(backgroundImage: AssetImage("${item.image}")),
              title: Text(item.title),
              trailing: Text("${item.rating}",),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => detailPage(restaurant: item,),),),
              contentPadding: EdgeInsets.all(10),
            ),
          );
        },
        )),
    );
  }
}

// class Restaurant extends StatelessWidget {
//   const Restaurant({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: restaurantList.length,
//           itemBuilder: (context, index) {
//             final item = restaurantList[index];
//             return Container(
//               child: Card(
//                 child: Row(
//                   children: [
//                     AspectRatio(aspectRatio: 1.0,
//                     child: image,),
//                     Column(
//                       children: [
//                         Text(item.title),
//                         Text("${item.rating}"),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },),
//       ),
//     );
//   }
// }