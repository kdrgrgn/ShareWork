import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/Social/SearchInvite.dart';
import 'package:mobi/Pages/Family/Social/FeedCommentPage.dart';
import 'package:mobi/Pages/Family/Social/InsertFeed.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Social/Feed.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import 'InviteList.dart';

class SocialHomePage extends StatefulWidget {
  @override
  _SocialHomePageState createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  ControllerFamily _controllerFamily = Get.put(ControllerFamily());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  Family family;
  List<FamilyData> familyList;
  List<FeedData> listFeed;
  Feed feed;
  bool isLoading = true;
  bool isUpload = false;
  bool morePage = true;
  int page = 1;
  int rowsPerPage = 4;
  List<bool> likeState = [];
  int personId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controllerFamily.family.value;
      familyList = await _controllerFamily.getFamilySocialFamilyList(
          _controllerDB.headers(),
          id: family.data.id);

      _controllerFamily.family.value.data.personList.forEach((element) {
        if (element.user.id == _controllerDB.user.value.data.id) {
          personId = element.id;
        }
      });

      feed = await _controllerFamily.getFamilyFeedListHome(
          _controllerDB.headers(),
          familyId: family.data.id,
          page: page,
          rowsPerPage: rowsPerPage);
      listFeed = feed.data;
      listFeed.forEach((element) {
        bool state = false;
        element.likeList.forEach((like) {
          if (like.personId == personId) {
            state = true;
            likeState.add(true);
          }
        });

        if (!state) {
          likeState.add(false);
        }
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => InsertFeed()))
              .then((value) {
            setState(() {
              isUpload = false;
              morePage = true;
              page = 1;
              isLoading = true;
            });
            _controllerFamily
                .getFamilyFeedListHome(_controllerDB.headers(),
                    page: page,
                    rowsPerPage: rowsPerPage,
                    familyId: family.data.id)
                .then((newFeed) {
              setState(() {
                feed = newFeed;
                listFeed = feed.data;
                isLoading = false;
              });
            });
          });
        },
        child: Tab(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: isLoading
          ? MyCircular()
          : Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: familyList.length,
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(keepScrollOffset: true),
                          itemBuilder: (context, index) => personBuild(index),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              SearchInvite(familyList)))
                                      .then((value) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _controllerFamily
                                        .getFamilySocialFamilyList(
                                            _controllerDB.headers(),
                                            id: family.data.id)
                                        .then((value) {
                                      setState(() {
                                        familyList = value;
                                        isLoading = false;
                                      });
                                    });
                                  });
                                },
                                child: Icon(Icons.search)),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => InviteList()))
                                    .then((value) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  _controllerFamily
                                      .getFamilySocialFamilyList(
                                          _controllerDB.headers(),
                                          id: family.data.id)
                                      .then((value) {
                                    setState(() {
                                      familyList = value;
                                      isLoading = false;
                                    });
                                  });
                                });
                              },
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                          "assets/newsIcons/ikonlar_ek_6.png"),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          /*    width: 10,
                                              height: 10,*/
                                          decoration: BoxDecoration(
                                            color: background,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            "12",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    // ignore: missing_return
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isUpload &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        if (morePage) {
                          setState(() {
                            page++;
                            isUpload = true;
                          });
                          _loadData();
                        }
                      }
                    },
                    child: ListView.builder(
                      // controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      itemCount: listFeed.length,
                      itemBuilder: (context, index) {
                        return buildPost(index);
                      },
                    ),
                  ),
                ),
                Container(
                  height: isUpload ? 70.0 : 0,
                  child: MyCircular(),
                )
              ],
            ),
    );
  }

  Widget buildPost(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(listFeed[index].person.user.firstName +
                  " " +
                  listFeed[index].person.user.lastName),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: Image.network(_controllerChange.urlUsers +
                        listFeed[index].person.user.profilePhoto)
                    .image,
              ),
              subtitle: Text(listFeed[index].createDate.substring(0, 10)),
              trailing: Icon(Icons.more_vert),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: Get.width, child: HtmlWidget(listFeed[index].feed)),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => FeedCommentPage(listFeed[index])))
                    .then((value) {
                  setState(() {
                    isUpload = false;
                    morePage = true;
                    page = 1;
                    isLoading = true;
                  });
                  _controllerFamily
                      .getFamilyFeedListHome(_controllerDB.headers(),
                          rowsPerPage: rowsPerPage,
                          page: page,
                          familyId: family.data.id)
                      .then((newFeed) {
                    setState(() {
                      feed = newFeed;
                      listFeed = feed.data;
                      isLoading = false;
                    });
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                          "assets/newsIcons/thumbnail_ikon_3_3.png"),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(listFeed[index].commentCount.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    likeState[index]
                        ? InkWell(
                            onTap: () async {
                              await _controllerFamily.deleteFamilyFeedLike(
                                  _controllerDB.headers(),
                                  feedId: listFeed[index].id);
                              setState(() {
                                listFeed[index].likeCount--;
                                likeState[index] = false;
                              });

                              listFeed[index].likeList.forEach((element) {
                                if (element.personId == personId) {
                                  setState(() {
                                    listFeed[index].likeList.remove(element);
                                  });
                                }
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 32,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              setState(() {
                                likeState[index] = true;
                                listFeed[index].likeCount++;
                              });
                              LikeList result = await _controllerFamily
                                  .insertFamilyFeedLike(_controllerDB.headers(),
                                      feedId: listFeed[index].id);
                              setState(() {
                                listFeed[index].likeList.add(result);
                              });
                            },
                            child: Icon(
                              Icons.favorite_outline,
                              size: 32,
                            ),
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(listFeed[index].likeList.length.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  personBuild(int index) {
    return Container(
      width: 70,
      child: InkWell(
        onTap: () {
          /* Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  UserInfo(family.data.personList[index])));*/
        },
        child: Wrap(
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 27,
                backgroundImage: Image.network(
                        _controllerChange.urlFamilyPicture +
                            familyList[index].picture)
                    .image,
              ),
            ),
            Center(
              child: Text(
                familyList[index].title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _loadData() {
    _controllerFamily
        .getFamilyFeedListHome(_controllerDB.headers(),
            familyId: family.data.id, page: page, rowsPerPage: rowsPerPage)
        .then((newFeed) {
      setState(() {
        if (newFeed.data.length == 0) {
          morePage = false;
        } else {
          newFeed.data.forEach((element) {
            bool state = false;
            element.likeList.forEach((like) {
              if (like.personId == personId) {
                state = true;
                setState(() {
                  likeState.add(true);
                });
              }
            });
            if (!state) {
              likeState.add(false);
            }
          });
          listFeed.addAll(newFeed.data);
        }

        isUpload = false;
      });
    });
  }
}
