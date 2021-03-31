
import 'package:clock_bedtime/pages/clock_bedtime.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 28, 33, 1),
      body: SafeArea(
        child: Column(
          children: [
            renderAppbar(),
            renderTitle(),
            ClockBedtime(),
          ],
        ),
      ),
    );
  }

  Widget renderTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Text(
        "Next Wake Up Only",
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }


  Widget renderAppbar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cancel",
            style: TextStyle(fontSize: 20, color: Colors.orange),
          ),
          Text("Done",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange))
        ],
      ),
    );
  }
}
