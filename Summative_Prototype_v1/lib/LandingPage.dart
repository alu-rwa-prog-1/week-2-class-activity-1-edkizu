import 'package:flutter/material.dart';
import 'package:riverpod_quiz/mainpage.dart';

// void main() => runApp(MaterialApp(
//       home: HomePage(),
//     ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color logoColor = Color(0xff25bcbb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xff022140),
      //   title: Text("Quiz Time"),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/AppBackGround.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              'assets/images/QuizTimeLogo.png',
              height: 250,
            ),
            SizedBox(
              height: 20,
            ),
            //Texts and Styling of them
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Welcome to QuizTime!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Test your wit, gain knowledge & impress your friends with QuizTime',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: MaterialButton(
                elevation: 0,
                height: 50,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => GridLayout()));
                },
                color: Color(0xffEA7A15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
