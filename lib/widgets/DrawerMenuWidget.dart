
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';

class DrawerMenu extends StatelessWidget {

  ControllerDB _controller;

  DrawerMenu(this._controller);

  Color themeColor=Get.theme.accentColor;
  Color backGround = Get.theme.backgroundColor;

  @override
  Widget build(BuildContext context) {



    return  Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Drawer(
        child:
        ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
                _controller.user.value.data.firstName +
                    " " +
                    _controller.user.value.data.lastName,
                style: TextStyle(color: themeColor)),
            accountEmail: Text(
              _controller.user.value.data.email,
              style: TextStyle(color: themeColor),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: Image.network(
                  _controller.user.value.data.profilePhoto)
                  .image,
            ),

            //  onDetailsPressed: () {},
            decoration: BoxDecoration(
                color: backGround,
                image: DecorationImage(
                    image:
                    AssetImage("assets/images/account/profile.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onLongPress: () {},
          ),
          Divider(),
          ListTile(
            title: Text('New Group'),
            leading: Icon(Icons.group_add),
          ),
          ListTile(
            title: Text('New Chat'),
            leading: Icon(Icons.chat),
            onLongPress: () {},
          ),
          ListTile(
            title: Text('Calls'),
            leading: Icon(Icons.call),
            onLongPress: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onLongPress: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Support'),
            leading: Icon(Icons.report_problem),
            onLongPress: () {},
          ),
          ListTile(
              title: Text('Close'),
              leading: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ]),
      ),
    );
  }
}
