// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map? data;

  @override
  Widget build(BuildContext context) {
    data = data != null
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map?;

    print(data);

    //set background
    String bgImage = data!['isDaytime'] ? 'day.png' : 'night.jpg';
    Color? bgColor =
        data?['isDayTime'] ?? true ? Colors.blue : Colors.indigo[700]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              0,
              120.0,
              0,
              0,
            ),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(
                      context,
                      '/location',
                      arguments: data,
                    );
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'time': result['time'],
                        'isDaytime': result['isDaytime'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location,
                      color: Color.fromARGB(255, 61, 14, 11)),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Color.fromARGB(255, 61, 14, 11)),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data?['location'] ?? '',
                        style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: Colors.white))
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data?['time'] ?? '',
                  style: TextStyle(fontSize: 66.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
