import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inilabs_project/Screens/repository_details.dart';
import 'package:inilabs_project/Screens/repositorylist_grid.dart';

class RepositoryList extends StatefulWidget {
  String username;

  RepositoryList(this.username);

  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {


  final userData = Rx<Map<String, dynamic>?>(null);
  final repositories = Rx<List<dynamic>>([]);

  Future<void> _fetchData() async {
    final userResponse = await http.get(Uri.parse(
        'https://api.github.com/users/${widget.username}'));

    if (userResponse.statusCode == 200) {
      setState(() {
        userData.value = json.decode(userResponse.body);
      });
    } else {
      throw Exception('Failed to fetch user data');
    }

    final repoResponse = await http.get(Uri.parse(
        'https://api.github.com/users/${widget.username}/repos'));

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

    return Obx(()=>
        Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(name, style: TextStyle(color: Colors.black),),
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
                    icon: Icon(Icons.grid_view),
                     onPressed: () => Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => RepositorylistGrid(widget.username)),
                     ),




                  ),
                ],
              ),

              SliverPadding(
                padding: EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final repo = repositories.value[index];
                      return GestureDetector(
                        onTap: () {
                        //print("Repositories found");
                          Get.to(() => RepositoryDetail(repository: repo));
                      },
                        child: ListTile(
                          title: Text(repo['name'], style: TextStyle(fontSize:18, fontWeight:FontWeight.w500, color: Colors.blue),),
                          subtitle: Text(repo['description'] ?? ''),
                          leading: Icon(Icons.description),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      );
                    },
                    childCount: repositories.value.length,
                  ),
                ),
              ),
            ],
          ),

       ),
    );
  }
}








