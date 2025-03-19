import 'dart:io';
import 'dart:typed_data';

// import 'package:document_file_save_plus/document_file_save_plus.dart';
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

Future<void> saveAndLaunchFile(List<int> bytes, String fileName, String successMsg) async {
  final String path = Platform.isIOS
      ? (await getApplicationDocumentsDirectory()).path
      : (await getExternalStorageDirectory())!.path;
  final File file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  final Uint8List fileBytes = await file.readAsBytes();

  dismissLoading();

  await savePdfFile(fileBytes, fileName, 'Aqarek/pdf');
}

Future<void> savePdfFile(Uint8List fileBytes, String fileName, String successMsg) async {
  try {
    // Request storage permission
    final Directory directory = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();

    final String filePath = '${directory.path}/$fileName.pdf';
    // Write the file
    final File file = File(filePath);
    await file.writeAsBytes(fileBytes);

    // Show success toast
    if (Platform.isAndroid) {
      Fluttertoast.showToast(msg: successMsg);
    }
  } catch (e) {
    if (Platform.isAndroid) {
      Fluttertoast.showToast(msg: successMsg);
    }
  }
}
