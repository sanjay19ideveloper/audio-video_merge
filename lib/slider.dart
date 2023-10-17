import 'package:flutter/material.dart';



class MySliderApp extends StatefulWidget {
  @override
  _MySliderAppState createState() => _MySliderAppState();
}

class _MySliderAppState extends State<MySliderApp> {
  double _sliderValue = 0.0;

  void _onSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Slider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Slider Value: $_sliderValue'),
            Row(
              children: [
                Icon(Icons.play_arrow),
                Slider(
                  value: _sliderValue,
                  onChanged: _onSliderChanged,
                  min: 0.0,
                  max: 100.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
