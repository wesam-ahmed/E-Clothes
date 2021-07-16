import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String title;
  String shortInfo;
  String idItem;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  String section;
  String category;
  int price;
  int quantity;
  int buyers;
  num rate;
  num rater;
  num finalrate;
  String sellerid;
  String sellername;
  String selleraddress;
  String sellerthumbnailUrl;



  ItemModel(
      {this.title,
        this.shortInfo,
        this.idItem,
        this.publishedDate,
        this.thumbnailUrl,
        this.longDescription,
        this.status,
        this.category,
        this.section,
        this.price,
        this.quantity,
        this.sellerid,
        this.sellername,
        this.selleraddress,
        this.sellerthumbnailUrl,
        this.buyers,
        this.rate,
        this.rater,
        this.finalrate,
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    idItem=json['idItem'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    category=json['category'];
    section=json['section'];
    quantity=json['quantity'];
    sellerid = json['sellerid'];
    sellername = json['sellername'];
    selleraddress=json['selleraddress'];
    sellerthumbnailUrl = json['sellerthumbnailUrl'];
    buyers = json['buyers'];
    rate = json['rate'];
    rater = json['rater'];
    finalrate = json['finalrate'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['idItem'] =this.idItem;
    data['price'] = this.price;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    data['category']=this.category;
    data['section']=this.section;
    data['quantity']=this.quantity;
    data['sellerid'] = this.sellerid;
    data['sellername'] = this.sellername;
    data['selleraddress'] =this.selleraddress;
    data['sellerthumbnailUrl'] = this.sellerthumbnailUrl;
    data['buyers']=this.buyers;
    data['rate']=this.rate;
    data['rater']=this.rater;
    data['finalrate']=this.finalrate;


    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }


}
class SectionKey{
  static String section;
  static String category="T-Shirt";
  static bool isUsed =false;
}
class ListOfOrder{
  static List <Map<String,dynamic>> idlist =[];
  static List <Map<String,dynamic>> idlistOfMyOrders =[];

}