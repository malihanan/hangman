import 'package:flutter/material.dart';
import 'package:hangman/result.dart';
import 'package:hangman/game.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  Game game;

  @override
  void initState() {
    super.initState();
    game = Game();
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
                    width: (game.wrongLettersGuessed.length == 6)
                        ? ((MediaQuery.of(context).size.width / 2) - 84.5)
                        : ((MediaQuery.of(context).size.width / 2) - 78),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/hangman' +
                          game.wrongLettersGuessed.length.toString() +
                          '.png',
                      height: 120,
                    ),
                  ),
                ],
              ),
              Text(
                game.displayWord,
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
    List<List<String>> letters = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M']
    ];
    return Column(
      children: <Widget>[
        _getRow(0, letters),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _getRow(1, letters),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 49.0),
          child: _getRow(2, letters),
        ),
      ],
    );
  }

  Row _getRow(int rowIndex, List<List<String>> letters) {
    List<Widget> row = [];
    for (int i = 0; i < letters[rowIndex].length; i++) {
      row.add(_getLetterButton(letters[rowIndex][i]));
    }
    return Row(
      children: row,
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
              if (game.displayWordList.contains(letter) ||
                  game.wrongLettersGuessed.contains(letter)) {
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
                setState(() {
                  game.guessLetter(letter);
                });
                if (game.isWordGuessed() || game.hasLost()) {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Result.fromData(game);
                  }));
                }
              }
            },
          );
        },
      ),
    );
  }

  Color _getLetterColor(String letter) {
    if (game.displayWordList.contains(letter)) {
      return Colors.green;
    } else if (game.wrongLettersGuessed.contains(letter)) {
      return Colors.red;
    } else {
      return Colors.blueGrey;
    }
  }
}
