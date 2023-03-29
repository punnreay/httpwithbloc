import 'package:blochttpget/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.e});
  final todo e;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // Center(
          //   child: CircleAvatar(
          //     maxRadius: 60,
          //     backgroundImage: NetworkImage(e.avatar),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Text(
            e.title! + " " + e.description!,
            style: TextStyle(fontSize: 30),
          ),
        ],
      )),
    );
  }
}
