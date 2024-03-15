import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

Future<Either<String, XFile>> pickImageFromCamera() async {
  try {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    if (image == null) return left("Image not selected!");
    return right(image);
  } catch (err) {
    throw left(err.toString());
  }
}

Future<Either<String, XFile>> pickImageFromGallery() async {
  try {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (image == null) return left("Image not selected!");
    return right(image);
  } catch (err) {
    throw left(err.toString());
  }
}
