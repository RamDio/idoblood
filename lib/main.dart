
import 'package:flutter/material.dart';
// import 'package:idobloodapp/home/home.dart';
// import 'package:idobloodapp/register.dart';
// import 'login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idoblood/profilescreen.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 4),
      (){
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) =>Login(),
            ));
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Container(
          // child: Image.asset("asset/rlogo.png",height: 400,width: 400),
        ),
      )

    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // For CircularProgressIndicator.
  bool visible = false ;
 
  // Getting value from TextField widget.
  final userController = TextEditingController();
  final passwordController = TextEditingController();
 
Future userLogin() async{
 
  // Showing CircularProgressIndicator.
  setState(() {
  visible = true ; 
  });
 
  // Getting value from Controller
  String user = userController.text;
  String password = passwordController.text;
 
  // SERVER LOGIN API URL
  var url = 'https://idobloodadmin.000webhostapp.com/loginuser.php';
 
  // Store all data with Param Name.
  var data = {'username': user, 'password' : password};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
 
  // Getting Server response into variable.
  var message = jsonDecode(response.body);
 
  // If the Response Message is Matched.
  if(message == 'Login Matched')
  {
 
    // Hiding the CircularProgressIndicator.
      setState(() {
      visible = false; 
      });
 
    // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen(user : userController.text))
      );
  }else{
 
    // If Email or Password did not Matched.
    // Hiding the CircularProgressIndicator.
    setState(() {
      visible = false; 
      });
 
    // Showing Alert Dialog with Response JSON Message.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(message),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    );}
 
}
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: SingleChildScrollView(
    child: Center(
    child: Column(
      children: <Widget>[
 
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('User Login Form', 
                  style: TextStyle(fontSize: 21))),
 
        Divider(),          
 
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (userController){
            if (userController.isEmpty){
              return "Please Enter Some Text";
            }
            else if(userController.length<4){
              return 'It must be greate than 4';
            }
            return null;
          },
            controller: userController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Enter Your Email Here'),
        
          )
        ),
 
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (passwordController){
            if(passwordController.length<8){
              return "Please Input 8 characters";
            }
            else if(passwordController.isEmpty){
              return 'Input password please';
            }
            return null;
          },
            controller: passwordController,
            autocorrect: true,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter Your Password Here'),
          )
        ),
 
        RaisedButton(
          onPressed: userLogin,
          color: Colors.green,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
          child: Text('Click Here To Login'),
        ),

        RaisedButton(
          onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(
            builder: (context) =>Register(),
            ));
          }
          ),
 
        Visibility(
          visible: visible, 
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()
            )
          ),
 
      ],
    ),
  )));
}
  }





  class Register extends StatefulWidget {
    @override
    _RegisterState createState() => _RegisterState();
  }
  
  class _RegisterState extends State<Register> {
    // Boolean variable for CircularProgressIndicator.
  bool visible = false ;
 
  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final genderController = TextEditingController();
  final contactController= TextEditingController();
  final addressController=TextEditingController();
  final bloodtypeController=TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
 
Future userRegistration() async{
 
  // Showing CircularProgressIndicator.
  setState(() {
  visible = true ; 
  });
 
  // Getting value from Controller
  String firstname = fnameController.text;
  String lastname = lnameController.text;
  String gender= genderController.text;
  String contact=contactController.text;
  String address=addressController.text;
  String bloodtype=bloodtypeController.text;
  String username = userController.text;
  String password = passwordController.text;
 
  // SERVER API URL
  var url = 'https://idobloodadmin.000webhostapp.com/registeruser.php';
 
  // Store all data with Param Name.
  var data = {'firstname': firstname,'lastname': lastname,'gender':gender,'contact':contact,'address':address,'bloodtype':bloodtype, 'username': username, 'password' : password};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
 
  // Getting Server response into variable.
  var message = jsonDecode(response.body);
 
  // If Web call Success than Hide the CircularProgressIndicator.
  if(response.statusCode == 200){
  setState(() {
    visible = false; 
  });
}
 
  // Showing Alert Dialog with Response JSON Message.
  showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: new Text(message),
      actions: <Widget>[
        FlatButton(
          child: new Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
  );
 
}
 


    @override
    Widget build(BuildContext context) {
      return Scaffold(
  body: SingleChildScrollView(
    child: Center(
    child: Column(
      children: <Widget>[
 
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Register And Be A Hero Now', 
                  style: TextStyle(fontSize: 21))),
 
        Divider(),          
 
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (fnameController){
            if(fnameController.isEmpty){
              return "Firstname is Required";
            }
            return null;
          },
            controller: fnameController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Firstname'),
          )
        ),
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (lnameController){
            if(lnameController.isEmpty){
              return "lastname is Required";
            }
            return null;
          },
            controller: lnameController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Lastname'),
          )
        ),
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (genderController){
            if(genderController.isEmpty){
              return "Gender is Required";
            }
            return null;
          },
            controller: genderController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Gender'),
          )
        ),
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (contactController){
            if(contactController.isEmpty){
              return "number is Required";
            }else if(contactController.length<11)
            {
              return 'Phone number must be 11 digits';
            }
            return null;
          },
            controller: contactController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Contact'),
          )
        ),
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (addressController){
            if(addressController.isEmpty){
              return "address is Required";
            }
            return null;
          },
            controller: addressController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Address'),
          )
        ),
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (bloodtypeController){
            if(bloodtypeController.isEmpty){
              return "bloodtype is Required";
            }
            return null;
          },
            controller: bloodtypeController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Bloodtype'),
          )
        ),
 
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (userController){
            if(userController.isEmpty){
              return "Username is Required" ;
            }else if(userController.length<4){
              return "Must be at least 5 characters";
            }
            return null;
          },
            controller: userController,
            autocorrect: true,
            decoration: InputDecoration(hintText: 'Username'),
          )
        ),
 
        Container(
        width: 280,
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (passwordController){
            if(passwordController.isEmpty){
              return "Password is Required";
            }else if (passwordController.length<8){
              return 'Must have at least 8 characters';
            }
            return null;
          },
            controller: passwordController,
            autocorrect: true,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter Your Password Here'),
          )
        ),
 
        RaisedButton(
          onPressed: userRegistration,
          color: Colors.green,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text('Register'),
        ),

         RaisedButton(
           
          onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(
            builder: (context) =>Login(),
            
            ));
          },

          child: Text("Already a user, Login here"),
          ),
 
 
        Visibility(
          visible: visible, 
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()
            )
          ),
 
      ],
    ),
  )));
}
    }
  
