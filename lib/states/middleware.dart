import 'package:rx_app/database_provider/db_provider.dart';
import 'package:rx_app/models/models.dart';

class DbHelper{
  List<STGBook> bookCategories;
 void getBooks() async{
    bookCategories = await DbProvider.getSTGCategories();
  }
  List<STGBook> get categories=>bookCategories;
}