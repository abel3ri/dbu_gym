import 'package:dbu_gym/utils/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickSelector extends StatelessWidget {
  const ImagePickSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final res = await pickImageFromGallery();
              res.fold((l) => print(l), (r) => print(r.path));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image,
                    size: MediaQuery.of(context).size.width * 0.25),
                Text("Gallery")
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          GestureDetector(
            onTap: () async {
              final res = await pickImageFromCamera();
              res.fold((l) => print(l), (r) => print(r.path));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera,
                    size: MediaQuery.of(context).size.width * 0.25),
                Text("Camera")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
