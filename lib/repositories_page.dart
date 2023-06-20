// import 'package:flutter/material.dart';
// import 'package:github_app/models/repository.dart';
// import 'package:github_app/services/github_service.dart';
//
// class RepositoriesPage extends StatefulWidget {
//   final String userName;
//
//   RepositoriesPage({Key key, @required this.userName}) : super(key: key);
//
//   @override
//   // _RepositoriesPageState createState() => _RepositoriesPageState();
// // }
// //
// class _RepositoriesPageState extends State<RepositoriesPage> {
//   List<Repository> _repositories = [];
//   bool _isGridView = false;
//   bool _isLoading = true;
//   String _filterValue = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRepositories();
//   }
//
//   Future<void> _fetchRepositories() async {
//     try {
//       final service = GithubService();
//       final repositories = await service.getRepositories(widget.userName);
//       setState(() {
//         _repositories = repositories;
//       });
//     } catch (e) {
//       print(e.toString());
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Widget _buildListView() {
//     return ListView.builder(
//       itemCount: _repositories.length,
//       itemBuilder: (BuildContext context, int index) {
//         final repository = _repositories[index];
//         return Card(
//           child: ListTile(
//             onTap: () {
//               Navigator.pushNamed(context, '/repository',
//                   arguments: repository);
//             },
//             title: Text(repository.name),
//             subtitle: Text(repository.description ?? 'No Description'),
//             trailing: Text('${repository.stargazersCount} ★'),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildGridView() {
//     return GridView.builder(
//         gridDelegate:
//         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//     itemCount: _repositories.length,
//     itemBuilder: (BuildContext context, int index) {
//       final repository = _repositories[index];
//       return Card(
//         child: InkWell(
//           onTap: () {
//             Navigator.pushNamed(context, '/repository',
//                 arguments: repository);
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(repository.name),
//               SizedBox(height: 8),
//               Expanded(
//                 child: Text(
//                   repository.description ?? 'No Description',
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text('${repository.stargazersCount} ★'),
//             ],
//           ),
//         ),
//       ),
//     }
//     ),
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }


import 'package:flutter/material.dart';

class repositories extends StatefulWidget {
  const repositories({Key? key}) : super(key: key);

  @override
  State<repositories> createState() => _repositoriesState();
}

class _repositoriesState extends State<repositories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 15,
        width: 30,
        color: Colors.red,
      ),
    );
  }
}
