import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiztime_app/screens/loginscreen.dart';
import 'package:quiztime_app/screens/profile_screen.dart';
import 'griddashboard.dart';
import 'main.dart';
import 'authentication/authentication.dart';

// void main() => runApp(MaterialApp(home: Home()));

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => new CategoriesState();
}

class CategoriesState extends State<Categories> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User user;
  File profilePhoto;
  Future getProfilePhoto() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profilePhoto = image;
      print("Image_Path: $profilePhoto");
    });
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }
  initUser() async {
    user = firebaseAuth.currentUser;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/appbackground.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => UserProfile()));
                        //   },
                        // ),
                        Image.asset(
                          "images/quiztimelogo.png",
                          width: 50,
                          height: 100,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: profilePhoto == null
                                  ? NetworkImage('${user.photoURL}')
                                  : FileImage(profilePhoto),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,8,0),
                              child: Text(
                                " ${user.displayName}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // Text("____"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text('Edit Profile'),
                                // style: ButtonStyle(padding: EdgeInsets.all(10)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UserProfile()));
                                },

                              ),
                            )
                          ],
                        ),
                        // Text(
                        //   "|",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     // fontWeight: FontWeight.bold,
                        //     fontSize: 50,
                        //   ),
                        // ),
                        // Image.asset(
                        //   "images/coin.png",
                        //   width: 40,
                        //   height: 100,
                        // ),
                        // Column(
                        //   children: [
                        //     Text(
                        //       " Points:",
                        //       style: GoogleFonts.openSans(
                        //         textStyle: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 15 ,
                        //             fontWeight: FontWeight.normal),
                        //       ),
                        //     ),
                        //     Text(
                        //       "2700",
                        //       style: GoogleFonts.openSans(
                        //         textStyle: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Let's Play!!",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Pick a Category",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Color(0xffa29aac),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Log Out",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            alignment: Alignment.topCenter,
                            icon: FaIcon(
                              FontAwesomeIcons.signOutAlt,
                              color: Colors.white,
                              size: 24,
                            ),
                            // Log Out Function Goes Here
                            onPressed: () async {
                              try {
                                await authenticateUser.signOut();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              }
                              // If Error Return null
                              catch (e) {
                                print(e.toString());
                                return null;
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 40,
            // ),
            GridDashboard()
          ],
        ),
      ),
    );
  }
}
