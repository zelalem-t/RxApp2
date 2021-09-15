
class STGBook{
  int id;
  String title;
  String detail;
  int hasSub;
  int parentId;
  String iDColumn;
  String titleColumn;
  String detailColumn;
  String hasSubColumn;
  String parentIdColumn;
  List<STGBook> children;

  STGBook(this.id,this.title,{this.detail,this.hasSub,this.parentId,this.children=const <STGBook>[]});

  STGBook.map(dynamic obj){
    this.id = obj[iDColumn];
    this.title = obj[titleColumn];
    this.detail = obj[detailColumn];
    this.hasSub = obj[hasSubColumn]==1?1:0;
    this.parentId = obj[parentIdColumn];
  }

  void setChildren(Future<List<STGBook>> children) async{
    this.children = await children;
  }

  List<STGBook> get myChildren => children;
}