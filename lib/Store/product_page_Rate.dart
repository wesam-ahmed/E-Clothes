import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/shopOwner.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';


// ignore: must_be_immutable
class ProductPageRate extends StatefulWidget {
  final ItemModel itemModel;


  ProductPageRate({this.itemModel});

  @override
  _ProductPageRateState createState() => _ProductPageRateState();
}

class _ProductPageRateState extends State<ProductPageRate> {

  final double expanded_height = 400;
  final double rounded_container_height = 50;
  Future<bool> _backStore() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoreHome()));
  }
  int quantityOfItems = 1;
  String ValueChoose;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _backStore,
      child: Scaffold(
        body: Stack(
          children: <Widget> [
            CustomScrollView(
              slivers: <Widget>[
                _buildSliverHead(),
                SliverToBoxAdapter(
                  child: _buildDetail(),
                )
              ],
            ),

          ],
        ),
      ),
    );

  }
  Widget _buildSliverHead() {
    return SliverPersistentHeader(
      delegate: DetailSliverDelegate(
        expanded_height,
        widget.itemModel,
        rounded_container_height,
      ),
    );
  }
  //da el cointanier bta3 ba2y el saf7a ba3d el sora wi el seller
  Widget _buildDetail() {

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildUserInfo(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Text(widget.itemModel.longDescription
              ,
              style: TextStyle(
                color: Colors.black38,
                height: 1.4,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Featured",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.6,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    children: [
                      CustomText(text: "PRICE",
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 5,),
                      CustomText(text: '\E\G'+widget.itemModel.price.toString() ,
                        color: primaryColor,
                      )
                    ],
                  ),

                ],),
            ),

          ),
        ],
      ),
    );
  }
  //da bta3 el seller info
  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              widget.itemModel.sellerthumbnailUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.itemModel.sellername,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: (){

              Route route =
              MaterialPageRoute(builder: (c) => ShopOwner(itemModel: widget.itemModel,));
              Navigator.pushReplacement(context, route);

            },

            icon: const Icon(Icons.arrow_forward_ios_outlined),
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

}

//da el box bta3 el sora
class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final ItemModel itemModel;
  final double rounded_container_height;

  DetailSliverDelegate(
      this.expandedHeight, this.itemModel, this.rounded_container_height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        children: <Widget>[
          Hero(

            tag: itemModel.shortInfo,
            child: FullScreenWidget(
              child: Image.network(
                itemModel.thumbnailUrl,
                width: MediaQuery.of(context).size.width,
                height: expandedHeight,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: expandedHeight - rounded_container_height - shrinkOffset,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: rounded_container_height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: expandedHeight - 120 - shrinkOffset,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemModel.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  itemModel.shortInfo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}







