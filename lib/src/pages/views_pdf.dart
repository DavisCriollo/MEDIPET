import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:neitorcont/src/pages/view_pdf_facturas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewsPDFs extends StatelessWidget {
  final String infoPdf;
  final String labelPdf;
  const ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Vista PDF'),
          actions: [
            IconButton(
                onPressed: () {
                  openFile(url: infoPdf, fileName: labelPdf);
                },
                icon: const Icon(Icons.download))
          ],
        ),
        body: Container(
            width: size.wScreen(100),
            height: size.hScreen(100),
            padding: EdgeInsets.symmetric(
                horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
            color: Colors.grey[300],
            child: SfPdfViewer.network(infoPdf,
                canShowScrollHead: true, canShowScrollStatus: true)),
      ),
    );
  }

//========================================//

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await pickFile();
    // downloadFile(url,name);
    if (file == null) return;

    print('Phat====>: ${file.path}');
    OpenFile.open(file.path);
  }

//========================================//
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    print('Phat====>: ${file.path}');
//  final nameFile='$file'.split('/').last;
//  print('nameFile====>: $nameFile');

    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return File(result.files.first.path!);
  }

//========================================//

}
