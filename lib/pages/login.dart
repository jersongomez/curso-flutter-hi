import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/circle.dart';
import '../widgets/input_text.dart';
import '../api/account.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email = '', _password = '';

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      final result = await AccountApi.login(email: _email, password: _password);
      if (result != null) {
        Navigator.pushNamed(context, "home");
      } else {
        print("Login incorrecto");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -size.width * 0.25,
                right: -size.width * 0.15,
                child: Circle(radius: size.width * 0.4, colors: [
                  Colors.pink,
                  Colors.pinkAccent,
                ]),
              ),
              Positioned(
                top: -size.width * 0.25,
                left: -size.width * 0.1,
                child: Circle(
                    radius: size.width * 0.3,
                    colors: [Colors.orange, Colors.deepOrange]),
              ),
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SafeArea(
                      child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: size.height * 0.13),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/hi.svg',
                            width: 65,
                            height: 65,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 30)
                            ]),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Hello again. \n Welcome back.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            height: 1.2,
                            color: Color(0xff161F3D)),
                      ),
                      SizedBox(height: 90),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              InputText(
                                label: "EMAIL ADDRESS",
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (text.contains("@")) {
                                    _email = text;
                                    return null;
                                  }
                                  return "Ingrese un email valido";
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InputText(
                                label: "PASSWORD",
                                isSecure: true,
                                validator: (text) {
                                  if (text.length > 5) {
                                    _password = text;
                                    return null;
                                  }
                                  return "Ingrese una contraseña valida";
                                },
                              ),
                            ],
                          )),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(5),
                          child: Text(
                            "Sign in",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: _submit,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "New to Friendly Desi?",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          CupertinoButton(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "signUp");
                            },
                          )
                        ],
                      )
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
