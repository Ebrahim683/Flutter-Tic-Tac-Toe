import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' show pi;

class GameBoardPage extends StatefulWidget {
  const GameBoardPage({super.key});

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  final ConfettiController _confettiController = ConfettiController();
  bool isPlaying = false;
  bool oTurn = true; //1st player
  List<int> boxData = [];
  int oScore = 0;
  int xScore = 0;
  List<String> valueXorO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'TIC TAC TOE',
          style: GoogleFonts.pressStart2p(
            textStyle: TextStyle(color: Colors.grey[400]),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      oTurn == true ? 'O\'s Turn' : 'X\'s Turn',
                      style: GoogleFonts.pressStart2p(
                        textStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Player O',
                              style: GoogleFonts.pressStart2p(
                                textStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 2,
                                width: 100,
                                color: Colors.grey[900],
                              ),
                            ),
                            Text(
                              oScore.toString(),
                              style: GoogleFonts.pressStart2p(
                                textStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Player X',
                              style: GoogleFonts.pressStart2p(
                                textStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 2,
                                width: 100,
                                color: Colors.grey[900],
                              ),
                            ),
                            Text(
                              xScore.toString(),
                              style: GoogleFonts.pressStart2p(
                                textStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onBoxTapped(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: itemBorder(index),
                        ),
                        child: Center(
                          child: Text(
                            valueXorO[index],
                            style: GoogleFonts.pressStart2p(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      height: 50,
                      color: Colors.grey,
                      onPressed: () {
                        resetGame(false);
                      },
                      child: Text(
                        'Reset Board',
                        style: GoogleFonts.pressStart2p(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      height: 50,
                      color: Colors.grey,
                      onPressed: () {
                        resetGame(true);
                      },
                      child: Text(
                        'Reset Game',
                        style: GoogleFonts.pressStart2p(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            gravity: 0.5,
            emissionFrequency: 0.2,
          ),
        ],
      ),
    );
  }

  void onBoxTapped(int index) {
    setState(() {
      if (oTurn) {
        valueXorO[index] = 'O';
      } else {
        valueXorO[index] = 'X';
      }
      oTurn = !oTurn;
      boxData.add(index);
      checkWinner();
    });
  }

  checkWinner() {
    if (valueXorO[0] == valueXorO[1] &&
        valueXorO[0] == valueXorO[2] &&
        valueXorO[0] != '') {
      showWinnerDialog('Winner is ${valueXorO[0]}', 0);
    } else if (valueXorO[3] == valueXorO[4] &&
        valueXorO[3] == valueXorO[5] &&
        valueXorO[3] != '') {
      showWinnerDialog('Winner is ${valueXorO[3]}', 3);
    } else if (valueXorO[6] == valueXorO[7] &&
        valueXorO[6] == valueXorO[8] &&
        valueXorO[6] != '') {
      showWinnerDialog('Winner is ${valueXorO[6]}', 6);
    } else if (valueXorO[0] == valueXorO[3] &&
        valueXorO[0] == valueXorO[6] &&
        valueXorO[0] != '') {
      showWinnerDialog('Winner is ${valueXorO[0]}', 0);
    } else if (valueXorO[1] == valueXorO[4] &&
        valueXorO[1] == valueXorO[7] &&
        valueXorO[1] != '') {
      showWinnerDialog('Winner is ${valueXorO[1]}', 1);
    } else if (valueXorO[2] == valueXorO[5] &&
        valueXorO[2] == valueXorO[8] &&
        valueXorO[2] != '') {
      showWinnerDialog('Winner is ${valueXorO[2]}', 2);
    } else if (valueXorO[0] == valueXorO[4] &&
        valueXorO[0] == valueXorO[8] &&
        valueXorO[0] != '') {
      showWinnerDialog('Winner is ${valueXorO[0]}', 0);
    } else if (valueXorO[2] == valueXorO[4] &&
        valueXorO[2] == valueXorO[6] &&
        valueXorO[2] != '') {
      showWinnerDialog('Winner is ${valueXorO[2]}', 2);
    } else {
      for (var i = 0; i < valueXorO.length; i++) {
        if (valueXorO[i] != '' && valueXorO.length == boxData.length) {
          showWinnerDialog('match draw', -1);
          break;
        }
      }
    }
  }

  addPoint(String player) {
    setState(() {
      if (player == 'O') {
        oScore += 1;
      } else if (player == 'X') {
        xScore += 1;
      } else {
        oScore = oScore;
        xScore = xScore;
      }
    });
  }

  void showWinnerDialog(String message, int index) {
    if (index >= 0) {
      showConfetti();
    }
    showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: Colors.grey[900],
          elevation: 20,
          content: SizedBox(
            height: 120,
            child: Center(
              child: Text(
                message,
                style: GoogleFonts.pressStart2p(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            MaterialButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.pop(context);
                resetGame(false);
              },
              child: Text(
                'Play again',
                style: GoogleFonts.pressStart2p(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    if (index != -1) {
      addPoint(valueXorO[index]);
    }
  }

  void showConfetti() async {
    _confettiController.play();
    Future.delayed(const Duration(seconds: 2), () {
      _confettiController.stop();
    });
  }

  void resetGame(bool fullReset) {
    setState(() {
      oTurn = true;
      boxData = [];
      valueXorO = [
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      if (fullReset) {
        oScore = 0;
        xScore = 0;
      }
    });
  }

  itemBorder(int index) {
    switch (index) {
      case 0 || 3:
        return Border(
          right: BorderSide(color: Colors.grey[400]!),
          bottom: BorderSide(color: Colors.grey[400]!),
        );
      case 1:
        return Border(
          bottom: BorderSide(color: Colors.grey[400]!),
        );
      case 2 || 5:
        return Border(
          left: BorderSide(color: Colors.grey[400]!),
          bottom: BorderSide(color: Colors.grey[400]!),
        );
      case 6:
        return Border(
          right: BorderSide(color: Colors.grey[400]!),
        );
      case 7:
        return Border(
          top: BorderSide(color: Colors.grey[400]!),
        );
      case 8:
        return Border(
          left: BorderSide(color: Colors.grey[400]!),
        );
    }
  }
}
