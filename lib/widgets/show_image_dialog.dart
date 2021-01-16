import 'dart:io';

import 'package:flutter/material.dart';

void showImageDialog(BuildContext context, List<File> images) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: images.length == 1
              ? Image.file(images[0])
              : ListView(
                  children: images
                      .map(
                        (image) => Image.file(image),
                      )
                      .toList(),
                  shrinkWrap: true,
                ),
        ),
      ),
    ),
  );
}
