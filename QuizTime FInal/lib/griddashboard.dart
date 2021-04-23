import 'package:quiztime_app/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Science",
      subtitle: "Explore different questions",
      event: "10 Questions",
      img: "images/science.png");

  Items item2 = new Items(
    title: "Sports",
    subtitle: "Get yourself challenged!!",
    event: "10 Questions",
    img: "images/sports.png",
  );
  Items item3 = new Items(
    title: "Movies",
    subtitle: "It's about Netflix and Chill",
    event: "10 Questions",
    img: "images/movies.png",
  );
  Items item4 = new Items(
    title: "Music",
    subtitle: "Do u like Music??",
    event: "10 Questions",
    img: "images/music.png",
  );
  Items item5 = new Items(
    title: "Business",
    subtitle: "How Professional are you?",
    event: "10 Questions",
    img: "images/business.png",
  );
  Items item6 = new Items(
    title: "AfricanHistory",
    subtitle: "Claim your past!!",
    event: "10 Questions",
    img: "images/africanhistory.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    // var color = Colors.blue.shade900;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 80,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.w900)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 10,
                              fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 11,
                              fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QuizScreen()));

                  // Fluttertoast.showToast(
                  //   msg: title + " " + "Category",
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.CENTER,
                  //   backgroundColor: Colors.red,
                  //   textColor: Colors.white,
                  //   fontSize: 24.0,
                  // );
                },
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
