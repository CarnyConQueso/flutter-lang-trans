import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/pages/scannedtext.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imgPath = ' ';
  String finishedText = ' ';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.drive_folder_upload_rounded),
          label: const Text("Pick Image"),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            getImage();
            if (isLoading) {
              Future.delayed(const Duration(seconds: 6), () {
                textRecognition(imgPath);
              });
            }
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
  }

  void getImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      isLoading = true;
      imgPath = image!.path;
    });
  }

  void textRecognition(String path) async {
    showDialog(
        context: context,
        builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ));
    final selectedImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText _recText =
        await textDetector.processImage(selectedImage);
    for (TextBlock block in _recText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          finishedText = finishedText + element.text;
        }
        finishedText = finishedText + '\n';
      }
    }
    // Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScannedText(text: finishedText)));
  }
}
