import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class AddInfoPageController extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? _selectedImage;

  File? get selectedImage => _selectedImage;
  
  bool get hasImage => imagePath != null;

  String? imagePath;

  Future<void> pickImage(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      log('Imagem capturada: ${image.path}');
      
      final Directory appDir = await getApplicationDocumentsDirectory();
      imagePath =
          '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      await image.saveTo(imagePath!);
      _selectedImage = File(imagePath!);
      notifyListeners();
      log('Imagem salva em: $imagePath');
      if (!context.mounted) return;

    }
  }
}