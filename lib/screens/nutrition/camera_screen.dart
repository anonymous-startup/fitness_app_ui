import 'dart:io';

import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/image_macros_output.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({
    super.key,
    required this.cameras,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  late File pickedImage;
  bool isFlashOn = false;
  bool isRearCamera = true;
  double zoomValue = 1.0; // Initial zoom value

  Future<File> saveImage(XFile image) async {
    final downlaodPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('$downlaodPath/$fileName');

    try {
      await file.writeAsBytes(await image.readAsBytes());
    } catch (_) {}

    return file;
  }

  void takePicture() async {
    XFile? image;

    if (cameraController.value.isTakingPicture ||
        !cameraController.value.isInitialized) {
      return;
    }

    image = await cameraController.takePicture();

    final file = await saveImage(image);
    setState(() {
      pickedImage = file;
    });

    // MediaScanner.loadMedia(path: file.path);

    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => ImageMacrosOutput(imageFile: pickedImage),
      ),
    );
  }

  void startCamera(int cameraIndex) {
    cameraController = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraValue = cameraController.initialize();
  }

  Future<void> toggleFlash() async {
    try {
      if (isFlashOn) {
        cameraController.setFlashMode(FlashMode.off);
      } else {
        cameraController.setFlashMode(FlashMode.torch);
      }
      setState(() {
        isFlashOn = !isFlashOn;
      });
    } catch (e) {
      print("Failed to toggle flashlight: $e");
    }
  }

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void setCameraZoom(double zoomValue) {
    cameraController.setZoomLevel(zoomValue);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: getProportionateScreenHeight(200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(36)),
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(18),
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(300),
                  child: Slider(
                    value: zoomValue,
                    min: 1.0,
                    max: 5.0, // Adjust max zoom level as needed
                    onChanged: (value) {
                      setState(
                        () {
                          zoomValue = value;
                          setCameraZoom(
                            zoomValue,
                          ); // Set zoom level when slider changes
                        },
                      );
                    },
                  ),
                ),
                Text(
                  "+",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenHeight(18),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: 'btn2',
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "X",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(29),
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'btn1',
                  backgroundColor: primaryColor,
                  shape: const CircleBorder(),
                  onPressed: takePicture,
                  child: Icon(
                    Icons.add,
                    size: getProportionateScreenHeight(40),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: 100,
                      child: CameraPreview(cameraController),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

          Positioned(
            top: getProportionateScreenHeight(98),
            left: 0,
            right: 0,
            child: Container(
              height: getProportionateScreenHeight(30),
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(100)),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      size: getProportionateScreenHeight(23),
                      isFlashOn ? Icons.flash_off : Icons.flash_on,
                      color: primaryColor,
                    ),
                    onPressed: toggleFlash,
                  ),
                  IconButton(
                    icon: Icon(
                      size: getProportionateScreenHeight(20),
                      isRearCamera ? Icons.camera_rear : Icons.camera_front,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isRearCamera = !isRearCamera;
                      });
                      isRearCamera ? startCamera(0) : startCamera(1);
                    },
                  ),
                ],
              ),
            ),
          ),

          //scanner like square
          Center(
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 50,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 8,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 50,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 8,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
