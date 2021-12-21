// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_this

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currenly;
  var humidity;
  var windSpeed;
  var name;

  Future getWether() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=istanbul&units=metric&appid=2e0d87662406a6673a23dfbbcfc629e4"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currenly = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.name = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWether();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white38,
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.blueGrey[700],
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  SizedBox(height: 45),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      name != null ? name.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    temp != null ? temp.toString() + "\u00B0" : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      currenly != null ? currenly.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.black,
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Hava Sıcaklık Derecesi"),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u00B0"
                          : "Loading"),
                    ),
                    ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.blue,
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text(
                        "Bu Gün Hava Durumu",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Text(description != null
                          ? description.toString() + "\u00B0"
                          : "Loading"),
                    ),
                    ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.yellowAccent[100],
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Güneş Isı Oranı"),
                      trailing: Text(
                          humidity != null ? humidity.toString() : "Loading"),
                    ),
                    ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.white54,
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Rüzgar Şiddeti"),
                      trailing: Text(
                          windSpeed != null ? windSpeed.toString() : "Loading"),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
