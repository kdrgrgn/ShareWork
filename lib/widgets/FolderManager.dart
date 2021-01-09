import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FolderManager extends StatefulWidget {
  @override
  _FolderManagerState createState() => _FolderManagerState();
}

class _FolderManagerState extends State<FolderManager> {
  Color themeColor;
  bool isLoading = true;
  String googleDocs = "https://docs.google.com/gview?embedded=true&url=";
  String pdfurl = "https://www.era-learn.eu/documents/03_call_documents.pdf";
  String url;
//  PdfViewerController _pdfViewerController;
  bool isGridView = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  //  _pdfViewerController = PdfViewerController();
    url = googleDocs + pdfurl;
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;
    return Scaffold(
      bottomNavigationBar: BuildBottomNavigationBar(),
      appBar: AppBar(
        title: Text("File Manager"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add, color: Colors.black, size: 32),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.black, size: 32),
          )      ,

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Tab(
          icon: Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            buildRowButton(),

            isGridView
                ? ListView(
              shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  children: [
                    buildGridView(buildDirectory()),
                    buildGridView(buildFile()),
                  ],
                )
                : ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              itemCount: 10,
              itemBuilder: (contex, index) {
                return buildList();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              InkWell(
                onTap: () {
                  setState(() {
                    isGridView = false;
                  });
                },
                child: Icon(
                  Icons.list,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isGridView = true;
                  });
                },
                child: Icon(
                  Icons.grid_view,
                  color: Colors.black,
                  size: 32,
                ),
              ),

            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget buildFile() {
    return Column(children: [
      Expanded(
          flex: 3,
          child: Container(
            width: 80,
            child: Stack(
              children: [
                SfPdfViewer.network(
                  pdfurl,

                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(color: Colors.red,child: Text("PDF",style: TextStyle(color: Colors.white,fontSize: 16),),),
                    ],
                  ),
                ],
              ),
                Container(color: Colors.transparent,)
              ],
            ),
          )),
      Expanded(
        flex: 1,
        child: Text(

          "Dosya Adı",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),

      Expanded(
        flex: 1,
        child: Text(
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
          style: TextStyle(fontSize: 12),

        ),
      ),
    ]);
  }

  GridView buildGridView(Widget child) {
    return GridView.builder(
      itemCount: 4,
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      itemBuilder: (context, index) {
        return child;
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 10,crossAxisSpacing: 10,
       crossAxisCount: 2),
    );
  }

  Widget buildDirectory() {
    return Column(children: [
      Expanded(
          flex: 3,
          child: Image.asset(
            "assets/images/directory.png",
          )),
      Expanded(
        flex: 1,
        child: Text(
          "Dosya Adı",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),

      Expanded(flex: 1,
          child: Text(
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
        style: TextStyle(fontSize: 12),
      )),
    ]);
  }

  Widget buildList() {
    return Card(
      child: ListTile(
        leading: Image.asset("assets/images/directory.png"),
        title: Text("Dosya Adı"),
        subtitle: Text(
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
          style: TextStyle(fontSize: 12),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
