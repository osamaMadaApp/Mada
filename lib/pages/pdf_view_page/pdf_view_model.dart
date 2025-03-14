import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../general_exports.dart';
import '../../utils/pdf_utils.dart';

class PdfViewModel extends ChangeNotifier {
  PdfViewModel({required this.urlPath, required this.title});
  final String urlPath;
  final String title;

  Future<void> downloadPdf(String successMsg) async {
    try {
      final Dio dio = Dio();
      final Response<List<int>> response = await dio.get<List<int>>(
        urlPath,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        final List<int> bytes = response.data ?? <int>[];
        final String fileName = '$title.pdf';
        await saveAndLaunchFile(bytes, fileName, successMsg);
      } else {
        Fluttertoast.showToast(msg: 'Failed to download PDF');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to download PDF');
    }
  }
}
