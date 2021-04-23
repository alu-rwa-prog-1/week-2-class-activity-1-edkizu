import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiztime_app/categories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';



class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}
bool isObscurePassword = true;
// final User user = await firebaseAuth.currentUser();

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User user;
  File profilePhoto;

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
    // Function to Prompt Image Upload Start(Gallery Opens)
    Future getProfilePhoto() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        profilePhoto = image;
        print("Image_Path: $profilePhoto");
      });
    }

    // Function to upload Profile Picture to Firebase
    Future uploadProfilePic(BuildContext context) async {
      // Getting filename & the firebase storage reference
      String fileName = basename(profilePhoto.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      // uploading the files
      UploadTask uploadTask = firebaseStorageRef.putFile(profilePhoto);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
        setState(() {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture updated Successfully!')));
        })
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff022140),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Categories()));

          }
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/appbackground.png'), fit: BoxFit.cover),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1)),
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              //Check if Profile Photo has been used else use default profile photo
                              image:profilePhoto == null
                                ? NetworkImage('${user.photoURL}')
                                  // : AssetImage('images/profile.jpg'),
                                  : FileImage(profilePhoto),
                              // (profilePhoto!=null)?Image.file(profilePhoto,fit: BoxFit.fill,)
                            )),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ), onPressed: () {
                                getProfilePhoto();
                            },
                            )
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              buildTextField("Full Name", "${user.displayName}", false),
              buildTextField("Email", "${user.email}", false),
              // buildTextField("Password", "***********", true),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 72.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 15, letterSpacing: 2, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          uploadProfilePic(context);
                        },
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextField(
    String labelText, String placeholder, bool isPasswordTextField) {
  return Padding(
    padding: EdgeInsets.all(30),
    child: TextField(
      obscureText: isPasswordTextField ? isObscurePassword : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField ?
          IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                  onPressed: () {
                  }
                  )
              : null,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.only(left: 10, bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    ),
  );
}
