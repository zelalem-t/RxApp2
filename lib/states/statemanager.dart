import 'package:flutter/material.dart';
import 'package:rx_app/database_provider/db_provider.dart';

import '../models/models.dart';

class DbStateProvider with ChangeNotifier{
  List<STGBook> stgBook =[];

  DbStateProvider(){
    getSTG();
  }
  List<STGBook> get theBook=>stgBook;
  void getSTG() async{
    stgBook = await DbProvider.getSTGCategories();
    notifyListeners();
  }


}