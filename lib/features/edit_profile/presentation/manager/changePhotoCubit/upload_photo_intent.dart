import 'package:image_picker/image_picker.dart';

abstract class UploadPhotoIntent {}

class SelectPhotoIntent extends UploadPhotoIntent {
  final XFile photo;
  SelectPhotoIntent(this.photo);
}

class UploadSelectedPhotoIntent extends UploadPhotoIntent {
  final String token;
  UploadSelectedPhotoIntent(this.token);
}
