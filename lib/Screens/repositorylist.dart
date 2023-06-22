import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:inilabs_project/Screens/homepage2.dart';
import 'package:inilabs_project/Screens/repository_details.dart';

class RepositoryList extends StatefulWidget {
  String username;

  RepositoryList(this.username);

  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  late Map<String, dynamic> userData ;
  List<dynamic> repositories = [];

  Future<void> _fetchData() async {
    final userResponse = await http.get(Uri.parse(
        'https://api.github.com/users/${widget.username}'));

    if (userResponse.statusCode == 200) {
      setState(() {
        userData = json.decode(userResponse.body);
      });
    } else {
      throw Exception('Failed to fetch user data');
    }

    final repoResponse = await http.get(Uri.parse(
        'https://api.github.com/users/${widget.username}/repos'));

    if (repoResponse.statusCode == 200) {
      setState(() {
        repositories = json.decode(repoResponse.body);
      });
    } else {
      throw Exception('Failed to fetch repositories');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final name = userData['name'] ?? widget.username;
    final bio = userData['bio'] ?? '';

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(name, style: TextStyle(color: Colors.black),),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userData['avatar_url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () => UserProfileHomePage(),
              ),
            ],
          ),

          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final repo = repositories[index];
                  return GestureDetector(
                    onTap: () {
                    //print("Repositories found");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepositoryDetail(repository: repo),
                      ),
                    );
                  },
                    child: ListTile(
                      title: Text(repo['name'], style: TextStyle(fontSize:18, fontWeight:FontWeight.w500, color: Colors.blue),),
                      subtitle: Text(repo['description'] ?? ''),
                      leading: Icon(Icons.description),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  );
                },
                childCount: repositories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
