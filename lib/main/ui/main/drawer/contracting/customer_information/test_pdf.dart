import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class TestPDF extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TestPDF> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    fromAsset('assets/demo-link.pdf', 'demo.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                TextButton(
                  child: Text("Open PDF"),
                  onPressed: () {
                    if (pathPDF.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: pathPDF),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: width * 1.1625,
                  child: PDFView(
                    filePath: widget.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    pageSnap: true,
                    defaultPage: currentPage!,
                    fitPolicy: FitPolicy.BOTH,
                    preventLinkNavigation:
                        false, // if set to true the link is handled in flutter
                    // onRender: (_pages) {
                    //   setState(() {
                    //     pages = _pages;
                    //     isReady = true;
                    //   });
                    // },
                    // onError: (error) {
                    //   setState(() {
                    //     errorMessage = error.toString();
                    //   });
                    //   print(error.toString());
                    // },
                    // onPageError: (page, error) {
                    //   setState(() {
                    //     errorMessage = '$page: ${error.toString()}';
                    //   });
                    //   print('$page: ${error.toString()}');
                    // },
                    // onViewCreated: (PDFViewController pdfViewController) {
                    //   _controller.complete(pdfViewController);
                    // },
                    // onLinkHandler: (String? uri) {
                    //   print('goto uri: $uri');
                    // },
                    // onPageChanged: (int? page, int? total) {
                    //   print('page change: $page/$total');
                    //   setState(() {
                    //     currentPage = page;
                    //   });
                    // },
                  ),
                ),
                SizedBox(
                  width: width,
                  height: width * 1.1625,
                  child: PDFView(
                    filePath: widget.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    pageSnap: true,
                    defaultPage: currentPage!,
                    fitPolicy: FitPolicy.BOTH,
                    preventLinkNavigation:
                        false, // if set to true the link is handled in flutter
                    // onRender: (_pages) {
                    //   setState(() {
                    //     pages = _pages;
                    //     isReady = true;
                    //   });
                    // },
                    // onError: (error) {
                    //   setState(() {
                    //     errorMessage = error.toString();
                    //   });
                    //   print(error.toString());
                    // },
                    // onPageError: (page, error) {
                    //   setState(() {
                    //     errorMessage = '$page: ${error.toString()}';
                    //   });
                    //   print('$page: ${error.toString()}');
                    // },
                    // onViewCreated: (PDFViewController pdfViewController) {
                    //   _controller.complete(pdfViewController);
                    // },
                    // onLinkHandler: (String? uri) {
                    //   print('goto uri: $uri');
                    // },
                    // onPageChanged: (int? page, int? total) {
                    //   print('page change: $page/$total');
                    //   setState(() {
                    //     currentPage = page;
                    //   });
                    // },
                  ),
                ),
              ],
            ),
          ),
          // errorMessage.isEmpty
          //     ? !isReady
          //         ? Center(
          //             child: CircularProgressIndicator(),
          //           )
          //         : Container()
          //     : Center(
          //         child: Text(errorMessage),
          //       )
        ],
      ),
    );
  }
}
