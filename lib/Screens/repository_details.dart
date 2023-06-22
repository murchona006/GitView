import 'package:flutter/material.dart';

class RepositoryDetail extends StatelessWidget {
  final dynamic repository;

  RepositoryDetail({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository['name'], style:TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFF24292E),
        elevation: 0,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(repository['description'] ?? '', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
          ),
           SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Language: ${repository['language'] ?? 'Unknown'}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Forks: ${repository['forks_count']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Watchers: ${repository['watchers_count']}'),
          ),
        ],
      ),
    );
  }
}