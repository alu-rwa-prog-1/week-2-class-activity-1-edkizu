import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_quiz/quiz_screen.dart';
// import 'package:homepage/quiz_screen.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: GridLayout(),
//     );
//   }
// }

// ignore: must_be_immutable
class GridLayout extends StatelessWidget {
  List<String> events = [
    "Sports",
    "Business",
    "Science",
    "African History",
    "Music",
    "Movies",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/AppBackGround.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 100.0),
          child: Container(
            child: GridView(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: events.map((title) {
                //Looping through all items in a list
                return GestureDetector(
                  child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: getCardByTitle(title),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QuizScreen()));

                    Fluttertoast.showToast(
                      msg: title + " " + "Category",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 24.0,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Sports")
      img = "assets/images/Sports.png";
    else if (title == "Music")
      img = "assets/images/Music.png";
    else if (title == "Movies")
      img = "assets/images/Movies.png";
    else if (title == "African History")
      img = "assets/images/AfricanHistory.png";
    else if (title == "Science")
      img = "assets/images/Science.png";
    else
      img = "assets/images/Business.png";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
            child: new Stack(
              children: <Widget>[
                new Image.asset(
                  img,
                  width: 60.0,
                  height: 100.0,
                )
              ],
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
