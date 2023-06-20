import 'package:flutter/material.dart';

class Userdetails extends StatefulWidget {
  String username;
  Userdetails(
      {
         required this.username
      }
      );


  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.username, style: TextStyle(color: Color(0xFF24292E),),),
          centerTitle: true,
          leading: Image.network(""),
          backgroundColor:Color(0xFFF6F8FA)
       ),
    );
  }
}
