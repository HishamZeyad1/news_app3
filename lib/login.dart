import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logout_problem_solution/CacheHelper.dart';
import 'api/authentication_api.dart';
import 'package:logout_problem_solution/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;

  bool loginError = false;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late String username;
  late String password;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: (isLoading) ? _drawLoading() : _drawLoginForm(),
      ),
    );
  }

  Widget _drawLoginForm() {
    print("loginError:$loginError");
    if( loginError ){
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login Error'),
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
    height: 25,
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
    height: 25,
    ),
    SizedBox(
    width: double.infinity,
    child: RaisedButton(
      color:Colors.blue,

      onPressed: () async {
    if (_formKey.currentState!.validate()) {
    // TODO : Call Api for login
    setState(() {
    isLoading = true;
    });

    username = _usernameController.text;
    password = _passwordController.text;

    // print( username );

    var response = await authenticationAPI.login(
    username, password);
    print("response:$response");

    if (response) {
      Fluttertoast.showToast(
          msg: "The Login is done",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    Navigator.push(context,
    MaterialPageRoute(builder: (context) {
    return HomeScreen();
    }));
    setState(() {
    // SharedPreferences sharedPreferences=CacheHelper.init();
    // sharedPreferences.setBool("isLoggedIn",true);
    //   CacheHelper.putstring(key: "username", value: username);
      // CacheHelper.putbool(key: "name", value: name);
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
        'LOGIN',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    ),
          SizedBox(
            height: 10,
          ),

    SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color:Colors.blue,

        onPressed: () async {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return Register();
          }));
        },
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
          SizedBox(
            height: 10,
          ),
    SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color:Colors.blue,
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

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