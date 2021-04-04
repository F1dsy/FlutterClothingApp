import 'dart:io';

import 'package:fabrics/models/item_data.dart';
import 'package:flutter/material.dart';

void showImageDialog(
    BuildContext context, List<File> images, Temperature temperature) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: images.length == 1
              ? Column(
                  children: [
                    Image.file(images[0]),
                    Card(
                      child: Text(temperature.toString()),
                    )
                  ],
                )
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
