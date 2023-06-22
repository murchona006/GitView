import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inilabs_project/Screens/repositorylist.dart';
import 'package:inilabs_project/utils/user_provider.dart';
import 'package:http/http.dart' as http;


class UserProfileScreen extends StatefulWidget {


  final String username;

  const UserProfileScreen({Key? key, required this.username, required bool isDarkMode}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
   late final dynamic repository;
   var username;

  UserProvider userprovider = UserProvider();

  @override
  Widget build(BuildContext context) {
    var username = widget.username;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF24292E),
        title: Text(widget.username, style: TextStyle(color: Colors.white)),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/$username'),
        ),

      ),
      body: FutureBuilder<dynamic>(
        future: http.get(Uri.parse('https://api.github.com/users/$username')),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map<String, dynamic> userProfile = json.decode(snapshot.data.body);
            final String bio = userProfile['bio'];
            final String name = userProfile['name'];
            final int following = userProfile['following'];
            final int followers = userProfile['followers'];
            final int publicRepos = userProfile['public_repos'];

            return Container(
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
                          padding: const EdgeInsets.only(left:6),
                          child: Text(name,
                              style:
                              TextStyle(color: Colors.black, fontSize: 24, fontWeight:FontWeight.bold )),
                        ),
                        SizedBox(height: 8),
                        Text('@$username',
                            style: TextStyle(
                                    color: Colors.white, fontSize: 18)),

                ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Bio'),
                          subtitle: Text(bio ?? 'No Bio'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.people),
                          title: Text('Followers'),
                          subtitle: Text(followers.toString()),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.people_outline),
                          title: Text('Following'),
                          subtitle: Text(following.toString()),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            //print("Repositories found");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RepositoryList(username),
                              ),
                            );
                          },
                          child: ListTile(

                            leading: Icon(Icons.book),
                            title: Text('Public Repositories'),
                            subtitle: Text(publicRepos.toString()),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch user profile'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
