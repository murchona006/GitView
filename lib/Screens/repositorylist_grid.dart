import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inilabs_project/Screens/repository_details.dart';
import 'package:inilabs_project/Screens/repositorylist.dart';

class RepositorylistGrid extends StatefulWidget {
  String username;

  RepositorylistGrid(this.username);

  @override
  _RepositorylistGridState createState() => _RepositorylistGridState();
}

class _RepositorylistGridState extends State<RepositorylistGrid> {
  final userData = Rx<Map<String, dynamic>?>(null);
  final repositories = Rx<List<dynamic>>([]);

  Future<void> _fetchData() async {
    final userResponse = await http.get(
        Uri.parse('https://api.github.com/users/${widget.username}'));

    if (userResponse.statusCode == 200) {
      setState(() {
        userData.value = json.decode(userResponse.body);
      });
    } else {
      throw Exception('Failed to fetch user data');
    }

    final repoResponse = await http.get(
        Uri.parse('https://api.github.com/users/${widget.username}/repos'));

    if (repoResponse.statusCode == 200) {
      setState(() {
        repositories.value = json.decode(repoResponse.body);
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
    final name = userData.value?['name'] ?? widget.username;
    final bio = userData.value?['bio'] ?? '';

    return Obx(() => Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              name,
              style: TextStyle(color: Colors.black),
            ),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userData.value?['avatar_url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.list_rounded),
                onPressed: () =>  Navigator.push(context,
      MaterialPageRoute(builder: (context) => RepositoryList(widget.username)),
    ),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: repositories.value
                  .map((repo) => GestureDetector(
                onTap: () {
                  Get.to(
                          () => RepositoryDetail(repository: repo));
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          repo['name'],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          repo['description'] ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
