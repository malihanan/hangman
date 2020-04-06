import 'dart:math';

import 'package:english_words/english_words.dart';

String secretWord;
String lettersGuessed;

String initWord() {
  lettersGuessed = "";
  secretWord = generateRandomWord();
  print(secretWord);
  lettersGuessed = getGuessedLetters();
  return formWord();
}

String generateRandomWord() {
  int n;
  do {
    n = Random.secure().nextInt(all.length);
  } while (all[n].length <= 5 || all[n].length > 9);
  return all[n].toUpperCase();
}

String getGuessedLetters() {
  String l;
  for (int i = 0; i < (secretWord.length / 3); i++) {
    int n = Random.secure().nextInt(secretWord.length);
    l = secretWord[n];
    if (lettersGuessed.indexOf(l) < 0)
      lettersGuessed += l;
    else
      i++;
  }
  return lettersGuessed;
}

String formWord() {
  String word = "";
  for (int i = 0; i < secretWord.length; i++) {
    if (lettersGuessed.indexOf(secretWord[i]) >= 0)
      word += secretWord[i];
    else
      word += "_ ";
  }
  return word;
}

bool isWordGuessed() {
  int j;
  for (int i = 0; i < secretWord.length; i++) {
    for (j = 0; j < lettersGuessed.length; j++) {
      if (secretWord[i] == lettersGuessed[j]) break;
    }
    if (j == lettersGuessed.length) return false;
  }
  return true;
}
