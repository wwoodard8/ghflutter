import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

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
