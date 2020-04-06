import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman/play.dart';

class Result extends StatelessWidget {
  final bool success;
  final int c;
  final String secretWord;

  Result.fromData(
    this.success,
    this.c,
    this.secretWord,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getResult(),
            Text(
              "Word: " + secretWord,
              style: TextStyle(fontSize: 20),
            ),
            _getStars(),
            FlatButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Next Word",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              color: Colors.cyan,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Play();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getResult() {
    if (success) {
      return Column(
        children: <Widget>[
          Image.asset(
            'images/win.png',
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              "Victory :)",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Image.asset(
            'images/lose.png',
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              "Bettter Luck\n Next Time :(",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      );
    }
  }

  Widget _getStars() {
    if (success) {
      if (c == 0)
        return Image.asset(
          "images/star3.png",
          height: 50,
        );
      else if (c <= 2)
        return Image.asset(
          "images/star2.png",
          height: 50,
        );
      else
        return Image.asset(
          "images/star1.png",
          height: 50,
        );
    } else {
      return Image.asset(
        "images/star0.png",
        height: 50,
      );
    }
  }
}
