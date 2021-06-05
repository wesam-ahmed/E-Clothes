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
class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  List<String>sizes=[];
  List<String>colors=[];

  ProductPage({this.itemModel,this.sizes,this.colors});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

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
          Container(margin: EdgeInsets.only(right: 20),
              child: CustomText(text:"\u{2B50}"+widget.itemModel.finalrate.toStringAsFixed(1),alignment: Alignment.bottomRight ,color: primaryColor,)),
          Container(margin: EdgeInsets.only(right: 10),
              child: CustomText(text:widget.itemModel.rater.toString()+" ratings",alignment: Alignment.bottomRight ,color: Colors.grey.shade300,)),

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
          SizedBox(height: 260, child: FeaturedWidget()),

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
                  Container(
                    width: 180,
                    height: 50,
                    child: CustomButton(onPress: (){
                      checkItemInCart(widget.itemModel.idItem, context);
                    },
                      text: "Add to Cart",



                    ),
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

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      getSizes(model.idItem).then((size){
        getColors(model.idItem).then((color){
          Route route =
          MaterialPageRoute(builder: (c) => ProductPage(itemModel: model,sizes:size,colors: color,));
          Navigator.pushReplacement(context, route);
        });
      });
    },
    splashColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
         decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [BoxShadow(
          color: Colors.grey.shade200,
          offset: Offset(0.0, 5.0), //(x,y)
          blurRadius: 10.0,
        ),],),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                  height: 180,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.0),
                    child: Image.network(
                      model.thumbnailUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
            SizedBox(height: 5,),
            CustomText(text: model.title,alignment: Alignment.bottomLeft),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text:"\E\G"+model.price.toString(),alignment: Alignment.bottomLeft ,color: primaryColor,),
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {checkItemInCart(model.idItem, context);},
                    child: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
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
class FeaturedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("items")
          .where("section",
          isEqualTo: SectionKey.section.toString())
          .where("category",
          isEqualTo: SectionKey.category.toString())
          .snapshots(),
      builder: (context, dataSnapshot) {
        if(dataSnapshot.hasData)
        {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)
            {
              ItemModel model = ItemModel.fromJson(
                  dataSnapshot
                      .data.docs[index].data());
              return sourceInfo(model, context);
            }
            ,itemCount: dataSnapshot.data.docs.length,
          );
        }
        else
        {
          return Center(
            child: circularProgress(),
          );
        }

      },
    );

  }
}






