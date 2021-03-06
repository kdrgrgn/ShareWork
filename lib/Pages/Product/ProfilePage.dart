

import 'package:flutter/material.dart';
import 'package:mobi/Pages/Product/AddProduct.dart';

import 'EditProduct.dart';




class ProductProfile extends StatefulWidget {
  @override
  _ProductProfileState createState() => _ProductProfileState();
}

class _ProductProfileState extends State<ProductProfile> {

  List<String> productUrl = [
    "https://pcbonlineshop.com/var/photo/product/2000x4000/4/176/4.jpg",
    "https://cdn.shopify.com/s/files/1/0070/7032/files/camera_56f176e3-ad83-4ff8-82d8-d53d71b6e0fe.jpg?v=1527089512",
    "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "http://www.mamiyaleaf.com/assets/slider/product/product_slider_heinz_baumann.jpg",
    "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MHKJ3?wid=572&hei=572&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1603649031000",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct()));
          },
          child: Tab(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      appBar: AppBar(
        title: Text("My Products"),
      ),
      body:                 GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        itemBuilder: (context, index) {
          return listItem(index);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 25, crossAxisSpacing: 10, crossAxisCount: 2),
      )
      ,
    );
  }

  Widget listItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProduct()));
        },
        child: Column(
          children: [
            Container(


              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  productUrl[index],
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,


                  //  fit: BoxFit.contain,
                ),
              ),
            ),

            Text("Product Title")
          ],
        ),
      ),
    );
  }

}

