import 'package:adevindustries/constance/constance.dart';
import 'package:adevindustries/constance/routes.dart';
import 'package:adevindustries/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adevindustries/constance/global.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  bool isShowIndicator = false;

  @override
  void initState() {
    super.initState();
    _loadNextScreen();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 150).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();

    animation.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        isShowIndicator = true;
      }
    });
  }

  _loadNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, Routes.Introdution);
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: animation.value,
                  height: animation.value,
                  child: Image.asset(ConstanceData.appIcon),
                ),
                SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 16,
                  child: isShowIndicator
                      ? CupertinoActivityIndicator(
                          radius: 12,
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
