import 'dart:io';
import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/film.dart';
import '../../widget/alert_dialog/awesome_alert.dart';
import '../../widget/buttons/red_elevation_button.dart';
import '../../widget/navigator/navigator.dart';
import '../../widget/responsive/responsive.dart';
import '../../widget/snack_bar/snack_bar_widget.dart';
import '../../widget/style_color.dart';
import '../../widget/text_form_fileds/text_form_field_name.dart';
import '../../widget/text_form_fileds/text_form_filed_money.dart';
import 'widget/container_widget.dart';

class EditfilmScreen extends StatefulWidget {
  const EditfilmScreen({
    Key? key,
    required this.id,
    required this.filmName,
    required this.filmPrice,
    required this.filmImage,
    required this.index,
  }) : super(key: key);
  final String id;
  final String filmName;
  final String filmPrice;
  final String filmImage;
  final int index;

  @override
  State<EditfilmScreen> createState() => _EditfilmScreenState();
}

class _EditfilmScreenState extends State<EditfilmScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.filmName;
    _priceController.text = widget.filmPrice;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
  Future<bool> _onWillPop() async {
    final filmProvider =
    Provider.of<FilmProvider>(context, listen: false);

    filmProvider.deleteImage();
    return navigatorPopWidget(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final filmProvider =
        Provider.of<FilmProvider>(context, listen: false);
    //
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Edit film',
          style: Responsive.isMobile(context)
              ? titleWhiteMobileStyle
              : titleWhiteMobileStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {


            navigatorPopWidget(context);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: height * 0.02),

                FadeInLeft(
                  child: Consumer<FilmProvider>(
                    builder: (context, filmP, child) => ContainerWidget(
                      widget: widget.filmImage == '0' &&
                              filmP.image == null
                          ? FadeInImage(
                              placeholder: const AssetImage('loading.gif'),
                              image: const AssetImage('no_image.png'),
                              height: width * 0.27,
                              width: width * 0.25,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              placeholderFit: BoxFit.contain,
                            ):

                           filmP.image != null &&
                                  widget.filmImage == '0'
                              ? Stack(
                                  children: [
                                    FadeInImage(
                                      placeholder:
                                          const AssetImage('loading.gif'),
                                      image: FileImage(filmP.showImage!),
                                      width: width,
                                      height: height,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      placeholderFit: BoxFit.contain,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: primaryColor,
                                      ),
                                      onPressed: () {
                                        filmP.deleteImage();
                                      },
                                    ),
                                  ],
                                )
                              : filmP.image == null
                                  ? FadeInImage(
                                    placeholder:
                                        const AssetImage('loading.gif'),
                                    image: FileImage(File(widget.filmImage)),
                                    height: width,
                                    width: width,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    placeholderFit: BoxFit.contain,
                                  )
                                  : Stack(
                                      children: [
                                        FadeInImage(
                                          placeholder:
                                              const AssetImage('loading.gif'),
                                          image: FileImage(filmP.showImage!),
                                          width: width,
                                          height: height,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          placeholderFit: BoxFit.contain,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: primaryColor,
                                          ),
                                          onPressed: () {
                                            filmP.deleteImage();
                                          },
                                        ),
                                      ],
                                    ),
                      callback: () {
                        filmP.pickImage();
                      },
                    ),
                  ),
                ),

                //name
                FadeInLeft(
                  child: TextFormFieldNameWidget(
                    textEditingController: _nameController,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    maxLength: 500,
                    minLine: 1,
                    maxLine: 1,
                    labelText: 'film name',
                    iconData: Icons.edit_outlined,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'film name is empty';
                      }
                      return null;
                    },
                  ),
                ),
                //film price
                FadeInLeft(
                  child: TextFormFieldMoneyWidget(
                    textEditingController: _priceController,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLength: 50,
                    minLine: 1,
                    maxLine: 1,
                    labelText: 'film price',
                    iconData: Icons.money_rounded,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'film price is empty';
                      }
                      return null;
                    },
                  ),
                ),

                ElevationButtonWidget(
                  text: 'Edit film',
                  onPress: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    var helperVar = filmProvider.item[widget.index];
                    var item = filmProvider.item
                        .firstWhere((element) => element.id == helperVar.id);

                    if (!_key.currentState!.validate()) {
                      alertDialogWarning(
                          context, 'Error', 'Input values are invalid');
                    } else {
                      _key.currentState!.save();
                      if (filmProvider.image != null) {
                        if (filmProvider.fileType != 'png' &&
                            filmProvider.fileType != 'jpg' &&
                            filmProvider.fileType != 'jpeg') {
                          alertDialogError(context, 'Error',
                              'The selected file format is incorrect');
                        } else {
                          if (double.parse(filmProvider.fileSize.toString()) >=
                              double.parse('10.00')) {
                            alertDialogError(context, 'Error',
                                'The selected image size is large');
                          } else {
                            filmProvider.updatefilmNameById(
                              helperVar.id,
                              _nameController.text,
                            );
                            item.filmName = _nameController.text;

                            filmProvider.updatePriceById(
                              helperVar.id,
                              _priceController.text.replaceAll(',', ''),
                            );
                            item.filmPrice =
                                _priceController.text.replaceAll(',', '');

                            //
                            if (filmProvider.showImage == null &&
                                widget.filmImage == '0') {
                              filmProvider.updatefilmImageById(
                                helperVar.id,
                                '0',
                              );
                              item.filmImage = '0';
                            } else {
                              filmProvider.updatefilmImageById(
                                helperVar.id,
                                filmProvider.showImage!.path,
                              );
                              print('object');
                              print(filmProvider.showImage!.path);
                              item.filmImage = filmProvider.showImage!.path;
                            }

                            snackBarSuccessWidget(context, 'Editing done');
                            _priceController.clear();
                            _nameController.clear();
                            //
                            filmProvider.deleteImage();
                            navigatorPopWidget(context);
                          }
                        }
                      }
                      //With out Image
                      //
                      //
                      //
                      //
                      //
                      else {
                        filmProvider.updatefilmNameById(
                          helperVar.id,
                          _nameController.text,
                        );
                        item.filmName = _nameController.text;

                        filmProvider.updatePriceById(
                          helperVar.id,
                          _priceController.text.replaceAll(',', ''),
                        );
                        item.filmPrice =
                            _priceController.text.replaceAll(',', '');
                        //

                        snackBarSuccessWidget(context, 'Editing done');
                        _priceController.clear();
                        _nameController.clear();
                        //
                        filmProvider.deleteImage();
                        navigatorPopWidget(context);
                      }
                    }
                  },
                  minSizeW: width * 0.5,
                ),
                SizedBox(height: height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
