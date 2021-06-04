
class SellerModel {
  String sellerid;
  String sellername;
  String selleraddress;
  String sellerthumbnailUrl;


  SellerModel(
      {this.sellerid,
        this.sellername,
        this.selleraddress,
        this.sellerthumbnailUrl,
      });

  SellerModel.fromJson(Map<String, dynamic> json) {
    sellerid = json['sellerid'];
    sellername = json['sellername'];
    selleraddress=json['selleraddress'];
    sellerthumbnailUrl = json['sellerthumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellerid'] = this.sellerid;
    data['sellername'] = this.sellername;
    data['selleraddress'] =this.selleraddress;
    data['sellerthumbnailUrl'] = this.sellerthumbnailUrl;
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

