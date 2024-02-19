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
            onTap: () {},
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
            onTap: () {},
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
