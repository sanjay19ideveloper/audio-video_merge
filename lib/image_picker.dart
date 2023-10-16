import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_editor/utility.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _pickedImage;
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


  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    } else {
      // User canceled the image picker.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _pickedImage != null
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_pickedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery();
              },
              child: Text('Pick Image from Gallery'),
            ),
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
                        
                        // finalVideo = (await Utility().mergeAudioAndVideo(
                        //     audioUrl:
                        //         'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
                        //     videoUrl:
                        //         'https://v3.cdnpk.net/videvo_files/video/free/2012-09/large_watermarked/hd0456_preview.mp4'))!;
                        // finalVideo.initialize();
                        // showPlayer = true;
                        // setState(() {});
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
        ),
      ),
    );
  }
}

