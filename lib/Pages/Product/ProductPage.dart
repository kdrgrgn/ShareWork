import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Product/FilterPage.dart';
import 'package:mobi/Pages/Product/ProfilePage.dart';

import 'ProductDetails.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  bool searchActive = false;
  List<String> categoryUrl = [
    "assets/newsIcons/thumbnail_ikon_money.png",
    "assets/newsIcons/thumbnail_ikon_shopping.png",
    "assets/newsIcons/thumbnail_ikon_food.png",
    "assets/newsIcons/thumbnail_ikon_journey.png",
    "assets/newsIcons/thumbnail_ikon_kasa.png",
    "assets/newsIcons/thumbnail_ikon_bill.png",
    "assets/newsIcons/thumbnail_ikon_fuel.png",
    "assets/newsIcons/thumbnail_ikon_rent.png",
  ];
  List<String> productUrl = [
"https://pcbonlineshop.com/var/photo/product/2000x4000/4/176/4.jpg",
"https://cdn.shopify.com/s/files/1/0070/7032/files/camera_56f176e3-ad83-4ff8-82d8-d53d71b6e0fe.jpg?v=1527089512",
"https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
"https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
"http://www.mamiyaleaf.com/assets/slider/product/product_slider_heinz_baumann.jpg",
"https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MHKJ3?wid=572&hei=572&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1603649031000",

  ];
  List<String> productTitle = [
"Temiz Kulaklik",
"Fotograf Makinesi",
"yep yeni Kulaklik",
"Az kullanilmis ayakkabi",
"Acilmamis Parfum",
"Kutusunda Iphone",

  ];
  List<String> category = [
    "Harclik",
    "Alisveris",
    "Yemek",
    "Gezi",
    "Kasa",
    "Fatura",
    "Benzin",
    "Kira",
  ];  List<Color> categoryColor = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.green,
  Colors.orange,
  Colors.cyanAccent,
  Colors.deepPurpleAccent,
  Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[

        /*    searchActive
                ? InkWell(
                    onTap: () {
                      setState(() {
                        width = Get.width - 100;
                        searchActive = false;
                      });
                    },
                    child: Icon(Icons.arrow_back))
                : */InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductProfile()));
              },
                  child: Padding(
              padding: const EdgeInsets.only(left:12.0),

              child: CircleAvatar(
                radius: 30,
                backgroundImage: Image.network(
                  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                ).image,
              ),
                  ),
                ),
           Expanded(
             child: Container(
                height: 80,


               // duration: Duration(milliseconds: 2000),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                   /* onTap: () {
                      setState(() {
                        width = Get.width - 30;
                        searchActive = true;
                      });
                    },*/
                    onChanged: (value) {
                      if(value.isNotEmpty){
                        setState(() {
                          searchActive = true;

                        });
                      }else{
                        setState(() {
                          searchActive = false;

                        });
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Birseyler Arayin",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0))),
                  ),
                ),
              ),
           ),
            searchActive
                ? Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: Icon(
              Icons.search,

            ),
                )

                : InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FilterPage()));

              },
                  child: Padding(
                    padding: const EdgeInsets.only(right:12.0),
                    child: Icon(
                        Icons.filter_list_outlined,
                        color: Get.theme.backgroundColor,
                      ),
                  ),
                ),

          ],
        ),
     /*   searchActive?Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: true),
              itemCount: 18,
              itemBuilder: (context, index) {
                return itemSearch(index);
              }),
        ):*/Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryUrl.length,
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      itemBuilder: (context, index) {
                        return categoryItem(index);
                      }),
                ),
                GridView.builder(
                  itemCount: productUrl.length,
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (context, index) {
                    return listItem(index);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25, crossAxisSpacing: 10, crossAxisCount: 2),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget categoryItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: categoryColor[index],

                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Image.asset(
                  categoryUrl[index],
                  color: Colors.white,
                  width: 30,
                  height: 30,
                  //  fit: BoxFit.contain,
                )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category[index],
            )
          ],
        ),
      ),
    );
  }
  Widget listItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetails()));
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

            Text(productTitle[index])
          ],
        ),
      ),
    );
  }

  Widget itemSearch(int index) {
    return Card(
      child: ListTile(
        onTap: (){
          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductSearch()));
        },
        title: Text("name"),
        subtitle: Text("category or office"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

}
