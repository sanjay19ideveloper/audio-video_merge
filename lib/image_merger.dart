import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_editor/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class MergeImageAndAudioScreen extends StatefulWidget {
  @override
  _MergeImageAndAudioScreenState createState() =>
      _MergeImageAndAudioScreenState();
}

class _MergeImageAndAudioScreenState extends State<MergeImageAndAudioScreen> {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  String? outputPath;
  File? _imageFile;
   bool showPlayer = false;
   late VideoPlayerController finalVideo;


  Future<void> mergeImageAndAudio() async {
    final imageFilePath = _imageFile?.path;
    const audioFilePath =
        'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';

    if (imageFilePath == null) {


      // Handle the case where no image is selected
      return;
    }

    final downloadsDirectory = await getApplicationDocumentsDirectory();
    outputPath = '${downloadsDirectory.path}/merged_video.mp4';

    final arguments = [
      '-i', imageFilePath,
      '-i', audioFilePath,
      '-c:v', 'mpeg4',
      '-c:a', 'aac',
      outputPath!,
    ];

    final result = await _flutterFFmpeg.executeWithArguments(arguments);
    if (result == 0) {
      // FFmpeg execution was successful, so you can now play the merged video
    } else {
      // Handle the case where FFmpeg execution failed
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }
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
        title: Text('Merge Image and Audio'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _pickImage();
              },
              child: Text('Pick an Image'),
            ),
            if (_imageFile != null)
              ElevatedButton(
                onPressed: () async {
                   try {
                        finalVideo = (await Utility().mergeAudioAndImage(
                            audioUrl:
                                'https://dl.espressif.com/dl/audio/gs-16b-2c-44100hz.mp3',
                            imageUrl:
                                _imageFile?.path))!;
                        finalVideo.initialize();
                        showPlayer = true;
                        setState(() {});
                      } catch (e) {
                        print("some went wrong $e");
                      }
                    },
                    child: const Text('Merge audio/video'),
                  ),
  
                //   await mergeImageAndAudio();
                  

                // },
                // child: Text('Merge Image and Audio'),
  
              SizedBox(height: 20),
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
                   if(showPlayer)  ElevatedButton(
                    onPressed: () async {
                      finalVideo.value.isPlaying
                          ? finalVideo.pause()
                          : finalVideo.play();
                      setState(() {});

                    },
                    child: Text(finalVideo.value.isPlaying ? 'pause' : 'play'),
                  ),
                  // Add this widget to display the seekbar



          ],
        ),
      ),
    );
  }
}
