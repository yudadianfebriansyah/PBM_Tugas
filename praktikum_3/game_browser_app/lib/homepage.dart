import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'drawer.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  int _currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
      return Scaffold(    
        key: scaffoldKey,
        drawer: buildDrawer(),
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 0,
          leading: GestureDetector(
              onTap: () => scaffoldKey.currentState?.openDrawer(),
              child: Icon(
                Icons.menu, size: 100, 
              ),
          ),
          actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 150),
                child: GestureDetector(
                  onTap: () {},
                  child: Image.network('https://awsimages.detik.net.id/community/media/visual/2022/01/10/steam-pecahkan-rekor-baru-28-juta-gamer-aktif-secara-bersamaan_169.png?w=1200',
                    height: 100,),
                )
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.notifications_outlined, size: 100,
                  ),
                )
              ),
            ],
        ),
    
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Home', textScaleFactor: 4,),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image.network('https://media.suara.com/pictures/970x544/2022/02/24/32578-elden-ring.jpg',
                      ),
                      Center(child:
                      Container(
                        margin: const EdgeInsets.only(),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Elden Ring', textScaleFactor: 5,),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                              child: Text('Rp.599.000',textScaleFactor: 4,),
                              )
                          ],
                        ),
                        ),
                      )
                    ]
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image.network('https://img.esportsku.com/wp-content/uploads//2022/06/stray.jpg',),
                      Center(child:
                      Container(
                        margin: const EdgeInsets.only(),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Stray', textScaleFactor: 5,),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                              child: Text('Rp.119.000', textScaleFactor: 4,),
                              )
                          ],
                        ),
                        ),
                      )
                    ]
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image.network('https://www.rtvmaniak.pl/wp-content/uploads/rtvmaniak/2020/11/Cyberpunk.jpg',),
                      Center(child:
                      Container(
                        margin: const EdgeInsets.only(),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Cyberunk 2077', textScaleFactor: 5,),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                              child: Text('Rp.699.999', textScaleFactor: 4,),
                              )
                          ],
                        ),
                        ),
                      )
                    ]
                    ),
                  ),
                ],
            ),
        ),
      ),
    
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 100,
              selectedFontSize: 30,
              fixedColor: Colors.white,
              backgroundColor: Colors.grey[800],
              currentIndex: _currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                    color: Colors.white,),
                    label: 'home',
    
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.group_outlined,
                    color: Colors.white,),
                    label: 'Group',
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline_outlined,
                    color: Colors.white,),
                    label: 'Chat',
                    
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.shopify_rounded,
                    color: Colors.white,),
                    label: 'Shop',
                    ),
              ],
              onTap: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
              ),      
      );
  },
  );
    }
    }
      
      
