import 'package:flutter/material.dart';
import 'play.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.red,
        brightness: Brightness.dark,
        fontFamily: 'Pangolin',
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white10,
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(
            fontFamily: 'Pangolin',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hangman"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/hangman6.png',
                  height: 120,
                ),
              ),
              Text(
                'H_NG__N',
                style: TextStyle(fontSize: 48),
              ),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: GestureDetector(
                  child: Image.asset(
                    'images/play.png',
                    width: 80,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Play();
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
