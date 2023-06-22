import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:inilabs_project/model/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier{
   late User user;


    Future<Map<String, dynamic>?>getUserProfile(String username) async {

     try{
     final responseData = await http.get(Uri.parse('https://api.github.com/users/$username'));
     if (responseData.statusCode == 200) {

       final Map<String, dynamic>? responseMap = jsonDecode(responseData.body);
       print(responseMap);
       return responseMap;

     } else {
       throw Exception('Failed to fetch user repositories');
     }

    }catch(e){
      print(e);

    }

  }
}