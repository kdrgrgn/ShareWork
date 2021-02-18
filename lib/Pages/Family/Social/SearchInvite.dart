import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class SearchInvite extends StatefulWidget {
  List<FamilyData> familyList;

  SearchInvite(this.familyList);

  @override
  _SearchInviteState createState() => _SearchInviteState();
}

class _SearchInviteState extends State<SearchInvite> {
  List<FamilyData> inviteList = [];
  ControllerFamily _controllerFamily = Get.put(ControllerFamily());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  isLoading = true;
                });
                _controllerFamily
                    .getFamilySearch(_controllerDB.headers(), text: value)
                    .then((value) {
                  setState(() {
                    inviteList = value;
                    isLoading = false;
                  });
                });
              },
              decoration: InputDecoration(
                  hintText: "Search", suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: isLoading
                ? MyCircular()
                : ListView.builder(
              itemCount: inviteList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool isAdded = false;
                widget.familyList.forEach((element) {
                  if (element.id == inviteList[index].id) {
                    isAdded = true;
                  }
                });
                return Card(
                  child: ListTile(
                      title: Text(inviteList[index].title),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: Image
                            .network(
                            _controllerChange.urlFamilyPicture +
                                inviteList[index].picture)
                            .image,
                      ), //Icon(Icons.person),
                      trailing: Container(
                        color: isAdded ? Colors.grey : Colors.green,
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isAdded
                              ? Text(
                            "Added",
                            style: TextStyle(color: Colors.white),
                          )
                              : InkWell(
                            child: Row(
                              children: [
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            onTap: () {
                              _controllerFamily.insertFamilyshipInvite(
                                  _controllerDB.headers(),
                                  receiverFamilyId: inviteList[index].id).then((
                                  value) {
                                Get.showSnackbar(GetBar(title:"Gonderilen : "+ inviteList[index].title,
                                  message: "Istek Gonderildi",
                                  duration: Duration(seconds: 2),));
                              });
                            },
                          ),
                        ),
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
