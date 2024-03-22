import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ImagePickSelector extends StatelessWidget {
  const ImagePickSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<AppImageProvider>(context);
    final formProvider = Provider.of<FormProvider>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final res = await pickImageFromGallery();
              res.fold((l) => print(l), (image) {
                GoRouter.of(context).pop();
                // separte the image provider for id image and profile image
                if (formProvider.selectImagePicker == 'profilePicture') {
                  imageProvider.setImagePathAndName(image.path, image.name);
                } else {
                  imageProvider.setIdImagePathAndName(image.path, image.name);
                }
              });
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
              res.fold((l) => print(l), (image) {
                GoRouter.of(context).pop();

                // separte the image provider for id image and profile image
                if (formProvider.selectImagePicker == 'profilePicture') {
                  imageProvider.setImagePathAndName(image.path, image.name);
                } else {
                  imageProvider.setIdImagePathAndName(image.path, image.name);
                }
              });
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
