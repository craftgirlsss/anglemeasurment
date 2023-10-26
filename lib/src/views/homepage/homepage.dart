import 'dart:io';
import 'package:anglemeasurment/src/components/appbars/appbar.dart';
import 'package:anglemeasurment/src/components/buttons/rectanglebuttons/rectanglebuttons.dart';
import 'package:anglemeasurment/src/components/styles/textstyles.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:superdeclarative_geometry/superdeclarative_geometry.dart';

import 'tryshape.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isDown = false;
  double x = 0.0;
  double y = 0.0;
  int? targetId;
  Map<int, Map<String, double>> pathList = {
    1: {"x": 100, "y": 100, "r": 50, "color": 0},
    2: {"x": 200, "y": 200, "r": 50, "color": 1},
    3: {"x": 300, "y": 300, "r": 50, "color": 2},
  };
  final _key = GlobalKey<ExpandableFabState>();
  PhotoViewController? controller;
  double? scaleCopy;

  @override
  void initState() {
    super.initState();
    controller = PhotoViewController()..outputStateStream.listen(listener);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value) {
    setState(() {
      scaleCopy = value.scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(autoImplyLeading: false, title: "Directus"),
      body: Stack(
        children: [
          if (imagecamera != null)
            PhotoView(
              imageProvider: FileImage(imagecamera!),
            )
          // Image.file(imagecamera!)
          else if (imagegallery != null)
            PhotoView(
              imageProvider: FileImage(imagegallery!),
              controller: controller,
            )
          else
            Center(
                child: Column(
              children: [
                Image.asset('assets/images/backgorund-no-image.png'),
                Text(
                  "Tidak ada gambar",
                  style: sfPro(fontSize: 16, color: Colors.black54),
                )
              ],
            )),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.folder),
            onPressed: () async {
              getFromGallery();
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.camera_alt_rounded),
            onPressed: () async {
              getFromCamera();
            },
          ),
          FloatingActionButton.small(
            backgroundColor: imagecamera != null || imagegallery != null
                ? Colors.blue
                : Colors.grey,
            heroTag: null,
            onPressed: imagecamera != null || imagegallery != null
                ? () {
                    Get.to(() => const TryShapeWithCustomPaint());
                  }
                : null,
            child: const Icon(Icons.linear_scale_rounded),
          ),
          FloatingActionButton.small(
            backgroundColor: imagecamera != null || imagegallery != null
                ? Colors.blue
                : Colors.grey,
            heroTag: null,
            onPressed:
                imagecamera != null || imagegallery != null ? () {} : null,
            child: Image.asset('assets/icons/angle.png'),
          ),
        ],
      ),
      backgroundColor: imagegallery != null || imagecamera != null
          ? Colors.transparent
          : Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: kRectangleButtons(
                    label: "Metode A",
                    onPressed: imagecamera != null || imagegallery != null
                        ? () {}
                        : null)),
            const SizedBox(width: 10),
            Expanded(
                child: kRectangleButtons(
                    label: "Metode B",
                    onPressed: imagecamera != null || imagegallery != null
                        ? () {}
                        : null)),
          ],
        ),
      ),
    );
  }

  File? imagecamera;
  File? imagegallery;
  String? filename;
  getFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      imagecamera = File(imagePicked!.path);
      filename = imagePicked.path;
    });
  }

  getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    setState(() {
      imagegallery = File(imagePicked!.path);
      filename = imagePicked.path;
    });
  }
}
