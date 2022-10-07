import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopi/models/klasifikasi_model.dart';
import 'package:kopi/services/klasifikasi_services.dart';
import 'package:kopi/ui/pages/home/custom_button.dart';
import 'package:kopi/ui/pages/home/custom_selected_photo.dart';
import 'package:kopi/ui/style/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  KlasifikasiModel? klasifikasiModel;
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
          dashPattern: const [20, 20],
          color: kPrimaryColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12))),
                    context: context,
                    builder: (context) => Container(
                          padding: const EdgeInsets.all(16),
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
                              const SizedBox(height: 20),
                              Text(
                                "Ambil Photo",
                                style: blackTextStyle.copyWith(
                                    fontSize: 18, fontWeight: semiBold),
                              ),
                              const SizedBox(height: 20),
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
                                  const SizedBox(width: 25),
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
                    : Container(
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
                  : const SizedBox(),
            ],
          ),
        ),
        _image != null
            ? CustomButton(onPressed: () async {
                // KlasifikasiModel result = await KlasifikasiServices()
                //     .klasifikasi(XFile(_image!.path));
                // if (result != null) {
                //   setState(() {
                //     klasifikasiModel = result;
                //   });
                //   print(klasifikasiModel);
                // } else {
                //   print("Coba Lagi");
                // }
              })
            : const SizedBox(),
      ],
    );
  }
}
