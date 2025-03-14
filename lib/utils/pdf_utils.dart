import 'dart:io';
import 'dart:typed_data';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../general_exports.dart';

Future<void> requestPermission() async {
  final PermissionStatus status = await Permission.storage.request();
  if (!status.isGranted) {
    throw Exception('Permission not granted');
  }
}

Future<void> saveAndLaunchFile(
    List<int> bytes, String fileName, String successMsg) async {
  final String path = Platform.isIOS
      ? (await getApplicationDocumentsDirectory()).path
      : (await getExternalStorageDirectory())!.path;
  final File file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  final Uint8List fileBytes = await file.readAsBytes();

  dismissLoading();

  DocumentFileSavePlus().saveFile(fileBytes, fileName, 'Aqarek/pdf').then(
    (dynamic value) {
      if (Platform.isAndroid) {
        Fluttertoast.showToast(msg: successMsg);
      }
    },
  );
}
