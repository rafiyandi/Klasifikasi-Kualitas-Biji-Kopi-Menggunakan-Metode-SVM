import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomFileImage extends StatelessWidget {
  const CustomFileImage({
    Key? key,
    required XFile? image,
  })  : _image = image,
        super(key: key);

  final XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
