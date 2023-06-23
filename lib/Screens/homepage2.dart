import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_project/Screens/user_profile_screen.dart';

class UserProfileHomePage extends StatelessWidget {

  final TextEditingController _usernameControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final RxBool _iconBool = false.obs;

  IconData get _iconLight => Icons.wb_sunny_rounded;
  IconData get _iconDark => Icons.nights_stay;



  void submit(){
    if(!_formKey.currentState!.validate()) {
      return print("Not valid");
    }

    Get.to(() => UserProfileScreen(username:_usernameControl.text, isDarkMode:_iconBool.value));
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

    return Obx(() => GetMaterialApp(
      key: UniqueKey(),
      theme: _iconBool.value ? _darkTheme : _lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Image.network("https://github.com/fluidicon.png"),
          title: Text('Github Profile', style: TextStyle(color: Color(0xFF24292E),),),
          backgroundColor:Colors.grey,
          actions: [
            IconButton(
                onPressed: (){
                  _iconBool.toggle();
                  print("icon tapped");
                },
                icon: Icon(_iconBool.value ? _iconDark : _iconLight)
            ),
          ],
        ),
        body: Container(
          child:Form(
            key: _formKey,
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
                          controller: _usernameControl,
                          maxLength: 15006,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF28A745),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: submit,
                              child: Text("Submit"),
                                ),
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
    ));
  }
}
