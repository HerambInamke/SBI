import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final Uuid _uuid = const Uuid();

  // Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Pick image from camera
  Future<File?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Pick multiple images
  Future<List<File>> pickMultipleImages() async {
    final List<XFile> images = await _picker.pickMultiImage(
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );
    return images.map((image) => File(image.path)).toList();
  }

  // Upload product image
  Future<String> uploadProductImage({
    required File imageFile,
    required String artisanId,
    required String productId,
  }) async {
    final String fileName = '${_uuid.v4()}.jpg';
    final Reference ref = _storage
        .ref()
        .child('artisans')
        .child(artisanId)
        .child('products')
        .child(productId)
        .child(fileName);

    final UploadTask uploadTask = ref.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    
    return downloadUrl;
  }

  // Upload multiple product images
  Future<List<String>> uploadProductImages({
    required List<File> imageFiles,
    required String artisanId,
    required String productId,
  }) async {
    final List<String> urls = [];
    
    for (final file in imageFiles) {
      final url = await uploadProductImage(
        imageFile: file,
        artisanId: artisanId,
        productId: productId,
      );
      urls.add(url);
    }
    
    return urls;
  }

  // Upload profile image
  Future<String> uploadProfileImage({
    required File imageFile,
    required String artisanId,
  }) async {
    final Reference ref = _storage
        .ref()
        .child('artisans')
        .child(artisanId)
        .child('profile.jpg');

    final UploadTask uploadTask = ref.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    
    return downloadUrl;
  }

  // Delete image
  Future<void> deleteImage(String imageUrl) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      // Image might already be deleted
      print('Error deleting image: $e');
    }
  }

  // Delete all product images
  Future<void> deleteProductImages({
    required String artisanId,
    required String productId,
  }) async {
    try {
      final Reference ref = _storage
          .ref()
          .child('artisans')
          .child(artisanId)
          .child('products')
          .child(productId);

      final ListResult result = await ref.listAll();
      
      for (final item in result.items) {
        await item.delete();
      }
    } catch (e) {
      print('Error deleting product images: $e');
    }
  }

  // Get upload progress stream
  Stream<TaskSnapshot> uploadWithProgress({
    required File imageFile,
    required String path,
  }) {
    final Reference ref = _storage.ref().child(path);
    final UploadTask uploadTask = ref.putFile(imageFile);
    return uploadTask.snapshotEvents;
  }
}
