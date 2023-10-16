import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_editor/image_merger.dart';
import 'package:music_editor/image_picker.dart';
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
        actions: [InkWell(
          onTap: () {
            // pickImageFromGallery();
            Navigator.push(context, MaterialPageRoute(builder: ((context)=> MergeImageAndAudioScreen())));
            
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.photo_album),
          ),
        )],
      ),
      body: Center(
        child: Column(
                children: [
                  if (showPlayer) ...[

                    // Text('Play video'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        child: AspectRatio(
                          aspectRatio: finalVideo.value.aspectRatio,
                          child: VideoPlayer(finalVideo),
                        ),
                      ),
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
                                'https://dl.espressif.com/dl/audio/gs-16b-2c-44100hz.mp3',
                            videoUrl:
                                'https://v3.cdnpk.net/videvo_files/video/premium/video0226/large_watermarked/03_Khomenko_15_fun_preview.mp4'))!;
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
