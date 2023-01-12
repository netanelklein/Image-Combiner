import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final ImagePicker _picker = ImagePicker();

  XFile? _targetImage;
  XFile? _sourceImage;

  Future getImage(bool target) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (target) {
      setState(() {
        _targetImage = image;
      });
    } else {
      setState(() {
        _sourceImage = image;
      });
    }
  }

  Future takeImage(bool target) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (target) {
      setState(() {
        _targetImage = image;
      });
    } else {
      setState(() {
        _sourceImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Target Image:"),
                if (_targetImage != null)
                  Stack(children: [
                    Image.file(
                      File(_targetImage!.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => {setState(() => _targetImage = null)},
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ])
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => getImage(true),
                        child: const Text('Pick Image'),
                      ),
                      ElevatedButton(
                        onPressed: () => takeImage(true),
                        child: const Text('Take Image'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Source Image:"),
                if (_sourceImage != null)
                  Stack(children: [
                    Image.file(
                      File(_sourceImage!.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => {setState(() => _sourceImage = null)},
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ])
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => getImage(false),
                        child: const Text('Pick Image'),
                      ),
                      ElevatedButton(
                        onPressed: () => takeImage(false),
                        child: const Text('Take Image'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: (_targetImage != null && _sourceImage != null)
                  ? () => {}
                  : null,
              child: const Text("Render Image"))
        ],
      ),
    ));
  }
}
