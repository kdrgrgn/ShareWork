import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Social/Invite.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class InviteList extends StatefulWidget {
  @override
  _InviteListState createState() => _InviteListState();
}

class _InviteListState extends State<InviteList> {
  List<InviteData> inviteList = [];
  Invite invite;

  ControllerFamily _controllerFamily = Get.put(ControllerFamily());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  bool isLoading = true;
  Family family;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controllerFamily.family.value;
      invite = await _controllerFamily.getFamilyInviteList(
          _controllerDB.headers(),
          familyId: family.data.id);
      inviteList = invite.data;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite List"),
      ),
      body: isLoading
          ? MyCircular()
          : ListView.builder(
              itemCount: inviteList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      title: Text(inviteList[index].senderFamily.title),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: Image.network(
                                _controllerChange.urlFamilyPicture +
                                    inviteList[index].senderFamily.picture)
                            .image,
                      ), //Icon(Icons.person),
                      trailing: Container(
                        width: 120,

                        child: inviteList[index].status != 0
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Added",
                               //   style: TextStyle(),
                                ))
                            : Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            _controllerFamily
                                                .acceptFamilyship(
                                                    _controllerDB.headers(),
                                                    id: inviteList[index].id)
                                                .then((value) {
                                              setState(() {
                                                inviteList[index].status = 1;
                                              });
                                              Get.showSnackbar(GetBar(
                                                title: inviteList[index]
                                                    .senderFamily
                                                    .title,
                                                message: "Kabul Edildi",
                                                duration: Duration(seconds: 2),
                                              ));
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          child: Text(
                                            "Ignore",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            _controllerFamily
                                                .ignoreFamilyship(
                                                    _controllerDB.headers(),
                                                    id: inviteList[index].id)
                                                .then((value) {
                                              setState(() {
                                                inviteList
                                                    .remove(inviteList[index]);
                                              });
                                              Get.showSnackbar(GetBar(
                                                title: inviteList[index]
                                                    .senderFamily
                                                    .title,
                                                message: "Kabul Edilmedi",
                                                duration: Duration(seconds: 2),
                                              ));
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      )),
                );
              },
            ),
    );
  }
}
