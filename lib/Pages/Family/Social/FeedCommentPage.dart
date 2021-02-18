import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Social/Feed.dart';
import 'package:mobi/model/Family/Social/FeedReply.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FeedCommentPage extends StatefulWidget {
  FeedData feedData;

  FeedCommentPage(this.feedData);

  @override
  _FeedCommentPageState createState() => _FeedCommentPageState();
}

class _FeedCommentPageState extends State<FeedCommentPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  ControllerFamily _controllerFamily = Get.put(ControllerFamily());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  bool isLoading = true;
  Family family;
  final _formKey = GlobalKey<FormState>();
  String newReply;
  TextEditingController _textEditingController = TextEditingController();
  Reply reply;
  List<ReplyData> listReply;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controllerFamily.family.value;
      reply = await _controllerFamily.getFamilyFeedReplyList(
          _controllerDB.headers(),
          familyFeedId: widget.feedData.id);
      listReply = reply.data;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment"),
      ),
      body: isLoading
          ? MyCircular()
          : Column(
              children: [
                Flexible(
                  child: Container(
                    height: Get.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      widget.feedData.person.user.firstName +
                                          " " +
                                          widget.feedData.person.user.lastName),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: Image.network(
                                            _controllerChange.urlUsers +
                                                widget.feedData.person.user
                                                    .profilePhoto)
                                        .image,
                                  ),
                                  subtitle: Text(widget.feedData.createDate
                                      .replaceFirst("T", " ")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: Get.width,
                                    child: HtmlWidget(widget.feedData.feed),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              shrinkWrap: true,
                              itemCount: listReply.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      listReply[index].person.user.firstName +
                                          " " +
                                          listReply[index].person.user.lastName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: Image.network(
                                              _controllerChange.urlUsers +
                                                  listReply[index]
                                                      .person
                                                      .user
                                                      .profilePhoto)
                                          .image,
                                    ),
                                    subtitle: Text(listReply[index].feed),
                                  ),
                                );
                              }),

                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),

                Container(child: renderTextBox()),
              ],
            ),
    );
  }

  Widget renderTextBox() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Form(
              key: _formKey,
              child: Container(
                child: TextField(
                  minLines: 1,
                  maxLines: 4,
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {
                      newReply = value;
                    });
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: "Your Message Here",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor: themeColor,
            onPressed: () async {
              int personId;
              _controllerFamily.family.value.data.personList.forEach((element) {
                if(element.user.id==_controllerDB.user.value.data.id){
                  personId=element.id;
                }
              });
              _controllerFamily
                  .insertFamilyFeedReply(_controllerDB.headers(),
                      familyFeedId: widget.feedData.id,
                      feed: newReply,
                      personId: personId)
                  .then((value) {
                setState(() {
                  listReply.insert(0,value);
                });
              });
              setState(() {
                _textEditingController.text = "";
                newReply = "";
              });
            },
            child: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }
}
