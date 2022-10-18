import 'package:flutter/material.dart';

class buildDrawer extends StatefulWidget {
  const buildDrawer({super.key});

  @override
  State<buildDrawer> createState() => _buildDrawerState();
}

class _buildDrawerState extends State<buildDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 600,
      child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.account_circle_rounded, size: 80,),
                title: Text("Account", textScaleFactor: 5,),
                onTap: () {
                  // Change the applications state
                  print("Change page");
                  Navigator.pop(context);
                },
              ),
            ),
             Container(
              margin: const EdgeInsets.all(10),
               child: ListTile(
                leading: Icon(Icons.history,size: 80,),
                title: Text("History", textScaleFactor: 5,),
                onTap: () {
                  // Change the applications state
                  print("Change page");
                  Navigator.pop(context);
                },
            ),
             ),
             Container(
               child: ListTile(
                leading: Icon(Icons.gamepad_outlined,size: 80,),
                title: Text("Game List", textScaleFactor: 5,),
                onTap: () {
                  // Change the applications state
                  print("SIlahkan Pindah Halaman");
                  Navigator.pop(context);
                },
            ),
             ),
             Container(
              margin: const EdgeInsets.all(10),
               child: ListTile(
                leading: Icon(Icons.exit_to_app_outlined, size: 80,),
                title: Text("Exit", textScaleFactor: 5,),
                onTap: () {
                  // Change the applications state
                  print("Silahkan Pindah Halaman");
                  Navigator.pop(context);
                },
            ),
             ),
          ],
        ),
    );
  }
}