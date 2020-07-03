import 'package:flutter/material.dart';

class ClickPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ClickPageState();
  }
}

class ClickPageState extends State<ClickPage> {

  ClickPageState();

  initState(){
    super.initState();
  }

  // Defining a variable for storing click state
  bool isPressed = false;

  // Click function for changing the state on click
  _pressed() {
    // This function is required for changing the state.
    // Whenever this function is called it refresh the page with new value
    setState((){
      if(isPressed) {
        isPressed = false;
      } else {
        isPressed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(isPressed ? Icons.play_arrow:Icons.pause),
              onPressed:() => _pressed(),
              iconSize: 50.0,
              color: Colors.pink,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(isPressed ? Icons.play_arrow : Icons.pause),
                  onPressed: () => _pressed(),
                ),
                ],
            ),
        ]),
      )
    );
  }
}