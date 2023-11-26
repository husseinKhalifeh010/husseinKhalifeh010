import 'package:flutter/material.dart';
import 'package:untitled2/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter Players names:',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold ,
              color: Colors.white,
            ),),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: player1Controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.white),
                ),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.red),
                ),
                hintText: "Player 1 Name",
                hintStyle: TextStyle(color: Colors.white),
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return "please Enter Player 1 Name";
                }
                return null;
              },
            ),
            ),
            Padding(padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: player2Controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.white),
                  ),
                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.red),
                  ),
                  hintText: "Player 2 Name",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                validator: (value){
                  if(value==null||value.isEmpty){
                    return "please Enter Player 2 Name";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => GameScreen
                    (palyer1: player1Controller.text,
                      player2: player2Controller.text
                    ),
                  ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),

                ),
                padding: EdgeInsets.symmetric(vertical: 17,horizontal:20 ),
                child: Text("Start Game",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
              ),
            ),
          ],
        ),
    ),
    );
  }
}
