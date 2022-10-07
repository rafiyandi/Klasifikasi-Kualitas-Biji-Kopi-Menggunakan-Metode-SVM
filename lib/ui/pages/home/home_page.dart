import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopi/models/klasifikasi_model.dart';
import 'package:kopi/ui/pages/home/custom_button.dart';
import 'package:kopi/ui/pages/home/custom_file_image.dart';
import 'package:kopi/ui/pages/home/custom_image_state.dart';
import 'package:kopi/ui/pages/home/custom_selected_photo.dart';
import 'package:kopi/ui/style/theme.dart';

import '../../../blocs/bloc/klasifikasi_bloc.dart';

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
    return BlocConsumer<KlasifikasiBloc, KlasifikasiState>(
      listener: (context, state) {
        if (state is KlasifikasiFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("data")));
        }
        if (state is KlasifikasiSucces) {
          showDialogKlasikasiBerhasil(context, state);
        }
      },
      builder: (context, state) {
        if (state is KlasifikasiLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff5C40CC),
              strokeWidth: 3,
            ),
          );
        }
        return ListView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 30,
              right: 30),
          children: [
            boxImageKlasifikasi(context),
            _image != null
                ? buttonProsesKlasifikasi(context)
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Future<dynamic> showDialogKlasikasiBerhasil(
      BuildContext context, KlasifikasiSucces state) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Hasil Klasifikasi",
                style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              ),
              CustomImageResult(hasil: state.hasil.urlAsli ?? ''),
              CustomImageResult(hasil: state.hasil.urlGRY ?? ''),
              CustomImageResult(hasil: state.hasil.urlLBP ?? ''),
              SizedBox(
                height: 20,
              ),
              Text(
                "Kualitas Kopi : ${state.hasil.hasil}",
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonProsesKlasifikasi(BuildContext context) {
    return CustomButton(onPressed: () async {
      context
          .read<KlasifikasiBloc>()
          .add(KlasifikasiCheck(XFile(_image!.path)));

      // }
    });
  }

  Widget boxImageKlasifikasi(BuildContext context) {
    return DottedBorder(
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
                  : CustomFileImage(image: _image)),
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
    );
  }
}
