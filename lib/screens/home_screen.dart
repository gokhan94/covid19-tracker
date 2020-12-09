import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncov_app/screens/prevention_screen.dart';
import 'package:ncov_app/utils/const.dart';
import 'package:ncov_app/widget/country_list.dart';
import 'package:ncov_app/widget/covid_news.dart';
import 'package:ncov_app/widget/global_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(backgroundColor: AppColors.mainColor, elevation: 0,),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade300, Colors.indigo.shade800],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(child: Text('Covid 19    Application' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22, color: Colors.white70),)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade500, Colors.indigo.shade700],
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.event_note, color: Colors.deepPurple.shade900, size: 30,),
                title: Text("Corona News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white70),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CovidNews()));},
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.deepPurple.shade800, size: 30,),
                title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white70),),
              ),
            ],
          ),
        )
      ),
      body: Column(
        children: [
          Container(
            height: 160,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Image.asset("assets/images/virus2.png", fit: BoxFit.fill,),
                  _buildHeader(context),
                ],
              )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: "Semptoms ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blueGrey),
                      children: [
                        TextSpan(
                            text: "COVID 19",
                            style: TextStyle(color: AppColors.mainColor))
                      ]),
                ),
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      _buildSemptom(context, "assets/images/1.png", "High Fever"),
                      _buildSemptom(context, "assets/images/2.png", "Dry cough"),
                      _buildSemptom(context, "assets/images/3.png", "Tiredness"),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Prevention",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PreventionScreen()));
                  },
                  child: Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: [
                        _buildPrevention(context, "assets/images/a10.png",  "Wash"),
                        _buildPrevention(context, "assets/images/a6.png",  "Disinfectant"),
                        _buildPrevention(context, "assets/images/a8.png",  "Distance"),
                        _buildPrevention(context, "assets/images/a9.png",  "Mask"),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white70,
                              offset: Offset(1, 1),
                              spreadRadius: 1,
                              blurRadius: 3)
                        ]),
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/images/map.png"),
                        RichText(
                          text: TextSpan(
                            text: "GLOBAL DATA\n",
                            style: TextStyle(
                                color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
                            children: [
                              TextSpan(
                                text: "Worldwide Results",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => GlobalScreen()));
                          },
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Covid Data",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Corona Virüs Data",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CountryList()));
                  },
                  child: Text(
                    "All Country Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.indigoAccent,
                  onPressed: () {},
                  child: Text(
                    "Click",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSemptom(BuildContext context, String imagePath, String text) {
    return Column(
      children: [
        Container(
          width: 185,
          height: 100,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white70, Colors.indigo.shade400],
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    spreadRadius: 1,
                    blurRadius: 3)
              ]),
          margin: EdgeInsets.only(top: 5, right: 20),
          child: Row(
            children: [
              Image.asset(imagePath),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: text,
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold, fontSize: 18))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildPrevention(BuildContext context, String imagePath, String text) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 80,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white70, Colors.indigo.shade400],
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    spreadRadius: 1,
                    blurRadius: 3)
              ]),
          margin: EdgeInsets.only(top: 5, right: 20),
          child: Row(
            children: [
              Image.asset(imagePath),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: text,
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold, fontSize: 18))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
