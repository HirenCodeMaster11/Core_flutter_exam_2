import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../../utils/global.dart';
import 'component.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

TextEditingController txtName = TextEditingController();
TextEditingController txtGRID = TextEditingController();
TextEditingController txtSTD = TextEditingController();

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Input',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            namebox(),
            GRIDbox(),
            StdBox(),
            InkWell(
              onTap: () {
                setState(() {
                  setImage();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 35,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    Name = txtName.text;
                    GRID = txtGRID.text;
                    STD = txtSTD.text;
                    Navigator.pop(context);
                  });
                },
                child: SaveContenor(),
              ),
            ),
            RepaintBoundary(
              key: imagkey,
              child: Container(
                height: 200,
                width: 200,
                child: (imgpath == null)
                    ? Icon(Icons.add)
                    : Image.file(
                  imgpath!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setImage() async {
    XFile? images = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgpath = File(images!.path);
    });
  }
}

ImagePicker picker = ImagePicker();
File? imgpath;
GlobalKey imagkey=GlobalKey();