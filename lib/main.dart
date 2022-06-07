import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_review/show_image_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Review',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Image Review'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FilePickerResult? pickerResult;
  List<File> selectedFiles = [];
  Orientation orientation = Orientation.portrait;

  Future<void> _addFiles() async {
    // note that there's some danger here: https://stackoverflow.com/questions/69466478/waiting-asynchronously-for-navigator-push-linter-warning-appears-use-build/69512692#69512692
    final navigator = Navigator.of(context);
    pickerResult = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (pickerResult != null) {
      selectedFiles = pickerResult!.paths.map((path) => File(path!)).toList();

      final fileImage = decodeImage(selectedFiles[0].readAsBytesSync());
      if (fileImage != null) {
        final orientations = fileImage.width > fileImage.height
          ? [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight, ]
          : [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, ];
        SystemChrome.setPreferredOrientations(orientations);

        await navigator.push(
          MaterialPageRoute(builder: (context) => ShowImagePage(selectedFiles)),
        );
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      }
      // TODO should have a nice error message here
    }
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _addFiles(), 
          child: const Text('Please Select Images')
        ), 
      ),
    );
  }
}
