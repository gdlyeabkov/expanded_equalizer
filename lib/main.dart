import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volume_control/volume_control.dart';

import 'capture.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Softtrack Эквалайзер',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        '/main': (context) => const MyHomePage(),
        '/capture': (context) => const CapturePage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  double volume = 0;
  var contextMenuBtns = {
    'Выход'
  };

  get getVolumeLabelContent {
    int fixedVolume = volume.round();
    String rawVolume = fixedVolume.toString();
    return rawVolume;
  }

  double getUpdatedVolume() {
    int fixedVolume = volume.round();
    double updatedVolume = fixedVolume / 100;
    return updatedVolume;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Softtrack Эквалайзер'),
        backgroundColor: Color.fromARGB(255, 125, 125, 125),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/capture');
            },
            child: Icon(
              Icons.crop_square,
              color: Color.fromARGB(255, 255, 255, 255)
            )
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return contextMenuBtns.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice)
                );
              }).toList();
            },
            child: Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 255, 255, 255)
            ),
            onSelected: (menuItemName) {
              if (menuItemName == 'Выход') {
                SystemNavigator.pop();
                exit(0);
              }
            }
          )
        ]
      ),
      backgroundColor: Color.fromARGB(255, 150, 150, 150),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(
                15
              ),
              height:  500,
              width:  215,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 115, 115, 115)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [],
                  ),
                  Row(
                    children: [
                      Text(
                        'Громкость',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 15
                        ),
                        child: Text(
                          '${getVolumeLabelContent}',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0)
                          )
                        )
                      )
                    ]
                  )
                ]
              )
            ),
            Container(
              child: new Transform(
                alignment: FractionalOffset.center,
                transform: new Matrix4.identity()..rotateZ(-90 * 3.1415927 / 180),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      min: 0,
                      max: 100,
                      value: volume,
                      onChanged: (value) {
                        setState(() {
                          volume = value;
                          double updatedVolume = getUpdatedVolume();
                          VolumeControl.setVolume(updatedVolume);
                        });
                      }
                    )
                  ]
                )
              )
            )
          ]
        )
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 125, 125, 125),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'О программе'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.bar_chart,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'Эквалайзера'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'Музыкальный\nплеер'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.radio,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'Радио'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'Настройки'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.share,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'Поделитесь\nприложением'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'Оцените приложение'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              ),
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color.fromARGB(255, 175, 175, 175)
                  ),
                  Container(
                    child: Text(
                      'О программе'
                    ),
                    margin: EdgeInsets.only(
                      left: 25
                    )
                  )
                ]
              )
            ]
          ),
          padding: EdgeInsets.all(
            15
          )
        )
      )
    );
  }
}
