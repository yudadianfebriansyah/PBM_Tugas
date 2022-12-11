import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlte/screen/login.dart';
import '../../provider/film.dart';
import '../../widget/navigator/navigator.dart';
import 'package:provider/provider.dart';
import '../../../widget/border.dart';
import '../../../widget/buttons/small_white_elevation_button.dart';
import '../../widget/buttons/small_red_elevation_button.dart';
import '../../widget/dismiss_back_ground/delete_dismiss_container.dart';
import '../../widget/dismiss_back_ground/update_dismiss_container.dart';
import '../../widget/responsive/responsive.dart';
import '../../widget/snack_bar/snack_bar_widget.dart';
import '../../widget/style_color.dart';
import '../../widget/text_widget.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'image_screen.dart';

class ShowfilmScreen extends StatelessWidget {
  const ShowfilmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add film
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: primaryColor,
        onPressed: () {
          navigatorPushWidget(context, const AddfilmScreen());
        },
      ),
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
                color: primaryColor,
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
        title: Text(
          'films',
          style: Responsive.isMobile(context)
              ? titleWhiteMobileStyle
              : titleWhiteTabletStyle,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<FilmProvider>(context, listen: false)
            .selectfilms(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<FilmProvider>(
                child: Center(
                  child: Text(
                    'No films added',
                    textAlign: TextAlign.center,
                    style: Responsive.isMobile(context)
                        ? titleBigBlackMobileStyle
                        : titleBigBlackTabletStyle,
                  ),
                ),
                builder: (context, filmProvider, child) => filmProvider
                        .item.isEmpty
                    ? child!
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: filmProvider.item.length,
                        itemBuilder: (context, index) => Dismissible(
                          key: ValueKey(filmProvider.item[index].id),
                          child: MainBody(
                            filmProvider: filmProvider,
                            index: index,
                          ),
                          background: const DeleteDismiss(verticalMargin: 0.03),
                          secondaryBackground:
                              const EditDismiss(verticalMargin: 0.03),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              //delete
                              return showModalBottomSheet(
                                shape: bottomSheetborderWidget(context),
                                backgroundColor: backGroundColor,
                                context: context,
                                builder: (context) => DeletefilmBottomSheet(
                                  index: index,
                                  filmProvider: filmProvider,
                                ),
                              );
                            } else {
                              //edit film
                              var helperVar = filmProvider.item[index];
                              navigatorPushWidget(
                                context,
                                EditfilmScreen(
                                  id: helperVar.id,
                                  filmName: helperVar.filmName,
                                  filmPrice: helperVar.filmPrice,
                                  filmImage:helperVar.filmImage,
                                  index: index,
                                ),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}

class DeletefilmBottomSheet extends StatelessWidget {
  const DeletefilmBottomSheet({
    Key? key,
    required this.filmProvider,
    required this.index,
  }) : super(key: key);
  final FilmProvider filmProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var helper = filmProvider.item[index];
    return Container(
      width: width,
      height: height * 0.23,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Do you want to delete the ${helper.filmName}?',
            maxLines: 2,
            style: Responsive.isMobile(context)
                ? bodyBoldBlackMobileStyle
                : bodyBoldBlackTabletStyle,
          ),
          Row(
            children: [
              Expanded(
                child: SmallRedElevationButton(
                  text: 'Delete it',
                  onPress: () async {
                    filmProvider.deletefilmById(helper.id);
                    filmProvider.item.removeAt(index);
                    snackBarSuccessWidget(context, 'film removed');
                    navigatorPopWidget(context);
                  },
                ),
              ),
              Expanded(
                child: SmallWhiteElevationButton(
                  text: 'Return',
                  onPress: () {
                    navigatorPopWidget(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.filmProvider,
    required this.index,
  }) : super(key: key);
  final FilmProvider filmProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var helper = filmProvider.item[index];
    return Card(
      elevation: 3,
      shape: shapeWidget(context),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      shadowColor: shadowColor,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getBodyBoldText(context, 'film name: ', helper.filmName,),
                  SizedBox(height: height * 0.02),
                  getPriceText(context, 'Price: ', helper.filmPrice),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                helper.filmImage.toString() != '0'
                    ? ClipRRect(
                        borderRadius: borderWidget(context),
                        child: GestureDetector(
                          onTap: () {
                            navigatorPushWidget(
                              context,
                              ImageScreen(
                                image: File(helper.filmImage),
                                heroTag: 'flutterLogo$index',
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'flutterLogo$index',
                            child: FadeInImage(
                              placeholder: const AssetImage('loading.gif'),
                              image: FileImage(File(helper.filmImage)),
                              width: width * 0.25,
                              height: height * 0.17,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholderFit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Image.asset(
                        'no_image.png',
                        height: width * 0.27,
                        width: width * 0.2,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
