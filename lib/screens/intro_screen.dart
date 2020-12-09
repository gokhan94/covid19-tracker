import 'package:flutter/material.dart';
import 'package:ncov_app/screens/home_screen.dart';
import 'package:ncov_app/utils/const.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.mainColor,
          AppColors.mainColor.withOpacity(.3),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter
            ),

        ),
        child: Stack(
          children: [
            _buildHeaderWidget(),
            _buildBottomWidget(context)
          ],
        ),
      ),
    );
  }

  Widget _buildBottomWidget(BuildContext context) {
    return  Positioned(
      bottom: 50,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "nCOV19",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              "corona virus cases",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .80,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, offset: Offset(1,3)),
                    ]
                ),
                child: Center(
                  child: Text("GET START",
                      style: TextStyle(
                          color: AppColors.mainColor, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/images/logo.png")),
    );
  }
}
