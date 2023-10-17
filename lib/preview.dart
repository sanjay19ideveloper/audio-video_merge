import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:music_editor/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);
  

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
  String? outputPath = '';

  bool showPlayer = false;
  late VideoPlayerController finalVideo;
  double sliderValue = 0.0;

  StreamController<Duration> positionStreamController =
      StreamController<Duration>();
      Future<void> mergeImageAndAudio() async {
    final imageFilePath = widget.picture.path;
    const audioFilePath =
        'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';

    if (imageFilePath == null) {
      // Handle the case where no image is selected
      return;
    }

    final downloadsDirectory = await getApplicationDocumentsDirectory();
    outputPath = '${downloadsDirectory.path}/merged_video.mp4';

    final arguments = [
      '-i',
      imageFilePath,
      '-i',
      audioFilePath,
      '-c:v',
      'mpeg4',
      '-c:a',
      'aac',
      outputPath!,
    ];

    final result = await flutterFFmpeg.executeWithArguments(arguments);
    if (result == 0) {
      // FFmpeg execution was successful, so you can now play the merged video
    } else {
      // Handle the case where FFmpeg execution failed
    }
  }
   void updatePosition() {
    if (finalVideo != null) {
      final position = finalVideo.value.position;
      positionStreamController.add(position);
      print("hello  $position");
    }
  }
   void onSliderChanged(double value) {
    finalVideo.seekTo(Duration(seconds: value.toInt()));
    setState(() {
      sliderValue = value;
    });
  }
  //  @override
  // void initState() {
  //  finalVideo.addListener(updatePosition);

  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
                    height: 300,
                    child: AspectRatio(
                      aspectRatio:finalVideo.value.aspectRatio,
                      child: VideoPlayer(finalVideo),
                    ),
                  ),
                  if (showPlayer)
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      finalVideo.value.isPlaying
                          ? finalVideo.pause()
                          : finalVideo.play();
                      setState(() {});
                    },
                    child: Icon(finalVideo.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                  ),
                  StreamBuilder<Duration?>(
                    stream: positionStreamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            Slider(
                              activeColor: Colors.green,
                              value: finalVideo.value.position.inSeconds
                                  .toDouble(),
                              onChanged: onSliderChanged,
                              min: 0.0,
                              max: finalVideo.value.duration.inSeconds
                                  .toDouble(),
                            ),
                            Text(
                                '${finalVideo.value.position.inSeconds}:${finalVideo.value.duration.inSeconds.toInt()}'),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),



          // Image.file(File(widget.picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(widget.picture.name),
          ElevatedButton(
                onPressed: () async {
                  try {
                    finalVideo = (await Utility().mergeAudioAndImage(
                        audioUrl:
                            'https://dl.espressif.com/dl/audio/gs-16b-2c-44100hz.mp3',
                        imageUrl: widget.picture.path))!;
                    finalVideo.initialize();
                    showPlayer = true;
                    finalVideo.addListener(() {
                      updatePosition();
                    });
                    setState(() {
                      
                    });
                  } catch (e) {
                    print("some went wrong $e");
                  }
                },
                child: const Text('Merge audio/video'),
              ),


        ]),
      ),
    );
  }
}