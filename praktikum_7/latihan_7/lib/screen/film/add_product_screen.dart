import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../provider/film.dart';
import '../../widget/border.dart';
import '../../widget/text_form_fileds/text_form_field_name.dart';
import 'package:provider/provider.dart';
import '../../../widget/navigator/navigator.dart';
import '../../widget/alert_dialog/awesome_alert.dart';
import '../../widget/buttons/red_elevation_button.dart';
import '../../widget/responsive/responsive.dart';
import '../../widget/snack_bar/snack_bar_widget.dart';
import '../../widget/style_color.dart';
import '../../widget/text_form_fileds/text_form_filed_money.dart';
import 'widget/container_widget.dart';

class AddfilmScreen extends StatefulWidget {
  const AddfilmScreen({Key? key}) : super(key: key);

  @override
  State<AddfilmScreen> createState() => _AddfilmScreenState();
}

class _AddfilmScreenState extends State<AddfilmScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Add film',
            style: Responsive.isMobile(context)
                ? titleWhiteMobileStyle
                : titleWhiteTabletStyle,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              filmProvider.deleteImage();
              navigatorPopWidget(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                FadeInLeft(
                  child: Consumer<FilmProvider>(
                    builder: (context, value, child) {
                      return value.showImage == null
                          ? ContainerWidget(
                              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pick Image',
                                    style: Responsive.isMobile(context)
                                        ? bodyBlackMobileStyle
                                        : bodyBlackTabletStyle,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.02),
                                    child: Icon(
                                      Icons.image,
                                      size: width * 0.07,
                                    ),
                                  ),
                                ],
                              ),
                              callback: () {
                                filmProvider.pickImage();
                              },
                            )
                          : ContainerWidget(
                              widget: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: borderWidget(context),
                                    child: FadeInImage(
                                      placeholder:
                                          const AssetImage('loading.gif'),
                                      image: FileImage(value.showImage!),
                                      width: width,
                                      height: height,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      placeholderFit: BoxFit.contain,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      value.deleteImage();
                                    },
                                  ),
                                ],
                              ),
                              callback: () {
                                value.pickImage();
                              },
                            );
                    },
                  ),
                ),

                //film name
                FadeInLeft(
                  child: TextFormFieldNameWidget(
                    textEditingController: _nameController,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    maxLength: 500,
                    minLine: 1,
                    maxLine: 1,
                    labelText: 'film Name',
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
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    maxLength: 50,
                    minLine: 1,
                    maxLine: 1,
                    labelText: 'price film',
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
                  text: 'Add film',
                  onPress: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!_key.currentState!.validate()) {
                      alertDialogWarning(
                          context, 'Error', 'Problem with entered values');
                    } else {
                      if (filmProvider.fileSize != null &&
                          double.parse(filmProvider.fileSize.toString()) >=
                              double.parse('10.00')) {
                        alertDialogError(context, 'Error',
                            'The selected image size is large');
                      } else {
                        if (filmProvider.image != null &&
                            filmProvider.fileType != 'png' &&
                            filmProvider.fileType != 'jpg' &&
                            filmProvider.fileType != 'jpeg') {
                          alertDialogError(context, 'Error',
                              'The selected file format is incorrect');
                        } else {
                          await filmProvider.insertDatabase(
                            _nameController.text,
                            _priceController.text.replaceAll(',', ''),
                            filmProvider.showImage == null
                                ? '0'
                                : filmProvider.showImage!.path,
                          );
                          _priceController.clear();
                          _nameController.clear();
                          filmProvider.deleteImage();
                          snackBarSuccessWidget(context, 'film added');
                          navigatorPopWidget(context);
                        }
                      }
                    }
                  },
                  minSizeW: width * 0.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
