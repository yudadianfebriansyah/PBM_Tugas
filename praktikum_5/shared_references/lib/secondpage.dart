import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_references/firstpage.dart';
import 'detail.dart';
import 'model.dart';


class Restaurant extends StatelessWidget {
  const Restaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Keluar'),
              onTap: () async{ final prefs = await SharedPreferences.getInstance();
                                    prefs.setBool('isLoggedIn',false);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const FirstPage())));},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),),
      appBar: AppBar(
        actions: <Widget>[
      IconButton(icon: Icon(Icons.call, color: Colors.white), onPressed: () {  },),
    ],
      ),
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
        ),
        ),
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