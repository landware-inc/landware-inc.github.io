import 'package:flutter/material.dart';
import 'package:kakao_login_test/common/commondata.dart';
import 'package:kakao_login_test/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_login_test/screens/roungescreen.dart';
import 'package:dio/dio.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;

  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryVlidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    } else {
      print('Validation Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/red.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 90, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? '스마일부동산' : 'Back!',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(isSignupScreen ? 'Signup to continue' : 'Login to continue',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 배경
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.only(top: 20),
                  height: isSignupScreen ? 280 : 250,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      color: !isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                      letterSpacing: 1.0,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if(!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 50,
                                      color: Colors.orange,
                                    ),
                                ]
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                  children: [
                                    Text(
                                      'Signup',
                                      style: TextStyle(
                                        color: isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                        letterSpacing: 1.0,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if(isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 50,
                                        color: Colors.orange,
                                      ),
                                  ]
                              ),
                            ),
                          ],
                        ),
                        if(isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(1),
                                    validator: (value) {
                                      if(value!.isEmpty || value.length < 4) {
                                        return 'Please enter at least 4 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userName = value!;
                                    },
                                    onChanged: (value) {
                                      userName = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'User Name',
                                      hintStyle: TextStyle(
                                        color: Palette.textColor1,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    key: ValueKey(2),
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    validator: (value) {
                                      if(value!.isEmpty || !value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Palette.textColor1,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    obscureText: true,
                                    key: ValueKey(3),
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    validator: (value) {
                                      if(value!.isEmpty || value.length < 7) {
                                        return 'Password must be at least 7 characters long';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Palette.textColor1,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                ],
                            ),
                          ),
                        ),
                        if(!isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(4) ,
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged:  (value) {
                                      userEmail = value;
                                    },
                                    validator: (value) {
                                      if(value!.isEmpty || !value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Palette.textColor1,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    obscureText: true,
                                    key: ValueKey(5),
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    validator: (value) {
                                      if(value!.isEmpty || value.length < 7) {
                                        return 'Password must be at least 7 characters long';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Palette.textColor1,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
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
            // 텍스트 폼필드
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              top: isSignupScreen ? 430 : 390,
                right: 0,
                left: 0,
                child: Center(
                  child: Container (
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        if(isSignupScreen) {
                          _tryVlidation();
                          try{
                            final newUser = await _authentication.createUserWithEmailAndPassword(
                                email: userEmail ,
                                password: userPassword
                            );

                            if(newUser != null) {
                              final dio = Dio();

                              final response = await dio.post(
                                  '$appServerURL/signup',
                                  data: {
                                    'email': userEmail,
                                    'uid': newUser.user!.uid,
                                    'name': userName,
                                  }
                              );
                              dio.close();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoungeScreen()
                                  ));
                            }
                          } catch(e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please check your email or password'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        }
                        if(!isSignupScreen) {
                          _tryVlidation();
                          try{
                            final newUser = await _authentication.signInWithEmailAndPassword(
                                email: userEmail ,
                                password: userPassword
                            );

                            if(newUser != null) {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoungeScreen()
                                  ));
                            }
                          } catch(e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please check your email or password'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            //전송버튼
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              top: isSignupScreen ? MediaQuery.of(context).size.height - 125 :
                      MediaQuery.of(context).size.height - 165,
                right: 0,
                left: 0,
                child: Column (
                  children: [
                    Text(isSignupScreen ? 'Or Signup With' : 'Or Login With'),
                    SizedBox(height: 10),
                    TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(155, 40),
                          backgroundColor: Palette.googleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: Icon(Icons.add),
                        label: Text('Google'),
                    ),
                  ],
                )
            ),
            //구글 로그인 버튼
          ],
        ),
      ),
    );
  }
}
