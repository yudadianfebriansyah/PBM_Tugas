import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, 
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: new Center(child: new Text("App Mengubah Nama Asli"),),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.50,
            child: Column(
              children: [
                Visibility(
                  child:Text(
                    "Yuda Dian Febriansyah",
                    style: GoogleFonts.caveat(
                      color: Colors.yellow,
                      fontSize: 48,
                    )
                    ),
                  visible: isVisible,
                  replacement: Text(
                    "ODON",
                    style: GoogleFonts.fredokaOne(
                        color: Colors.yellow,
                        fontSize: 48,),
                )),
                Switch(
                    value: switchValue,
                    onChanged: (value) {
                      switchValue = value;
                      isVisible = !isVisible;
                      setState(() {

                      });
                    },
                ),
              ],
            )
        ),
    ));
  }
}