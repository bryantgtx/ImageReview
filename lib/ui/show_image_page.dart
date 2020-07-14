import 'dart:io';
import 'package:flutter/widgets.dart';

class ShowImagePage extends StatefulWidget {
  final List<File> images;

  ShowImagePage(this.images);

  @override
  State<ShowImagePage> createState() => _ShowImagePageState();
}

class _ShowImagePageState extends State<ShowImagePage> {
  int currentImage = 0;

  void _advanceImage(int count) {
    if (count == 0) return;
    setState(() {
      currentImage += count;
      if (currentImage < 0) {
        currentImage = widget.images.length - 1;
      }
      else if (currentImage >= widget.images.length) {
        currentImage = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaData = MediaQuery.of(context);

    return Stack(
      children: <Widget>[
        ShowCurrentImage(widget.images[currentImage]),
        Positioned(
          left: 0,
          top: 0,
          width: (mediaData.size.width / 2) - 1,
          height: mediaData.size.height,
          child: GestureDetector(
            onTap: () => _advanceImage(-1),
          )
        ),
        Positioned(
          left: mediaData.size.width / 2,
          top: 0,
          width: (mediaData.size.width / 2) - 1,
          height: mediaData.size.height,
          child: GestureDetector(
            onTap: () => _advanceImage(1),
          )
        ),
      ]
    );
  }
}

class ShowCurrentImage extends StatelessWidget {
  final File image;
  ShowCurrentImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(image),
          fit: BoxFit.cover,
        )
      )
    );
  }
}