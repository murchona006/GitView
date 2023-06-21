import 'package:flutter/material.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final dynamic repository;

  const RepositoryDetailsScreen({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository['name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${repository['name']}'),
            SizedBox(height: 8),
            Text('Description: ${repository['description'] ?? 'No description'}'),
            SizedBox(height: 8),
            Text('Language: ${repository['language'] ?? 'Unknown'}'),
            SizedBox(height: 8),
            Text('Created at: ${repository['created_at']}'),
            SizedBox(height: 8),
            Text('Updated at: ${repository['updated_at']}'),
          ],
        ),
      ),
    );
  }
}