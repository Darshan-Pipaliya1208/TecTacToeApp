import 'dart:math';

import 'package:flutter/material.dart';

class Tictactoe extends StatefulWidget {
  const Tictactoe({super.key});

  @override
  State<Tictactoe> createState() => _TictactoeState();
}

class _TictactoeState extends State<Tictactoe> {
  List<String> list = List.filled(9, '');

  int cnt = 0;

  String resDec = '';
  String Iswon = "";
  String Drow = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        title: const Center(child: Text("Tic Tac Toe")),
        backgroundColor: Colors.lightGreen,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 40, fontStyle: FontStyle.italic),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Colors.orange,
                margin: EdgeInsets.all(30),
                elevation: 30,
                child: Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              makeButton(0),
                              makeButton(1),
                              makeButton(2),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              makeButton(3),
                              makeButton(4),
                              makeButton(5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              makeButton(6),
                              makeButton(7),
                              makeButton(8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              resDec,
              style: TextStyle(fontSize: 30, color: Colors.lightGreen),
            )),
            ElevatedButton(
              onPressed: () {
                reset();
              },
              child: Text("Reset"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  makeButton(int index) {
    return Expanded(
      child: Center(
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 30,
          color: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: InkWell(
            onTap: () {
              if (list[index] == '' && Iswon == "") {
                list[index] = "X";

                checkForGameOver();

                robotTurn();

                setState(() {});
              } else {
                if (Iswon.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You Won So Reset First")));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Already Fill")));
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                list[index],
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkwinner(int i, int i1, int i2) {
    if (Iswon.isNotEmpty) return;
    if (list[i] == list[i1] && list[i1] == list[i2] && list[i] != '') {
      resDec = 'Player ' + list[i] + ' Winner!';
      Iswon = "Won";
      setState(() {});
    }
  }

  void reset() {
    setState(() {
      list = List.filled(9, '');
      resDec = '';
      Iswon = '';
    });
  }

  void robotTurn() {
    if (Iswon.isNotEmpty) {
      return;
    }

    while (true) {
      int ran = Random().nextInt(list.length);
      if (list[ran].isEmpty) {
        list[ran] = "O";
        checkForGameOver();
        break;
      }
    }
    setState(() {});
  }

  void checkForGameOver() {
    checkwinner(0, 1, 2);
    checkwinner(3, 4, 5);
    checkwinner(6, 7, 8);
    checkwinner(0, 3, 6);
    checkwinner(1, 4, 7);
    checkwinner(2, 5, 8);
    checkwinner(0, 4, 8);
    checkwinner(2, 4, 6);

    if (Iswon.isEmpty) {
      //draw
      // Drow = 'DRAW BETWEEN "X" and "0"';
      var count = 0;
      for (int i = 0; i < list.length; i++) {
        if (list[i].isNotEmpty) {
          count++;
        }
      }
      if (count == list.length) {
        Iswon = "Draw";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("DRAW BETWEEN 'X' and 'O' and press RESET button")));
        setState(() {});
      }
    }
    setState(() {});
  }
}
