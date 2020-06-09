import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  String url = "http://willwoodard.com/meritbadge/law.pdf";
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    super.initState();
    Pspdfkit.setLicenseKey("HmQTOnpLMtNGjLovoUsUY3OH/EJJQ/SyZzs0wUwq8dc5rHdAajWb6v9Dgdk2mSsZZ85FPqvQGDJMANhnyzdrhAK8srR50exd5Iw3unfKPsB8+F1ixYa9HuHIjsw0y7RwA6FLPV/hdigDE+K3qeZMal0Pwfhz3HqMJgARjY715U8Oh47An9ycg2/AW2frufAkZ8LD4SqYuiBGiwgg5m4/6UV0jyWOuLbxJNoWJSOfJoS8KgZVJEll07ywCKTFtCAzxHUTRiPBpMAo7TbJgf9fshm0ewew4YpKnpKn+VedMUiNoQuZyzU9dlMlXElEPRmwu5JxkUkSJf1h7k7Cw7502iijRfzo/rLTonr2gaPPgxfCvyBuYhfTRmVx7gBmCwRbtxQNnnGZQ7hk9+PrTHSWDKuP9p8OMbjhIl1nFR0QkTcWoMLBbWDd1yYYVoGZjWSM");

    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromURL(url);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loading ? Center(
        //child: RaisedButton(
        //  onPressed: () {
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //          builder: (context) =>
        //              GHFlutterApp(),
        //        ));
        //  },
        //  child: Text('Back to list'),
          child: CircularProgressIndicator(),) :
        PDFViewer(document: _doc,),
    );
  }
}
