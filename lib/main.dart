// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: TakePictureScreen(
//         camera: firstCamera,
//       ),
//     ),
//   );
// }

// class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);

//   final CameraDescription camera;

//   @override
//   _TakePictureScreenState createState() => _TakePictureScreenState();
// }

// class _TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   XFile? _capturedImage;
//   bool _showImagePickerButton = true;

//   @override
//   void initState() {
//     super.initState();

//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Take a picture')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return _buildCameraPreview();
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           if (_showImagePickerButton)
//             FloatingActionButton(
//               onPressed: () async {
//                 // Open the image picker
//                 final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//                 if (pickedFile != null) {
//                   // If an image is picked from the gallery, navigate to the DisplayPictureScreen
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => DisplayPictureScreen(
//                         imagePath: pickedFile.path,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: const Icon(Icons.photo_library),
//             ),
//           FloatingActionButton(
//             onPressed: () async {
//               if (_capturedImage != null) {
//                 // If a picture is already captured, user wants to retake
//                 setState(() {
//                   _capturedImage = null;
//                   _showImagePickerButton = true;
//                 });
//               } else {
//                 // If no picture is captured, take a new picture
//                 try {
//                   await _initializeControllerFuture;
//                   final image = await _controller.takePicture();
//                   if (!mounted) return;

//                   setState(() {
//                     _capturedImage = image;
//                     _showImagePickerButton = false;
//                   });
//                 } catch (e) {
//                   print(e);
//                 }
//               }
//             },
//             child: const Icon(Icons.camera_alt),
//           ),
//           if (_capturedImage != null)
//             FloatingActionButton(
//               onPressed: () {
//                 // If a picture is captured, navigate to the DisplayPictureScreen
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => DisplayPictureScreen(
//                       imagePath: _capturedImage!.path,
//                     ),
//                   ),
//                 );
//               },
//               child: const Icon(Icons.arrow_forward),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCameraPreview() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         CameraPreview(_controller),
//         if (_capturedImage != null)
//           Image.file(
//             File(_capturedImage!.path),
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//           ),
//       ],
//     );
//   }
// }

// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Display the Picture')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Image.file(
//               File(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Implement the logic for what to do when the "Next" button is pressed
//               // For now, just pop the current screen
//               Navigator.of(context).pop();
//             },
//             child: const Text('Next'),
//           ),
//       ],),);}
// }



// ignore_for_file: unnecessary_null_comparison

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite/tflite.dart';
// import 'dart:math' as math;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Object Detection App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late List<CameraDescription> cameras;
//   String selectedModel = "";

//   @override
//   void initState() {
//     super.initState();
//     loadCameras();
//   }

//   loadCameras() async {
//     cameras = await availableCameras();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Object Detection App'),
//       ),
//       body: cameras == null
//           ? Center(child: CircularProgressIndicator())
//           : CameraPage(cameras, selectedModel),
//     );
//   }
// }

// // ignore: must_be_immutable
// class CameraPage extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   String selectedModel;

//   CameraPage(this.cameras, this.selectedModel);

//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late List<dynamic> recognitions;
//   int imageHeight = 0;
//   int imageWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   loadModel() async {
//     String? res = await Tflite.loadModel(
//       model: "assets/ssd_mobilenet.tflite",
//       labels: "assets/ssd_mobilenet.txt",
//     );
//     print(res);
//   }

//   setRecognitions(List<dynamic> list, int h, int w) {
//     setState(() {
//       recognitions = list;
//       imageHeight = h;
//       imageWidth = w;
//     });
//   }

//   onSelect(String model) {
//     setState(() {
//       widget.selectedModel = model;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     return Scaffold(
//       body: widget.selectedModel.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   RaisedButton(
//                     child: const Text('SSD MobileNet'),
//                     onPressed: () => onSelect('SSDMobileNet'),
//                   ),
//                 ],
//               ),
//             )
//           : Stack(
//               children: [
//                 Camera(widget.cameras, widget.selectedModel, setRecognitions),
//                 BndBox(
//                   recognitions == null ? [] : recognitions,
//                   math.max(imageHeight, imageWidth),
//                   math.min(imageHeight, imageWidth),
//                   screen.height,
//                   screen.width,
//                   widget.selectedModel,
//                 ),
//               ],
//             ),
//     );
//   }
  
//   RaisedButton({required Text child, required Function() onPressed}) {}
// }

// class Camera extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   final Callback setRecognitions;
//   final String model;

//   Camera(this.cameras, this.model, this.setRecognitions);

//   @override
//   _CameraState createState() => _CameraState();
// }

// class _CameraState extends State<Camera> {
//   late CameraController controller;
//   bool isDetecting = false;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.cameras.length < 1) {
//       print('No camera is found');
//     } else {
//       controller = CameraController(
//         widget.cameras[0],
//         ResolutionPreset.high,
//       );
//       controller.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});

//         controller.startImageStream((CameraImage img) {
//           if (!isDetecting) {
//             isDetecting = true;

//             int startTime = DateTime.now().millisecondsSinceEpoch;
//             Tflite.detectObjectOnFrame(
//               bytesList: img.planes.map((plane) {
//                 return plane.bytes;
//               }).toList(),
//               model: "SSDMobileNet",
//               imageHeight: img.height,
//               imageWidth: img.width,
//               imageMean: 127.5,
//               imageStd: 127.5,
//               numResultsPerClass: 1,
//               threshold: 0.4,
//             ).then((recognitions) {
//               int endTime = DateTime.now().millisecondsSinceEpoch;
//               print("Detection took ${endTime - startTime}");

//               widget.setRecognitions(recognitions!, img.height, img.width);

//               isDetecting = false;
//             });
//           }
//         });
//       });
//     }
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }

//     var tmp = MediaQuery.of(context).size;
//     var screenH = math.max(tmp.height, tmp.width);
//     var screenW = math.min(tmp.height, tmp.width);
//     tmp = controller.value.previewSize!;
//     var previewH = math.max(tmp.height, tmp.width);
//     var previewW = math.min(tmp.height, tmp.width);
//     var screenRatio = screenH / screenW;
//     var previewRatio = previewH / previewW;

//     return OverflowBox(
//       maxHeight:
//           screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
//       maxWidth:
//           screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
//       child: CameraPreview(controller),
//     );
//   }
// }

// typedef void Callback(List<dynamic> list, int h, int w);

// class BndBox extends StatelessWidget {
//   final List<dynamic> results;
//   final int previewH;
//   final int previewW;
//   final double screenH;
//   final double screenW;
//   final String model;

//   BndBox(
//     this.results,
//     this.previewH,
//     this.previewW,
//     this.screenH,
//     this.screenW,
//     this.model,
//   );

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> _renderBoxes() {
//       return results.map((re) {
//         var _x = re["rect"]["x"];
//         var _w = re["rect"]["w"];
//         var _y = re["rect"]["y"];
//         var _h = re["rect"]["h"];
//         var scaleW, scaleH, x, y, w, h;

//         if (screenH / screenW > previewH / previewW) {
//           scaleW = screenH / previewH * previewW;
//           scaleH = screenH;
//           var difW = (scaleW - screenW) / scaleW;
//           x = (_x - difW / 2) * scaleW;
//           w = _w * scaleW;
//           if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
//           y = _y * scaleH;
//           h = _h * scaleH;
//         } else {
//           scaleH = screenW / previewW * previewH;
//           scaleW = screenW;
//           var difH = (scaleH - screenH) / scaleH;
//           x = _x * scaleW;
//           w = _w * scaleW;
//           y = (_y - difH / 2) * scaleH;
//           h = _h * scaleH;
//           if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
//         }

//         return Positioned(
//           left: math.max(0, x),
//           top: math.max(0, y),
//           width: w,
//           height: h,
//           child: Container(
//             padding: EdgeInsets.only(top: 5.0, left: 5.0),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Color.fromRGBO(37, 213, 253, 1.0),
//                 width: 3.0,
//               ),
//             ),
//             child: Text(
//               "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
//               style: TextStyle(
//                 color: Color.fromRGBO(37, 213, 253, 1.0),
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       }).toList();
//     }

//     return Stack(
//       children: _renderBoxes(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/camera_view.dart';

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'demp',
      theme:ThemeData(primarySwatch: Colors.blue),
      home:const CameraView(). 
    );
  }
}