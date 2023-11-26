import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';


// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
String palyer1;
String player2;
GameScreen({required this.palyer1,required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState(){
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_)=>""));
    _currentPlayer="X";
    _winner="";
    _gameOver= false;
  }

  void _resetGame(){
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_)=>""));
      _currentPlayer="X";
      _winner="";
      _gameOver= false;
    });
  }

  void _makeMove(int row, int col){
    if(_board[row][col]!=""||_gameOver){
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;
      if(_board[row][0]==_currentPlayer&&
          _board[row][1]==_currentPlayer&&
          _board[row][2]==_currentPlayer) {
        _winner = _currentPlayer;
      }
      else if(_board[0][0]==_currentPlayer&&
          _board[1][1]==_currentPlayer&&
          _board[2][2]==_currentPlayer){
        _winner = _currentPlayer;
      }
      else if(_board[0][col]==_currentPlayer&&
          _board[1][col]==_currentPlayer&&
          _board[2][col]==_currentPlayer) {
        _winner = _currentPlayer;
      }
      else if(_board[0][2]==_currentPlayer&&
          _board[1][1]==_currentPlayer&&
          _board[2][0]==_currentPlayer){
        _winner = _currentPlayer;
      }
      _currentPlayer = _currentPlayer == "X"?"O":"X";

      if(!_board.any((row) => row.any((cell) => cell==""))){
        _gameOver=true;
        _winner="Its a Tie";
      }
      if(_winner!=""){
        AwesomeDialog(context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again",
          title: _winner == "X" ? widget.palyer1 + " Won!":
                 _winner == "O" ? widget.player2 + " Won!":
                 "It's a Tie",
          btnCancelOnPress: (){
            _resetGame();
          }
        )..show();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 70),
          SizedBox(
            height: 120,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Turn:",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _currentPlayer=="X" ? widget.palyer1 + "($_currentPlayer)":
                      widget.player2 + "($_currentPlayer)",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _currentPlayer == "X" ? Colors.red:Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
         SizedBox(height: 20),
         Container(
           decoration: BoxDecoration(
             color: Colors.grey,
             borderRadius: BorderRadius.circular(10),
           ),
           margin: EdgeInsets.all(5),
           child: GridView.builder(
                itemCount: 9,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 3,
                ),
               itemBuilder: (context,index){
                  int row = index ~/3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: ()=> _makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFF0E1E3A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(_board[row][col],
                          style: TextStyle(
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == "X"? Colors.red:Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  );
               }
               ),
         ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: _resetGame,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  child: Text("Reset Game",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                  ));
                  widget.palyer1="";
                  widget.player2="";
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  child: Text("Restart Game",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
