import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoColor = Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Making the app bar transparent
          backgroundColor: Color(0xff022140),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/appbackground.png"),
            fit: BoxFit.cover,
          )),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildHeaderLogo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 27),
                  child: Text(
                    'Sign in to QuizTime to continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Enter your email and password below to continue to QuizTime',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 13),
                    // TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextField(
                    nameController, Icons.account_circle, 'Username'),
                SizedBox(height: 20),
                _buildTextField(passwordController, Icons.lock, 'Password'),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () async {
                      // User firebaseUser;
                      // firebaseAuth
                      //     .signInWithEmailAndPassword(
                      //         email: 'j.wambua@alustudent.com',
                      //         password: 'demoPassword123')
                      //     .then((authResult) {
                      //   setState(() {
                      //     firebaseUser = authResult.user;
                      //   });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return QuizScreen();
                      }));
                      //   print(firebaseUser.email);
                      // });
                    },
                    color: Color(0xffEA7A15),
                    child: Text('Log In',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () async {
                      //Here goes the logic for Google SignIn discussed in the next section
                      final GoogleSignInAccount googleUser =
                          await googleSignIn.signIn();
                      final GoogleSignInAuthentication googleAuth =
                          await googleUser.authentication;

                      final AuthCredential credential =
                          GoogleAuthProvider.credential(
                              idToken: googleAuth.idToken,
                              accessToken: googleAuth.accessToken);

                      final User user =
                          (await firebaseAuth.signInWithCredential(credential))
                              .user;
                    },
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.google),
                        SizedBox(width: 10),
                        Text('Sign-in with Google',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }

  _buildHeaderLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/quiztimelogo.png',
          height: 54,
        ),
      ],
    );
  }

  // Function to build the Text Fields for user input
  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: secondaryColor, border: Border.all(color: Colors.blue)),
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              // prefix: Icon(icon),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
