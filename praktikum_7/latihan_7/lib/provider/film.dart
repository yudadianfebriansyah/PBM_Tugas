import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../database/db_helper.dart';
import '../model/model.dart';


class FilmProvider extends ChangeNotifier {
  List<FilmModel> _item = [];

  List<FilmModel> get item => _item;

  Uint8List? bytes;

  String? fileType;
  ImagePicker? picker;
  String? fileSize;
  XFile? image;
  File? showImage;
  int? size;

  Future pickImage() async {
    picker = ImagePicker();
    image = await picker!.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      // maxHeight: ,
      // maxWidth: ,
    );
    showImage = File(image!.path);
    bytes = showImage!.readAsBytesSync();
    size = showImage!.readAsBytesSync().lengthInBytes;
    final kb = size! / 1024;
    final mb = kb / 1024;
    fileSize = mb.toString().substring(0, 4);
    fileType = image!.name.toString().split('.').last;
    print('image!.path=${image!.path}');
    print('fileName=$fileType');
    print('image!.mb=$mb');
    print('image!.kb=$kb');
    notifyListeners();
  }

  Future deleteImage() async {
    image = null;
    showImage = null;
    notifyListeners();
  }

  //database
  Future insertDatabase(
    String filmName,
    String filmPrice,
    String filmImage,
  ) async {
    final newfilm = FilmModel(
      id: const Uuid().v1(),
      filmName: filmName,
      filmPrice: filmPrice,
      filmImage: filmImage,
    );
    _item.add(newfilm);

  await  DBHelper.insert(DBHelper.film, {
      'id': newfilm.id,
      'filmName': newfilm.filmName,
      'filmPrice': newfilm.filmPrice,
      'filmImage': newfilm.filmImage,
    });

  deleteImage();
    notifyListeners();
  }

// show items
  Future<void> selectfilms() async {
    final dataList = await DBHelper.selectfilm();
    _item = dataList
        .map((item) => FilmModel(
              id: item['id'],
              filmName: item['filmName'],
              filmPrice: item['filmPrice'],
              filmImage: item['filmImage'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> deletefilmById(pickId) async {
    await DBHelper.deleteById(DBHelper.film, 'id', pickId);
    print('delete_film');
    notifyListeners();
  }

  Future deleteTable() async {
    await DBHelper.deleteTable(DBHelper.film);
    print('table delete');
    notifyListeners();
  }

  Future<void> updatefilmNameById(id, String filmName) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.film,
      {'filmName': filmName},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> updatePriceById(id, String filmPrice) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.film,
      {'filmPrice': filmPrice},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> updatefilmImageById(id, filmImage) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.film,
      {'filmImage': filmImage},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }

}
