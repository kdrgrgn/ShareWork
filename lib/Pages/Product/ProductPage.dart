import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerProduct.dart';
import 'package:mobi/Pages/Product/FilterPage.dart';
import 'package:mobi/Pages/Product/ProfilePage.dart';
import 'package:mobi/model/Product/Product.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/GradientWidget.dart';

import 'ProductDetails.dart';

class ProductPage extends StatefulWidget {
  bool isSearch;
  int id;
  int userId;
  int size;
  int categoryId;
  int countryId;
  int cityId;
  int districtId;
  int minPrice;
  int maxPrice;
  String keyString;

  ProductPage(
      {this.isSearch: false,
      this.userId: 0,
      this.size: 0,
      this.categoryId: 0,
      this.countryId: 0,
      this.id: 0,
      this.cityId: 0,
      this.districtId: 0,
      this.minPrice: 0,
      this.maxPrice: 0,
      this.keyString: ""});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerProduct _controllerProduct = Get.put(ControllerProduct());
  List<ProductData> products = [];
  Product _product;
  bool isLoading = true;
  bool isUpload = false;
  bool morePage = true;
  int page = 1;
  ScrollController _scrollController;
  bool isFilter = false;
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

  List<String> category = [
    "Harclik",
    "Alisveris",
    "Yemek",
    "Gezi",
    "Kasa",
    "Fatura",
    "Benzin",
    "Kira",
  ];

  List<Color> categoryColor = [
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (!isUpload &&
          _scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        if (morePage) {
          _loadData();
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _product = await _controllerProduct.getLastNProductWithFilter(
        _controllerDB.headers(),
        id: widget.id,
        userId: widget.userId,
        size: 1,
        cityId: widget.cityId,
        countryId: widget.countryId,
        categoryId: widget.countryId,
        minPrice: widget.minPrice,
        maxPrice: widget.maxPrice,
        key: widget.keyString,
      );
      isFilter = widget.isSearch;
      products = _product.data;
      _controllerProduct.getProductCategoryList(_controllerDB.headers());

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
              controller: _scrollController,
              primary: false,
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  floating: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: MyGradientWidget().linear(
                                  start: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0, right: 25),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductProfile()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: Image.network(
                                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 55.0, left: 25),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: buildFilterButton(context),
                          ),
                        ),
                        Align(
                          child: buildCustomAppBar(context).first,
                          alignment: Alignment(0, 0.8),
                        ),
                        Align(
                          child: Text(
                            "Aradığınız Nedir?",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          alignment: Alignment(-0.5, 0.0),
                        ),
                        Align(
                          child: Text(
                            "İstediniz ürünü arayabilirsiniz",
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                          alignment: Alignment(-0.5, 0.3),
                        ),
                      ],
                    ),
                  ),
                ),
                /*SliverList(
              delegate: SliverChildListDelegate(
                buildCustomAppBar(context),
              ),
            ), */

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                      child: PreferredSize(
                          preferredSize: Size.fromHeight(115.0),
                          child: buildCategoryItems())),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    buildProductsAndCategory(),
                  ),
                ),
                /*   SliverFillRemaining(child:  buildCustomAppBar(context),),
            SliverFillRemaining(child:  buildProductsAndCategory(),),
*/
              ]),
        ),
        Container(
          height: isUpload ? 60.0 : 0,
          child: MyCircular(),
        ),
      ],
    );
  }

  Widget buildFilterButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FilterPage()))
            .then((filter) async {
          if (filter != null && filter == true) {
            setState(() {
              isLoading = true;
            });
            _controllerProduct
                .getLastNProductWithFilter(
              _controllerDB.headers(),
              id: 0,
              userId: 0,
              size: 0,
              cityId: _controllerProduct.cityID.value,
              countryId: _controllerProduct.countryID.value,
              categoryId: _controllerProduct.countryID.value,
              minPrice: _controllerProduct.minPrice.value,
              maxPrice: _controllerProduct.maxPrice.value,
              key: _controllerProduct.keyString.value,
            )
                .then((value) {
              setState(() {
                _product = value;
                isFilter = true;
                products = _product.data;

                print("if e girecek = " + products.length.toString());

                isLoading = false;
              });
            });
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filtrele   ",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildCustomAppBar(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 40.0, left: 40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          // duration: Duration(milliseconds: 2000),
          child: TextFormField(
            /* onTap: () {
            setState(() {
              width = Get.width - 30;
              searchActive = true;
            });
          },*/
            onChanged: (value) {
              if (value.length >= 3) {
                setState(() {
                  searchActive = true;

                  isLoading = true;
                });
                _controllerProduct
                    .getLastNProductWithFilter(
                  _controllerDB.headers(),
                  key: value,
                )
                    .then((prod) {
                  setState(() {
                    _product = prod;
                    isFilter = true;
                    products = _product.data;

                    isLoading = false;
                  });
                });
              } else if (value.isEmpty) {
                setState(() {
                  searchActive = false;

                  isLoading = true;
                });
                _controllerProduct
                    .getLastNProductWithFilter(
                  _controllerDB.headers(),
                )
                    .then((prod) {
                  setState(() {
                    _product = prod;
                    isFilter = true;
                    products = _product.data;

                    isLoading = false;
                  });
                });
              }
            },
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Birseyler Arayin",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
      ),
    ];
  }

  List<Widget> buildProductsAndCategory() {
    return [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: isLoading
              ? MyCircular()
              : GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (context, index) {
                    return listItem(index);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                ),
        ),
      )
    ];
  }

  Container buildCategoryItems() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      height: 115,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryUrl.length,
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          controller: ScrollController(keepScrollOffset: false),
          itemBuilder: (context, index) {
            return categoryItem(index);
          }),
    );
  }

  Widget categoryItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
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
              builder: (context) => ProductDetails(products[index])));
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    // products[index].images.first ??
                    "https://pcbonlineshop.com/var/photo/product/2000x4000/4/176/4.jpg",
                    fit: BoxFit.cover,

                    //  fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    " " + products[index].title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    " " + products[index].category.name,
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          "4.9",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right_alt)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemSearch(int index) {
    return Card(
      child: ListTile(
        onTap: () {
          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductSearch()));
        },
        title: Text("name"),
        subtitle: Text("category or office"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Future<void> _loadData() async {
    setState(() {
      page++;
      isUpload = true;
    });
    _controllerProduct
        .getLastNProductWithFilter(
      _controllerDB.headers(),
      id: widget.id,
      userId: widget.userId,
      size: page,
      cityId: widget.cityId,
      countryId: widget.countryId,
      categoryId: widget.countryId,
      minPrice: widget.minPrice,
      maxPrice: widget.maxPrice,
      key: widget.keyString,
    )
        .then((value) {
          setState(() {


          if(value.data.length==0){
            morePage = false;
          }else {
            _product.data.addAll(value.data);
            products.addAll(value.data);
          }
          isUpload=false;
          });
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
