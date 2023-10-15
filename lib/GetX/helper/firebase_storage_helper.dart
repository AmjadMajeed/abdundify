import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageHelper {
  static final FirebaseStorageHelper instance =
      FirebaseStorageHelper._internal();
  static const String USER_IMAGES_PATH = 'user_images';

  final FirebaseStorage _firebaseStorage =
      FirebaseStorage.instanceFor(bucket: 'gs://delivery-app-e3483.appspot.com');
  final Uuid _uuid = const Uuid();

  FirebaseStorageHelper._internal();

  String get imageId => _uuid.v1();

  Future<String?> uploadImage(File imageFile) async {
    final String filePath = '$imageId${p.extension(imageFile.path)}';
    UploadTask? uploadTask;
    try {
      final reference = _firebaseStorage.ref().child(USER_IMAGES_PATH).child(filePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      uploadTask = reference.putData(imageBytes);
      int counter = 0;
      while (uploadTask.snapshot.state == TaskState.running) {
        await Future.delayed(const Duration(seconds: 1));
        counter += 1;
        if (counter == 10) break;
      }
      return await uploadTask.snapshot.ref.getDownloadURL();
    } catch (e) {
      uploadTask?.cancel();
      return null;
    }
  }
}
