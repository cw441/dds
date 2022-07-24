import 'dart:developer';
import '../model/productmodel.dart' as product;
import 'package:flutter/material.dart';
import '../widgets/screen1.dart';
import '../serves/get all.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'HomePAge';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mahmood'),
      ),
      // show product as grid view
      body:Padding(
      padding: const EdgeInsets.only(left:10,right:10,top:10 ),
    child:
      FutureBuilder(
        future: EcommerceService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<product.Product>?> snapshot) {
          // has error
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }

          // hase data
          if (snapshot.hasData) {
            // show data as gridview here
            final products = snapshot.data;
            return GridView.count(
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,

              mainAxisSpacing: 2,
              crossAxisCount: 2,
              children: products!.map((item) {
                return ProductItem(item: item);
              }).toList(),
            );
          }

          // loading
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),)
    );
  }
}