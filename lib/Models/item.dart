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
    return data;
  }
}
class ListOfOrder{
  static List <Map<String,dynamic>> idlist =[];
  static List <Map<String,dynamic>> idlistOfMyOrders =[];

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
  static String category="Shirts";
}
