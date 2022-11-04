// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields

//import 'dart:js';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
/* import 'package:flutter/cupertino.dart'; */

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;

  String _password = '';
  bool _passwordShow = false;
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 255, 255, 255),
      body: Center(
          child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _showlogo(),
          _showemail(),
          _showpassword(),
          _showRememberme(),
          _showButtons(),
        ],
      )),
    );
  }

  Widget _showlogo() {
    return Image(
      image: AssetImage('images/logoIngreso.jpg'),
      width: 75,
      fit: BoxFit.fill,
    );
  }

  Widget _showemail() {
    // ignore: avoid_unnecessary_containers
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Digite su E-mail',
            labelText: 'Email',
            errorText: _emailShowError ? _emailError : null,
            prefixIcon: Icon(Icons.alternate_email),
            suffixIcon: Icon(Icons.email),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: ((value) => _email = value),
      ),
    );
  }

  Widget _showpassword() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Digite su password',
          labelText: 'Password',
          errorText: _passwordShowError ? _passwordError : null,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordShow
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                _passwordShow = !_passwordShow;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _showRememberme() {
    return CheckboxListTile(
        title: Text('Remember me!'),
        value: _rememberme,
        onChanged: ((value) {
          setState(() {
            _rememberme = value!;
          });
        }));
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _showLoginButton(),
            SizedBox(width: 20),
            _showRegisterButton(),
          ],
        )
      ]),
    );
  }

  Widget _showLoginButton() {
    return Expanded(
      child: ElevatedButton(
        child: Text('Login'),
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          return Color(0XFF120E43);
        })),
        onPressed: (() => _login()),
      ),
    );
  }

  Widget _showRegisterButton() {
    return Expanded(
      child: ElevatedButton(
        child: Text('Registro'),
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          return Color(0XFFE03B8B);
        })),
        onPressed: (() => _login()),
      ),
    );
  }

  void _login() async {
    setState(() {
      _passwordShow = false;
      if (!_validateFields()) {
        return;
      }
    });
  }

  bool _validateFields() {
    bool isValid = true;
    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Email obligatorio';
    } else if (!EmailValidator.validate(_email)) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Email inválido';
    } else {
      _emailShowError = false;
    }

    if (_password.isEmpty) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'Password Obligatorio';
    } else if (_password.length < 6) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'Mínimo 6 Caracteres';
    } else {
      _passwordShowError = false;
    }

    setState(() {});
    return isValid;
  }

  /*  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterUserScreen()));
  }

  RegisterUserScreen() {} */
}
