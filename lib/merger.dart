import 'package:flutter/material.dart';
import 'package:music_editor/utility.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyVideoScreen extends StatefulWidget {
  @override
  _MyVideoScreenState createState() => _MyVideoScreenState();
}

class _MyVideoScreenState extends State<MyVideoScreen> {
  String outputPath = '';
  bool showPlayer = false;

  late VideoPlayerController finalVideo;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    finalVideo.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video and Audio Merge'),
      ),
      body: Center(
        child: Column(
                children: [
                  if (showPlayer) ...[
                    Text('Play video'),
                    AspectRatio(
                      aspectRatio: finalVideo.value.aspectRatio,
                      child: VideoPlayer(finalVideo),
                    ),
                  ],
                  // AspectRatio(
                  //   aspectRatio: _videoController.value.aspectRatio,
                  //   child: VideoPlayer(_videoController),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        finalVideo = (await Utility().mergeAudioAndVideo(
                            audioUrl:
                                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
                            videoUrl:
                                'https://v3.cdnpk.net/videvo_files/video/free/2012-09/large_watermarked/hd0456_preview.mp4'))!;
                        finalVideo.initialize();
                        showPlayer = true;
                        setState(() {});
                      } catch (e) {
                        print("some went wrong $e");
                      }
                    },
                    child: const Text('Merge audio/video'),
                  ),
                if(showPlayer)  ElevatedButton(
                    onPressed: () async {
                      finalVideo.value.isPlaying
                          ? finalVideo.pause()
                          : finalVideo.play();
                      setState(() {});
                    },
                    child: Text(finalVideo.value.isPlaying ? 'pause' : 'play'),
                  ),
                ],
              )
          
      ),
    );
  }
}
