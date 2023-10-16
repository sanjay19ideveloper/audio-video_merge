import 'package:flutter/material.dart';
import 'package:music_editor/merger.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MyVideoScreen(),
    );
  }
}

// class MyVideoScreen extends StatefulWidget {
//   @override
//   _MyVideoScreenState createState() => _MyVideoScreenState();
// }

// class _MyVideoScreenState extends State<MyVideoScreen> {
//   late VideoPlayerController _videoController;
//   late AudioPlayer _audioPlayer;
//   final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.asset('assets/video.mp4')
//       ..initialize().then((_) {
//         setState(() {});
//       });
//     _audioPlayer = AudioPlayer();
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   // Function to merge video and audio
//   Future<void> mergeAudioAndVideo() async {
//     final videoPath = _videoController.dataSource;
//     final audioPath = 'assets/audio.mp3';
//     final outputPath = 'path_to_save_merged_video.mp4';

//     final arguments = [
//       '-i', videoPath,
//       '-i', audioPath,
//       '-c:v', 'copy',
//       '-c:a', 'aac',
//       outputPath,
//     ];

//     await _flutterFFmpeg.executeWithArguments(arguments);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video and Audio Merge'),
//       ),
//       body: Center(
//         child: _videoController.value.isInitialized
//             ? Column(
//                 children: [
//                   AspectRatio(
//                     aspectRatio: _videoController.value.aspectRatio,
//                     child: VideoPlayer(_videoController),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await mergeAudioAndVideo();
//                       // Once merged, you can play the merged video
//                       _videoController = VideoPlayerController.asset('path_to_save_merged_video.mp4')
//                         ..initialize().then((_) {
//                           setState(() {});
//                         });
//                     },
//                     child: Text('Merge Audio and Video'),
//                   ),
//                 ],
//               )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
