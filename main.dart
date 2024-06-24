import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    });
  }

  void _pauseStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
      _timer.cancel();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.reset();
    });
  }

  String _formatTime(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds = ((duration.inMilliseconds % 1000) / 10)
        .floor()
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds:$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_stopwatch.elapsed),
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _isRunning ? _pauseStopwatch : _startStopwatch,
                  child:
                      _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  onPressed: _resetStopwatch,
                  child: Icon(Icons.stop),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
