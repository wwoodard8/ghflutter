import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'package:pspdfkit_flutter/pspdfkit.dart';

import 'ghflutter.dart';
import 'strings.dart';

void main() => runApp(GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(primaryColor: Colors.green.shade800),
      home: GHFlutter(),
    );
  }
}

class SecondRoute extends StatefulWidget {
  final String title;
  final String bookname;

  SecondRoute({Key key, @required this.title, this.bookname}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {

  bool downloading = false;
  var progressString = "";

  Future<String> prepareTestPdf() async {

    final PDFUrl = "http://willwoodard.com/meritbadge/${widget.bookname}.pdf";
    final String _documentPath = 'PDFs/${widget.bookname}.pdf';

    Dio dio = Dio();

    /*final ByteData bytes =
    await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();*/

    final Dir = await getApplicationDocumentsDirectory();
    final DocumentPath = '${Dir.path}/$_documentPath';

    //check to see if the file is already there
    //if so, don't move from folder
    if (await File(DocumentPath).exists()) {
      print("File exists");

    } else {
      print("File don't exist");

      final file = await File(DocumentPath).create(recursive: true);
      //file.writeAsBytesSync(list);

      try {

        await dio.download(PDFUrl, DocumentPath, onReceiveProgress: (rec,total){
          print("Rec: $rec , Total: $total");

          setState(() {
            downloading = true;
            progressString = ((rec/total)*100).toStringAsFixed(0) + "%";
          });
        });

      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progressString = "Completed";
      });
    }

    return DocumentPath;
  }


  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      //iOS key
      Pspdfkit.setLicenseKey(
          "HmQTOnpLMtNGjLovoUsUY3OH/EJJQ/SyZzs0wUwq8dc5rHdAajWb6v9Dgdk2mSsZZ85FPqvQGDJMANhnyzdrhAK8srR50exd5Iw3unfKPsB8+F1ixYa9HuHIjsw0y7RwA6FLPV/hdigDE+K3qeZMal0Pwfhz3HqMJgARjY715U8Oh47An9ycg2/AW2frufAkZ8LD4SqYuiBGiwgg5m4/6UV0jyWOuLbxJNoWJSOfJoS8KgZVJEll07ywCKTFtCAzxHUTRiPBpMAo7TbJgf9fshm0ewew4YpKnpKn+VedMUiNoQuZyzU9dlMlXElEPRmwu5JxkUkSJf1h7k7Cw7502iijRfzo/rLTonr2gaPPgxfCvyBuYhfTRmVx7gBmCwRbtxQNnnGZQ7hk9+PrTHSWDKuP9p8OMbjhIl1nFR0QkTcWoMLBbWDd1yYYVoGZjWSM");
    } else if (Platform.isAndroid) {
      //Android key
      Pspdfkit.setLicenseKey(
          "OO6Pkg9lvGGw8AHHDk9eV57dGTUnQzcP2RrS0OQYrOAQUpZRi8S-_oNXmyP0Z19U0kBg2vbAIySUJi5IXEAEH2XIZm9yG_yE-G8-nVY3LyrEwvPXLmQqB8q12p2lMpTYQFee5fd5q077kS8jUV66LEIxKdDWutTHgIaxQubUZ4CH3UekO44UHAaEH3UfWZgfj2soYoS0SlWxdkrpKm_4NftW55tqDDVG7nkmEWC3G-WpdzlU75W3q5wjFj4le8Mpt8lL7JpAFLgZHNQXfEzPCW_81eYk_hDXpaykjJ9XZ4FzLn9jrwD1HUqH4zQrkheamNDCNNB6ngbF-9XUzeZBh6e4NRZnl9aJcFTsCxYyEJNmeoc2P1336fAZpq3rhlTji1tBVpPVIyyyoEmUW8sJ45erYs4k219fpzMMbYy2yiA55avTOLh7-JhLA7nZXAfD");
    }

    //prepare and present pdf
    print("hello");
    //PdfActivityConfiguration.setEnabledShareFeatures(ShareFeatures.none())
    prepareTestPdf().then((path) {
      Pspdfkit.present(path, {
        enableAnnotationEditing: true,
        androidShowShareAction: false,
        androidShowPrintAction: false,
        iOSRightBarButtonItems:['thumbnailsButtonItem', 'searchButtonItem', 'annotationButtonItem'],
        startPage: 1,
        password: 'U2UaMFw5mSZsh95P',
        showDocumentLabel: true,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  Center(
          child: downloading ?
              Container (
                height: 120.0,
                width: 200.0,
                child: Card(
                  color: Colors.black,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 10.0,),
                      Text("Downloading Book: $progressString",
                      style: TextStyle(
                        color: Colors.white,
                      ),)
                    ],
                  ),
                ),
              )
              : Text("No Data"),
        )
      );
  }
}




