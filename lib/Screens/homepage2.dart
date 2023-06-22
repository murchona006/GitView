import 'package:flutter/material.dart';
import 'package:inilabs_project/Screens/user_profile_screen.dart';


class UserProfileHomePage extends StatefulWidget {

  const UserProfileHomePage({Key? key}) : super(key: key);

  @override
  _UserProfileHomePageState createState() => _UserProfileHomePageState();

}
  class _UserProfileHomePageState extends State<UserProfileHomePage> {
  TextEditingController _usernamecontrol = new TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  bool _iconBool = false;
  IconData _iconLight = Icons.wb_sunny_rounded;
  IconData _iconDark = Icons.nights_stay;
  late bool isDarkMode ;


  void submit(){

  if(!_formkey.currentState!.validate()) {
  return print("Not valid");
  }

  Navigator.of(context).push(MaterialPageRoute(builder:(context)=> UserProfileScreen(username:_usernamecontrol.text, isDarkMode:_iconBool)));
  print("User found");



  }


  @override
  Widget build(BuildContext context) {

    ThemeData _lightTheme = ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.light
    );

    ThemeData _darkTheme = ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800]
    );

  return MaterialApp(
    theme: _iconBool ? _darkTheme : _lightTheme,
  debugShowCheckedModeBanner: false,
  home: Scaffold(
  appBar: AppBar(
  leading:Image.network("https://github.com/fluidicon.png"),
  title: Text('Github Profile', style: TextStyle(color: Color(0xFF24292E),),),
  backgroundColor:Colors.grey,
      actions: [
      IconButton(

      onPressed: (){
        setState(() {
          _iconBool = !_iconBool;
          print("icon tapped");
        });
  },
      icon: Icon(_iconBool ? _iconDark : _iconLight)
      ),
    ],
  ),
  body: Container(


  child:Form(
  key: _formkey,
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,

  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Container(

  child: SafeArea(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  CircleAvatar(
    backgroundImage:NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTff9lNf9VpjVuKJ1cim6Ex0loEBOSYS5WwcnPGTRpYFXyhZeqFwGY9WWoTQQw9qvreaok&usqp=CAU"),
  radius: 50,
  ),

  SizedBox(height: 10),


  SizedBox(height: 20),

  TextFormField(
  controller: _usernamecontrol,
  maxLength: 15006,

  decoration: InputDecoration(


  border: OutlineInputBorder(
  borderSide:BorderSide(
  color: Colors.red,
  width:10,
  ),
  ),

  hintText: "Enter Your Github Username",
  ),

  validator: (value){
  if(value!.isEmpty){
  return "Please enter username";

  }

  },


  ),

  SizedBox(height: 20),

  ElevatedButton(

  style: ElevatedButton.styleFrom(
  backgroundColor: Color(0xFF28A745),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),

  onPressed: () {
  submit();



  },
  child: Text("Submit"),
  ),


  ],


  ),
  ),
  ),
  ],
  ),
  ),
  ),


  ),
  );


  }
  }


