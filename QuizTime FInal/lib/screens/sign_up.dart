import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiztime_app/categories.dart';
import 'package:quiztime_app/screens/loginscreen.dart';
import 'package:quiztime_app/screens/profile_screen.dart';
import 'package:quiztime_app/authentication/verify_email_Screen.dart';

// import 'main.dart';
import '../authentication/authentication.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _SignUpScreenState extends State<SignUpScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoColor = Color(0xff25bcbb);

  String userEmail, userPassword, userName;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User user;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Making the app bar transparent
          backgroundColor: Color(0xff022140),
          leading: Icon(Icons.arrow_back, color: Colors.white),
          elevation: 0,
        ),
        body: buildContainer(context));
  }

  Container buildContainer(BuildContext context) {
    return Container(
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
                'Sign Up for QuizTime to continue',
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
                'Enter your details below to create your QuizTime profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
                // TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Building the Username Text Field Input Area
            _buildUsernameField(),
            SizedBox(height: 20),
            // Building the Email Text Field Input Area
            _buildEmailField(),
            SizedBox(height: 20),
            // Building the Password Text Field Input Area
            _buildPasswordField(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45)),
                onPressed: () {
                  authenticateUser.createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((_) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => VerifyEmail()));
                  });
                },
                color: Color(0xffEA7A15),
                child: Text('Sign Up with Email',
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45)),
                onPressed: () {
                  this.click();
                },
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign Up with Google',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
            ),
            // SizedBox(height: 100),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'or',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Sign In Here',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Go To Sign In Page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ))
          ],
        ),
      ),
    );
  }

  _buildHeaderLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/quiztimelogo.png',
          height: 60,
        ),
      ],
    );
  }

  // Function to build the Text Fields for user input
  _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       style: BorderStyle.solid,
        //       color: Colors.white,
        //     ),
        // borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextField(
          key: Key("emailField"),
          // Limiting Input type to only Email Addresses
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),

            // Font Awesome Package Icons for Flutter
            // Envelope for email
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: FaIcon(
                FontAwesomeIcons.envelope,
                size: 18,
              ),
            ),
            hintText: 'Enter Email',
          ),
          // Linking the Email variable created to our input value
          onChanged: (value) {
            setState(() {
              userEmail = value.trim();
            });
          },
        ),
      ),
    );
  }

  // Function to build the Password Input Text Field
  _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        color: Colors.white,
        child: TextField(
          key: Key("passwordField"),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Colors.white),
            // Font Awesome Package Icons for Flutter
            // Key for password
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: FaIcon(
                FontAwesomeIcons.key,
                size: 18,
              ),
            ),
            hintText: 'Set Password',
          ),
          // Linking the Password variable created to our input value
          onChanged: (value) {
            setState(() {
              userPassword = value.trim();
            });
          },
        ),
      ),
    );
  }

  // Function to build the Username Input Text Field
  _buildUsernameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        color: Colors.white,
        child: TextField(
          key: Key("usernameField"),
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            // Font Awesome Package Icons for Flutter
            // Key for password
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: FaIcon(
                FontAwesomeIcons.male,
                size: 18,
              ),
            ),
            hintText: 'Set Username',
          ),
          // Linking the Password variable created to our input value
          onChanged: (value) {
            setState(() {
              userName = value.trim();
              userName = user.displayName;
            });
          },
        ),
      ),
    );
  }

  // Logic for when user clicks login Button
  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Categories()))
        });
  }
}
