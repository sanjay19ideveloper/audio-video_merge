// import 'dart:io';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';


// class ReelsPage extends StatefulWidget {
//   const ReelsPage({super.key});

//   @override
//   State<ReelsPage> createState() => _ReelsPageState();
// }

// class _ReelsPageState extends State<ReelsPage> {
//   CameraController? controller;
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//     appBar: AppBar(title: Text('Video Recording')),
//     body: Center(
//       child: controller!.value.isInitialized
//           ? CameraPreview(controller!)
//           : CircularProgressIndicator(),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         if (!controller!.value.isRecordingVideo) {
//           recordVideo();
//         }
//       },
//       child: Icon(
//         controller!.value.isRecordingVideo ? Icons.stop : Icons.fiber_manual_record,
//       ),
//     ),
//   );;
//   }
//   void requestCameraPermission() async {
//   final status = await Permission.camera.request();
//   if (status.isGranted) {
//     // Permission granted
//   } else {
//     // Permission denied
//   }
// }
// void recordVideo() async {
//   if (controller != null && controller!.value.isInitialized) {
//     final Directory appDir = Directory('your_desired_directory_path');
//     await appDir.create(recursive: true);
    
//     final String videoPath = '${appDir.path}/${DateTime.now()}.mp4';

//     try {
//       await controller!.startVideoRecording();
//     } on CameraException catch (e) {
//       print('Error starting video recording: $e');
//     }
//   }
// }


// }





