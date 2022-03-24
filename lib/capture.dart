import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volume_control/volume_control.dart';

class CapturePage extends StatefulWidget {

  const CapturePage({Key? key}) : super(key: key);

  @override
  State<CapturePage> createState() => CapturePageState();

}

class CapturePageState extends State<CapturePage> {

  int volume = 0;
  bool isToggleVisibility = false;

  double getUpdatedVolume() {
    int fixedVolume = volume.round();
    double updatedVolume = fixedVolume / 100;
    return updatedVolume;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (event) {
        Timer timer = new Timer(
          Duration(
            seconds: 3
          ),
          () {
            setState(() {
              isToggleVisibility = false;
            });
          }
        );
      },
      onVerticalDragUpdate: (event) {
        Offset offsetDelta = event.delta;
        double verticalOffsetDelta = offsetDelta.dy;
        print('verticalOffsetDelta: ${verticalOffsetDelta}');
        bool isSoundUp = verticalOffsetDelta > 0 && volume < 100;
        bool isSoundDown = verticalOffsetDelta < 0 && volume > 0;
        setState(() {
          if (isSoundUp) {
            isToggleVisibility = true;
            volume++;
            double updatedVolume = getUpdatedVolume();
            VolumeControl.setVolume(updatedVolume);
          } else if (isSoundDown) {
            isToggleVisibility = true;
            volume--;
            double updatedVolume = getUpdatedVolume();
            VolumeControl.setVolume(updatedVolume);
          }
        });
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 150, 150, 150),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: (
            isToggleVisibility ?
              Stack(
                key: Key('show'),
                children: [
                  Positioned(
                    top: 150,
                    left: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (
                            volume == 0 ?
                              Icons.volume_off
                            :
                              Icons.volume_up
                          ),
                          size: 48,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        (
                          true ?
                            Container(
                              child: Text(
                                '$volume',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 255, 255, 255)
                                )
                              ),
                              margin: EdgeInsets.only(
                                left: 25
                              )
                            )
                          :
                            Container()
                        )
                      ]
                    ),
                  )
                ]
              )
            :
              Row(
                key: Key('hide')
              )
          ),
        )
      )
    );
  }

}