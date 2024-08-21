import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> getCameraPermission() async {
  final status = await Permission.camera.request();
  return status;
}