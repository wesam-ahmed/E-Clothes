import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stores extends StatefulWidget
{
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(16.0),

          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.0,
                    child:Row(
                      children: [
                        Card(child: Text('first'),),
                        Card(child: Text('Second'),),
                        Card(child: Text('Third'),),
                      ],
                    ) ,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
