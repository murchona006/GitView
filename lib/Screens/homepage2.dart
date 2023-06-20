import 'package:flutter/material.dart';
import 'package:inilabs_project/Screens/user_details.dart';
import 'package:inilabs_project/repositories_page.dart';

class UserProfileHomePage extends StatefulWidget {
  const UserProfileHomePage({Key? key}) : super(key: key);

  @override
  _UserProfileHomePageState createState() => _UserProfileHomePageState();
}

class _UserProfileHomePageState extends State<UserProfileHomePage> {
  TextEditingController _usernamecontrol = new TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  void submit(){
    if(!_formkey.currentState!.validate()) {
      return print("Not valid");
    }
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Userdetails(username:_usernamecontrol.text)));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Image.network("https://cdn-icons-png.flaticon.com/512/2111/2111612.png",
        ),//asset('assets/images/my_image.png'),
        title: Text('Github Profile', style: TextStyle(color: Color(0xFF24292E),),),
        backgroundColor:Color(0xFFF6F8FA)
      ),
      body:  Container(


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
                        backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTff9lNf9VpjVuKJ1cim6Ex0loEBOSYS5WwcnPGTRpYFXyhZeqFwGY9WWoTQQw9qvreaok&usqp=CAU"),
                        radius: 50,
                       ),

                      SizedBox(height: 10),




                      SizedBox(height: 20),

                        TextFormField(
                          controller: _usernamecontrol,
                          maxLength: 10,

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
                          //onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),

                          onPressed: () {
                            submit();
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>Userdetails(username: _usernamecontrol.text)));


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




    );


  }
}