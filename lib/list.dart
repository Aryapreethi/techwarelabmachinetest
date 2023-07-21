
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Viewss extends StatefulWidget {
  const Viewss({Key? key}) : super(key: key);

  @override
  State<Viewss> createState() => _ViewssState();
}

class _ViewssState extends State<Viewss> {
  List<dynamic> data = [];

  Future<void> getData() async {
    http.Response response =
    await http.get(Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"));
    setState(() {
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print(responseData);
        data = responseData;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Employee List", style: TextStyle(color: Colors.black,fontSize: 15)),
        backgroundColor: Colors.cyan[700],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                data[index]['profile_image'] ?? '',
              ),
            ),
            title: Text(data[index]["name"] ?? '',style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index]["email"] ?? '',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
