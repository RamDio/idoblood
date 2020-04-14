import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
 
// Creating String Var to Hold sent Email.  
final String user;
 
// Receiving Email using Constructor.
ProfileScreen({Key key, @required this.user}) : super(key: key);
 
// User Logout Function.
logout(BuildContext context){
 
  Navigator.pop(context);
 
}
 
@override
Widget build(BuildContext context) {
return MaterialApp(
  home: Scaffold(
      appBar: AppBar(title: Text('Profile Screen'),
      automaticallyImplyLeading: false),
      body: Center(
        child: Column(children: <Widget>[
 
          Container(
          width: 280,
          padding: EdgeInsets.all(10.0),
          child: Text('HI = ' + '\n' + user, 
                style: TextStyle(fontSize: 20))
            ),
 
          RaisedButton(
          onPressed: () {
            logout(context);
          },
          color: Colors.red,
          textColor: Colors.white,
          child: Text('Click Here To Logout'),
        ),
 
        ],)
        )
      )
    );
}
}