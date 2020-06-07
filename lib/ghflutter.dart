import 'dart:convert';
import 'package:ghflutter/main.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'member.dart';
import 'strings.dart';

class GHFlutterState extends State<GHFlutter> {
  var _members = <Member>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      body: ListView.builder(
          itemCount: _members.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return Divider();

            final index = position ~/ 2;

            return _buildRow(index);
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  _loadData() async {
    String dataURL = "http://willwoodard.com/meritbadge/members.json";
    http.Response response = await http.get(dataURL);
    setState(() {
      final membersJSON = json.decode(response.body);

      for (var memberJSON in membersJSON) {
        final member = Member(memberJSON["title"], memberJSON["patch_url"],
            memberJSON["bookname"]);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    String bookname;
    String title;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text("${_members[i].title}", style: TextStyle(fontSize: 25.0)),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[i].patchURL),
          radius: 30.0,
        ),
        onTap: () {
          print("${_members[i].bookname}");
          bookname = "${_members[i].bookname}";
          title = "${_members[i].title}";

          //open bookname.pdf in new window
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondRoute(title: title, bookname: bookname),
            ),
          );
        },
      ),
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => GHFlutterState();
}
