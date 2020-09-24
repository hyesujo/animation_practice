import 'dart:math';

import 'package:flutter/material.dart';

class GuiterApp extends StatefulWidget {
  @override
  _GuiterAppState createState() => _GuiterAppState();
}

class _GuiterAppState extends State<GuiterApp> with TickerProviderStateMixin{
  //color
  Color _backgroundColor = Color.fromRGBO(236, 226, 209, 1);
  Color _bottomColor = Color.fromRGBO(229, 220, 204, 1);
  //double
  double padding = 16.0;

  //string
  String title = 'product detail';
  String _image = 'assets/images/guitar.png';
  String description = 'The Fender American Elite Stratocaster takes the classic strat platform, arguably the most ubiquitous and innovative instrumnet available in a range of finishes and with your choice of maple, rosewood. Fender builds more than just guitars. Since 1946, Fender has been committed to crafting the highest quality instruments and using our expertise to inspire the next generation of guitarists. Tap into decades of experience anywhere, at any time, with the world-class instructors of Fender Play.';
  String _image1 = 'https://www.radiokorea.com/images/news/2020/06/23/347228/1.jpg';
  //bool
  bool isClicked = false;

 // transform animation
  AnimationController _transformAnimationController;
  Animation<double> transformAnimation;

  //slide animation
AnimationController _slideAnimationController;
Animation<double> slideAnimation;

//click event : animation forward $ reverse
 void _onClicked() {
   setState(() {
     isClicked = !isClicked;
     if(isClicked)  {
     _transformAnimationController.forward();
     _slideAnimationController.forward();
     } else {
       _transformAnimationController.reverse();
       _slideAnimationController.reverse();
     }
   });
 }

@override
  void initState() {
  //transform ani
    _transformAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this
    );
    // ..forward();

    transformAnimation = Tween<double>(begin: 0.0, end: pi /2 - 0.01).animate(
        CurvedAnimation(parent: _transformAnimationController,

        curve: Curves.fastLinearToSlowEaseIn),
    )..addListener(() { 
      setState(() {
      });
    });
      // ..addStatusListener((status) {
      //   setState(() {
      //     if(status == AnimationStatus.completed) {
      //       _transformAnimationController.reverse();
      //     } else if (status == AnimationStatus.dismissed) {
      //       _transformAnimationController.forward();
      //     }
      //   });
      // });

    //slide ani
    _slideAnimationController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this
    );
      // ..forward();

    slideAnimation = Tween<double>(begin: 0.0, end: 500.0).animate(
      CurvedAnimation(parent: _slideAnimationController,

          curve: Curves.fastLinearToSlowEaseIn),
    )..addListener(() {
      setState(() {
      });
    });
    //   ..addStatusListener((status) {
    //   setState(() {
    //     if(status == AnimationStatus.completed) {
    //       _slideAnimationController.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       _slideAnimationController.forward();
    //     }
    //   });
    // });


    super.initState();
  }

  @override
  void dispose() {
    _slideAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: isClicked ? Colors.grey[100].withOpacity(0.70) : _backgroundColor,
      body: Stack(
        children: <Widget>[
          //top transform page
          Positioned(
            top: -slideAnimation.value /2,
              left: 0,
            right: 0,
            height: screenHeight,
            child: InkWell(
              onTap: () {
                setState(() {
                _onClicked();
                });
              },
              child: Transform(
                transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(-transformAnimation.value),
                alignment: FractionalOffset.center,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.fastLinearToSlowEaseIn,
                  color: isClicked ?  Colors.white: _backgroundColor,
                  child: Stack(
                    children: [
                      Positioned(
                        top:200,
                        left: -padding * 4.8,
                        child: Transform.rotate(
                          angle: 1.56,
                          child: Text(
                            'Fender'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 75.0,
                              color: Colors.grey[600].withOpacity(0.50),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80.0,
                        left: 90.0,
                        right: 80.0,
                        bottom: 150.0,
                        child: Image.asset(
                          _image,
                        fit: BoxFit.cover,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //bottom slide page
          Positioned(
            top: screenHeight - slideAnimation.value * 1.17,
            left: 0,
            right: 0,
            height: screenHeight -81.0,
            child: Container(
              padding: EdgeInsets.only(
                top: 160.0,
                left: padding,
                right: padding,
                bottom: padding
              ),
              color:_bottomColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                  Spacer(),
                  Container(
                    height: 200.0,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Image.network(
                                _image1,
                                fit :BoxFit.cover
                            ),
                        ),
                        //center Icon
                        Positioned.fill(
                            child: Center(
                              child: Icon(Icons.arrow_right,
                              size: 60.0,
                              color: Colors.white
                                ,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //appbar
          Positioned(
            top: 0,
              left: padding,
            right: padding,
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(
                height: 40.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Icon(
                      isClicked ? Icons.close :
                      Icons.menu,
                  size: 28.0,
                  color: Colors.black
                  ),
                    //center text : title
                  Text(title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                    Container(
                      width: 28.0,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //bottom text
          Positioned(
            top: screenHeight -165.0 - slideAnimation.value / 1.3,
            left: padding,
            right: padding,
            child: Container(
              height: 105.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Fender \nAmerican\nElite Strat',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.0
                  ),
                  ),
                  Spacer(),
                  //spec
                 isClicked ?  Container() :
                 Text('Spec'.toUpperCase(),
                   style: TextStyle(
                       fontSize: 12.0,
                       color: Colors.black,
                       fontWeight: FontWeight.w600
                   ),
                 ),
                isClicked ? Container():
                Icon(
                    Icons.keyboard_arrow_down,
                    size: 12.0,
                    color: Colors.black
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
