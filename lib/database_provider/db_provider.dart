import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';


class DbProvider{
  static DbProvider _dbProvider;
  static Database stgDb;

  DbProvider._createInstance(); //named instance

  factory DbProvider(){
    if(_dbProvider ==null){
      _dbProvider = DbProvider._createInstance();
    }
    return _dbProvider;
  }

  static Future<Database> get dataBase async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    return stgDb;
  }


  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    var joinedPath = join(dbPath, "RxApp.db");
    await deleteDatabase(joinedPath);
    var exists = await databaseExists(joinedPath);
    //if(!exists){
      try{
        await Directory(dirname(joinedPath)).create(recursive: true);
      }catch(_){}
      ByteData dbData = await rootBundle.load(join("assets", "RxApp.db"));
      List<int> bytes = dbData.buffer.asUint8List(dbData.offsetInBytes, dbData.lengthInBytes);
      await File(joinedPath).writeAsBytes(bytes,flush:true);
  //}else{
    //print("Opening existing Db
    //}
    return await openDatabase(joinedPath,readOnly: true);
  }


  static Future<List<STGBook>> getLastSTGTopic(int parentId) async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    final List<Map<String, dynamic>> lastTopicsMap = await stgDb.query("thirdSub", where:"secondSubid = ?", whereArgs:[parentId]);

    return List.generate(lastTopicsMap.length,(index) {
      return STGBook(
          lastTopicsMap[index]['thirdSubId'],
          lastTopicsMap[index]['thirdSubTitle'],
          detail:lastTopicsMap[index]['thirdSubDetail'],
          parentId:lastTopicsMap[index]['secondSubid'],

      );
    }
    );
  }


  static Future<List<STGBook>> getSTGSecondSubTopic(int parentId) async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    final List<Map<String, dynamic>> lastTopicsMap = await stgDb.query("secondSub", where:"subId = ?", whereArgs:[parentId]);

    return List.generate(lastTopicsMap.length,(index) {
      STGBook secondSub =  STGBook(
        lastTopicsMap[index]['subsubID'],
        lastTopicsMap[index]['subsubTitle'],
        detail:lastTopicsMap[index]['subsubDetail'],
        hasSub: lastTopicsMap[index]["hasSub"],
        parentId:lastTopicsMap[index]['subId'],
      );
      secondSub.setChildren(getLastSTGTopic( lastTopicsMap[index]['subsubID']));

      return secondSub;
    }
    );
  }

  static Future<List<STGBook>> getSTGSubTopic(int parentId) async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    final List<Map<String, dynamic>> subTopicsMap = await stgDb.query("subs", where:"chapterID = ?", whereArgs:[parentId]);

    return List.generate(subTopicsMap.length,(index) {
      STGBook subs =  STGBook(
        subTopicsMap[index]['subID'],
        subTopicsMap[index]['subTitle'],
        detail:subTopicsMap[index]['subDetail'],
        hasSub: subTopicsMap[index]["hassub"],
        parentId:subTopicsMap[index]['chapterID'],
      );
      subs.setChildren(getSTGSecondSubTopic(subTopicsMap[index]['subID']));

      return subs;
    }
    );
  }

  static Future<List<STGBook>> getSTGChapters(int parentId) async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    final List<Map<String, dynamic>> chapterTopicsMap = await stgDb.query("chapters", where:"categoryID = ?", whereArgs:[parentId]);

    return List.generate(chapterTopicsMap.length,(index) {
      STGBook chapter =  STGBook(
        chapterTopicsMap[index]['chapterId'],
        chapterTopicsMap[index]['chapterTitle'],
        detail:chapterTopicsMap[index]['chapterDetail'],
        hasSub: chapterTopicsMap[index]["chapterSub"],
        parentId:chapterTopicsMap[index]['categoryID'],
      );
      chapter.setChildren(getSTGSubTopic(chapterTopicsMap[index]['chapterId']));

      return chapter;
    }
    );
  }

  static Future<List<STGBook>> getSTGCategories() async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    final List<Map<String, dynamic>> categoriesMap = await stgDb.query("category");

    return List.generate(categoriesMap.length,(index) {
      STGBook cat = STGBook(
        categoriesMap[index]['id'],
        categoriesMap[index]['category'],

      );
      cat.setChildren(getSTGChapters(categoriesMap[index]['id']));
      return cat;
    }
    );
  }

  static Future<List<STGBook>> getSearches(String query) async{
    if(stgDb == null){
      stgDb = await initDb();
    }
    final List<Map<String, dynamic>> searchMap = await stgDb.rawQuery("""
    select * from subs where subTitle like '%${query}%' or subDetail like '%${query}%'
    """);
    return List.generate(searchMap.length,(index){
      return STGBook(
        searchMap[index]["subID"],
        searchMap[index]["subTitle"],
        detail: searchMap[index]["subDetail"],
      );
    });
  }



}