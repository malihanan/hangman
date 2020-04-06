import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hangman/result.dart';
import 'package:hangman/util.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  int c = 0;
  String displayWord = "";

  @override
  void initState() {
    super.initState();
    displayWord = initWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: (c == 6)
                        ? ((MediaQuery.of(context).size.width / 2) - 84.5)
                        : ((MediaQuery.of(context).size.width / 2) - 78),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/hangman' + c.toString() + '.png',
                      height: 120,
                    ),
                  ),
                ],
              ),
              Text(
                displayWord,
                style: TextStyle(fontSize: 48),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: _getKeyPad(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getKeyPad() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _getLetterButton('Q'),
            _getLetterButton('W'),
            _getLetterButton('E'),
            _getLetterButton('R'),
            _getLetterButton('T'),
            _getLetterButton('Y'),
            _getLetterButton('U'),
            _getLetterButton('I'),
            _getLetterButton('O'),
            _getLetterButton('P'),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 17,
            ),
            _getLetterButton('A'),
            _getLetterButton('S'),
            _getLetterButton('D'),
            _getLetterButton('F'),
            _getLetterButton('G'),
            _getLetterButton('H'),
            _getLetterButton('J'),
            _getLetterButton('K'),
            _getLetterButton('L'),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 47,
            ),
            _getLetterButton('Z'),
            _getLetterButton('X'),
            _getLetterButton('C'),
            _getLetterButton('V'),
            _getLetterButton('B'),
            _getLetterButton('N'),
            _getLetterButton('M'),
          ],
        ),
      ],
    );
  }

  Widget _getLetterButton(String letter) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width / 12.5,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  color: _getLetterColor(letter),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: Colors.cyan[100],
              ),
            ),
            onTap: () {
              if (lettersGuessed.indexOf(letter) >= 0) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Already Guessed",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    letter,
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
                lettersGuessed += letter;
                if (secretWord.indexOf(letter) < 0) {
                  setState(() {
                    c += 1;
                  });
                }
                setState(() {
                  displayWord = formWord();
                });
                if (isWordGuessed() || c >= 6) {
                  Navigator.of(context).pop();
                  if (isWordGuessed()) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Result.fromData(true, c, secretWord);
                    }));
                  } else {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Result.fromData(false, c, secretWord);
                    }));
                  }
                }
              }
            },
          );
        },
      ),
    );
  }

  Color _getLetterColor(String letter) {
    if (lettersGuessed.indexOf(letter) >= 0) {
      if (secretWord.indexOf(letter) >= 0) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.blueGrey;
    }
  }
}
