import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:music_editor/camera.dart';
import 'package:music_editor/reels.dart';
import 'package:video_player/video_player.dart';

class MySliderApp extends StatefulWidget {
  final VideoPlayerController finalVideo;

  const MySliderApp({super.key, required this.finalVideo});

  @override
  MySliderAppState createState() => MySliderAppState();
}

class MySliderAppState extends State<MySliderApp> {
  StreamController<Duration> positionStreamController =
      StreamController<Duration>();

  VideoPlayerController? videoPlayer;
 

  @override
  void initState() {
    videoPlayer = widget.finalVideo;
    videoPlayer?.initialize().then((value) {
      videoPlayer?.play();
      videoPlayer?.addListener(() {
        positionStreamController.add(videoPlayer!.value.position);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    videoPlayer?.seekTo(const Duration(seconds: 0));
    videoPlayer?.pause();
    positionStreamController.close();
    super.dispose();
  }

  void _onSliderChanged(double value) {
    videoPlayer?.seekTo(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: SizedBox(
                height: 300,
                child: AspectRatio(
                  aspectRatio: videoPlayer!.value.aspectRatio,
                  child: VideoPlayer(videoPlayer!),
                ),
              ),
              title: const Text('Original audio'),
              subtitle: const Text('use audio'),
            ),
          ),
          InkWell(
            onTap: ()async {
               await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value,finalVideo: widget.finalVideo,))));
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const CameraPage(cameras:value)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child:const Center(child: Text('Use Audio',style: TextStyle(color: Colors.white),))),
            ),
          ),
          Container(child:  StreamBuilder<Duration?>(
            stream: positionStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        widget.finalVideo.value.isPlaying
                            ? widget.finalVideo.pause()
                            : widget.finalVideo.play();
                        setState(() {});
                      },
                      child: Icon(widget.finalVideo.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                    ),
                    Slider(
                      activeColor: Colors.green,
                      value: videoPlayer!.value.position.inSeconds.toDouble(),
                      onChanged: _onSliderChanged,
                      min: 0.0,
                      max: videoPlayer!.value.duration.inSeconds.toDouble(),
                    ),
                    Text(
                        '${videoPlayer?.value.position.inSeconds}:${videoPlayer?.value.duration.inSeconds.toInt()}'),
                  ],
                );
              }
              return const SizedBox(
                child: Text('Processing...'),
              );
            },
          ),)
       
         
        ],
      ),
    );
  }
}
