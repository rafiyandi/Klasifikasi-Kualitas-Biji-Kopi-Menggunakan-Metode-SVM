import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopi/ui/pages/home/custom_button.dart';
import 'package:kopi/ui/pages/home/custom_selected_photo.dart';
import 'package:kopi/ui/style/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  _pickCamera() async {
    try {
      final _pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = XFile(_pickedFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  _pickFileUpload() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = XFile(pickedFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  _clearPickImage() async {
    if (_image != null) {
      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3, left: 30, right: 30),
      children: [
        DottedBorder(
          dashPattern: [20, 20],
          color: kPrimaryColor,
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12))),
                    context: context,
                    builder: (context) => Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  color: kSecondBlackColor.withOpacity(0.1),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Ambil Photo",
                                style: blackTextStyle.copyWith(
                                    fontSize: 18, fontWeight: semiBold),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  CustomSelectedPhoto(
                                    imgUrl: "assets/icon/icon_camera.png",
                                    text: "Kamera",
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickCamera();
                                    },
                                  ),
                                  SizedBox(width: 25),
                                  CustomSelectedPhoto(
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickFileUpload();
                                      },
                                      imgUrl: "assets/icon/icon_galery.png",
                                      text: "Galeri")
                                ],
                              )
                            ],
                          ),
                        )),
                child: _image == null
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: kGreyColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Press Button",
                            style: kGreyTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: kGreyColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: FileImage(
                                    File(_image!.path),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
              ),
              _image != null
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _clearPickImage,
                        child: Image.asset(
                          "assets/icon/icon_close.png",
                          width: 25,
                        ),
                      ))
                  : SizedBox(),
            ],
          ),
        ),
        _image != null ? CustomButton(onPressed: () {}) : SizedBox(),
      ],
    );
  }
}
