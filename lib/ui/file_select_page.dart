import 'dart:io';
import 'package:image/image.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imagereview/ui/show_image_page.dart';
import 'package:imagereview/main.dart';


class FileSelectPage extends StatefulWidget {
  @override
  State<FileSelectPage> createState() => _FileSelectPageState();
}

class _FileSelectPageState extends State<FileSelectPage> with RouteAware {
  List<File> selectedFiles;
  int advanceInterval = 1;
  bool autoAdvanceEnabled = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    print("called didPopNext");
    setState(() {
      
    });
  }

  _addFiles() async {
    selectedFiles = await FilePicker.getMultiFile(
      type: FileType.image,
    );
    if (selectedFiles.length > 0) {
      var fileImage = decodeImage(selectedFiles[0].readAsBytesSync());// Image.file(widget.images[currentImage]);
      var orientations = fileImage.width > fileImage.height ?
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight] :
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
      SystemChrome.setPreferredOrientations(orientations);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowImagePage(selectedFiles))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Review"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CheckboxListTile(
            //   title: Text('Enable Auto Advance'),
            //   value: autoAdvanceEnabled, 
            //   onChanged: (val) { autoAdvanceEnabled = val; }
            // ),
            RaisedButton(
              child: Text('Please select images'),
              onPressed: _addFiles
            ),
          ],
        ),
      ),
    );
  }
}