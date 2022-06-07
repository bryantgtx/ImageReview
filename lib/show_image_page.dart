import 'dart:io';
import 'package:flutter/material.dart';

class ShowImagePage extends StatefulWidget {
  final List<File> images;
  const ShowImagePage(this.images, { Key? key}) : super(key: key);

  @override
  State<ShowImagePage> createState() => _ShowImagePageState();
}

class _ShowImagePageState extends State<ShowImagePage> {
  var currentImage = 0;

  void _changeImage(int count) {
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
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(widget.images[currentImage]),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: GestureDetector(
              onTap: () => _changeImage(-1),
            ),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: GestureDetector(
              onTap: () => _changeImage(1),
            ),
          ),
        ],
      )
    );
  }
}