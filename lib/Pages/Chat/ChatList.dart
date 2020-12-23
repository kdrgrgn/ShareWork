import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ChatRoom.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Color themeColor = Get.theme.accentColor;

  final List<ChatListItem> chatListItems = [
    ChatListItem(
        profileURL:
            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        personName: "Kadir",
        date: "9:10 am",
        lastMessage: "sfsdfsdfsdf"),
    ChatListItem(
        profileURL:
            "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        personName: "Ahmet",
        date: "9:10 am",
        lastMessage: "sddfgd ggdfg dfgd gdfgsdgag fjj"),
    ChatListItem(
        profileURL:
            "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        personName: "Mehmet",
        date: "9:10 am",
        lastMessage: "dsfsdfs gfg jdsg sjfdg sodfg odfg dfg ojdssdgsgdfgdfhdghdh"),
    ChatListItem(
        profileURL:
            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        personName: "Selin",
        date: "9:10 am",
        lastMessage: "dfsfdsgdfsg sdgsg")
  ];

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
          itemCount: chatListItems.length,
          itemBuilder: (context, i) {
            return Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))
              ),
              child: ListTile(isThreeLine:true ,

                title: Text(chatListItems[i].personName, style: TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(chatListItems[i].lastMessage, style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(chatListItems[i].date,style: TextStyle(fontSize: 14),),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(chatListItems[i].profileURL),
                ),
                onTap: () {
                  Get.to(ChatRoom(person:chatListItems[i],));
                },
              ),
            );
          });
  }
}

/*class ChatListItem {
  final String profileURL;
  final String personName;
  final String lastMessage;
  final String date;

  ChatListItem({this.profileURL, this.personName, this.lastMessage, this.date});
}*/
