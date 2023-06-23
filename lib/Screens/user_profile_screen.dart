import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inilabs_project/Screens/repositorylist_grid.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final bool isDarkMode;

  const UserProfileScreen({
    Key? key,
    required this.username,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final Rx<Map<String, dynamic>> userProfile = Rx({});

  @override
  void initState() {
    fetchUserProfile();
    super.initState();
  }

  Future<void> fetchUserProfile() async {
    try {
      final response =
      await http.get(Uri.parse('https://api.github.com/users/${widget.username}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        userProfile(data);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF24292E),
        title: Text(widget.username, style: TextStyle(color: Colors.white)),
        leading: CircleAvatar(
          backgroundImage:
          NetworkImage('https://avatars.githubusercontent.com/${widget.username}'),
        ),
      ),
      body: Obx(() => SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                color: Color(0xFFD0D7DE),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                          userProfile.value['name'] ?? '',
                          style: TextStyle(
                              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text(
                        '@${widget.username}',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(25.0),
                child: SafeArea(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Bio', style: TextStyle(fontWeight: FontWeight.w500,fontSize:20, color: Colors.blue)),
                        subtitle: Text(userProfile.value['bio'] ?? 'No Bio'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.people),
                        title: Text('Followers',style: TextStyle(fontWeight: FontWeight.w500,fontSize:20, color: Colors.blue)),
                        subtitle: Text(userProfile.value['followers'].toString()),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.people_outline),
                        title: Text('Following',style: TextStyle(fontWeight: FontWeight.w500,fontSize:20, color: Colors.blue)),
                        subtitle: Text(userProfile.value['following'].toString()),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          //print("Repositories found");
                          Get.to(() => RepositorylistGrid(widget.username));
                        },
                        child: ListTile(
                          leading: Icon(Icons.book),
                          title: Text('Public Repositories',style: TextStyle(fontWeight: FontWeight.w500,fontSize:20, color: Colors.blue)),
                          subtitle: Text(userProfile.value['public_repos'].toString()),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
