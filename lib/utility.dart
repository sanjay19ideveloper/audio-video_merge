import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class Utility {
  Future<VideoPlayerController?> mergeAudioAndVideo(
      {String? audioUrl, String? videoUrl}) async {
    final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();

    String outputPath = '';

    final downloadsDirectory = await getTemporaryDirectory();
    final directoryPath = downloadsDirectory.path;
    outputPath = '$directoryPath/${DateTime.now().millisecond}.mp4';
    print("out put paht is $outputPath");

    // Create the directory if it doesn't exist
    if (!await Directory(directoryPath).exists()) {
      await Directory(directoryPath).create(recursive: true);
    }

    final arguments = [
      '-i',
      videoUrl,
      '-i',
      audioUrl,
      '-c:v',
      'copy',
      '-c:a',
      'aac',
      outputPath,
    ];

    await flutterFFmpeg.executeWithArguments(arguments);

    return VideoPlayerController.file(File(outputPath));
  }




  Future<VideoPlayerController?> mergeAudioAndImage(
      {String? audioUrl, String? imageUrl}) async {
    final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();

    String outputPath = '';

    final downloadsDirectory = await getTemporaryDirectory();
    final directoryPath = downloadsDirectory.path;
    outputPath = '$directoryPath/${DateTime.now().millisecond}.mp4';
    print("out put paht is $outputPath");

    // Create the directory if it doesn't exist
    if (!await Directory(directoryPath).exists()) {
      await Directory(directoryPath).create(recursive: true);
    }

    final arguments = [
      '-i', imageUrl,
      '-i', audioUrl,
      '-c:v', 'mpeg4',
      '-c:a', 'aac',
      outputPath,
    ];

    await flutterFFmpeg.executeWithArguments(arguments);

    return VideoPlayerController.file(File(outputPath));
  }
}
