import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Audio Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static final assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  String text = "Music";
  String filePath;
  Duration position = new Duration();
  Duration duration = new Duration();
  double sliderPosition = 0.0;
  double sliderMax = 100.0;
  Timer _everySecond;

  @override
  initState(){
    super.initState();
    _everySecond = Timer.periodic(Duration(microseconds: 1),(Timer T){
      setState(() {
        position = assetsAudioPlayer.currentPosition.value;
        if (position != null){
          sliderPosition = position.inMilliseconds.toDouble();
        }
      });
    });
  }

  _pressed() {
    setState(() {
      if (isPlaying) {
        isPlaying = false;
        assetsAudioPlayer.pause();
      }
      else {
        isPlaying = true;
        assetsAudioPlayer.play();
      }
    });
  }

  _stop() {
    assetsAudioPlayer.stop();
    isPlaying = false;
  }

  _add() async{
    filePath = await FilePicker.getFilePath(type: FileType.audio);
    try {
      await assetsAudioPlayer.open(
          Audio.file(filePath)
      );
    }catch(t){}
    setState(() {
      isPlaying = true;
      assetsAudioPlayer.play();
      duration = assetsAudioPlayer.current.value.audio.duration;
      sliderMax = duration.inMilliseconds.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
                  //+'Position'+sliderPosition.toString()+' SliderMax'+sliderMax.toString(),
              style: TextStyle(fontSize: 50,color: Colors.white),
            ),
            SizedBox(height: 30,),
            Slider(
              activeColor: Colors.pink,
              inactiveColor: Colors.white,
              value: sliderPosition,
              min: 0.0,
              max: sliderMax,
              onChanged: (double value) {
                setState(() {
                  sliderPosition = value;
                  position = new Duration(milliseconds: value.toInt());
                  assetsAudioPlayer.seek(position);
                });
              },
            ),
            SizedBox(height: 10,),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _add(),
                  iconSize: 50.0,
                  color: Colors.pink,
                ),
                IconButton(
                  icon: new Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () => _pressed(),
                  iconSize: 50.0,
                  color: Colors.pink,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () => _stop(),
                  iconSize: 50.0,
                  color: Colors.pink,
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.black45,
    );
  }
}