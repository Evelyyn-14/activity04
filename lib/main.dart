//Myla Newby and Evelyn Escobedo

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  late AnimationController motionController;
  late Animation motionAnimation;

  double size = 20;
  void initState(){
    super.initState();
  
  
    motionController = AnimationController(
      duration: Duration(seconds: 2), 
      vsync: this, 
      lowerBound:0.5
    );

    motionAnimation = CurvedAnimation(
      parent: motionController, 
      curve: Curves.ease
    );
  
    motionController.forward();
    motionController.addStatusListener((status){
      setState(() {
        if(status == AnimationStatus.completed){
          motionController.reverse();
        } 
        else if (status == AnimationStatus.dismissed){
          motionController.forward();
        }
      });
    });

    motionController.addListener((){
      setState(() {
        size = motionController.value * 250;
      });
    });
    //motionController.repeat();
  }
  
  @override
  void dispose(){
    motionController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                child: Stack(children: <Widget>[
                  Center(
                    child: Container(
                      child: Stack(children: <Widget>[
                        Center(
                          child: new Container(
                            child: Image.asset('assets/images/heart.jpg'),
                            height: size,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

