import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:logout_problem_solution/login.dart';
import 'api/register_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  RegisterAPI registerAPI = RegisterAPI();
  bool isLoading = false;

  bool loginError = false;
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late String name;
  late String username;
  late String password;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }


  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: (isLoading) ? _drawLoading() : _drawLoginForm(),
      ),
    );
  }

  Widget _drawLoginForm() {
    if( loginError ){
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Register Error'),
              RaisedButton(onPressed: (){
                setState(() {
                  loginError = false;
                });
              }  , child: Text('try Again' , style: TextStyle(
                  color: Colors.white
              ),),)
            ],
          ),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Name';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // TODO : Call Api for login
                  setState(() {
                    isLoading = true;
                  });
                  name = _nameController.text;
                  username = _usernameController.text;
                  password = _passwordController.text;

                  print( username );

                  var response = await registerAPI.register(
                      name,username, password);

                  if (response) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                    Fluttertoast.showToast(
                        msg: "The registration is done",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    setState(() {
                      // SharedPreferences sharedPreferences=CacheHelper.init();
                      // sharedPreferences.setBool("isLoggedIn",true);
                      // CacheHelper.putbool(key: "token", value: true);
                      // CacheHelper.putstring(key: "email", value: username);
                      // CacheHelper.putstring(key: "name", value: name);

                    });
                  } else {
                    loginError = true;
                  }
                  setState(() {
                    isLoading = false;
                    //authenticationAPI.login(email, password);
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}