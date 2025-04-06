import 'dart:typed_data' as U8;
import 'dart:ui';

import 'package:flutter/services.dart' as serv;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import 'assets.dart';
import 'pdf_utils.dart';

Future<void> generateAndDownloadPdfFile() async {
  Map<String, dynamic> jsonData = {
    "projectLogo": "url",
    "date": "11/01/2025 | 04:00 PM",
    "projectName": "Project Name",
    "realEstateDeveloperName": "Real estate developer",
    "companyName": "Company name",
    "tables": [
      {
        "titleAr": "تفاصيل المشروع",
        "titleEn": "Project Details",
        "tableInfo": [
          {"keyEn": "Project", "keyAr": "المشروع", "value": "Ivory Tower 3"},
          {"keyEn": "Developer", "keyAr": "المطور", "value": "Esnam"},
          {"keyEn": "Floor No", "keyAr": "رقم الدور", "value": "3"},
          {"keyEn": "Type", "keyAr": "الفئة", "value": "Apartment"},
          {"keyEn": "Unit No", "keyAr": "رقم الوحدة", "value": "X-02"},
          {
            "keyEn": "Total Area (sqm)",
            "keyAr": "المساحة الإجمالية (بالمتر المربع)",
            "value": "173"
          },
          {
            "keyEn": "Price in SAR",
            "keyAr": "السعر بالريال السعودي",
            "value": "2,305,000.00"
          },
        ]
      },
      {
        "titleAr": "عمولة مدى",
        "titleEn": "Mada Fee",
        "tableInfo": [
          {
            "keyEn": "Account name",
            "keyAr": "اسم الحساب",
            "value": "Company Mada Real Estate"
          },
          {
            "keyEn": "IBAN",
            "keyAr": "رقم الايبان",
            "value": "SA9060100033795022281001"
          },
          {"keyEn": "Bank Name", "keyAr": "اسم البنك", "value": "بنك الجزيرة"},
        ]
      }
    ],
    "offerValidation": "3"
  };
  final pdf = pw.Document();
  final date = jsonData['date'];
  final projectName = jsonData['projectName'];
  final realEstateDeveloperName = jsonData['realEstateDeveloperName'];
  final companyName = jsonData['companyName'];
  final offerValidDays = jsonData['offerValidation'];
  final U8.Uint8List leftImageBytes =
      (await serv.rootBundle.load(coloredLogoImage)).buffer.asUint8List();

  final Uint8List rightImage = await urlToUint8List("https://img.freepik.com/free-vector/abstract-logo-flame-shape_1043-44.jpg");


  int counter = 0;
  final fontOutfit500 = await rootBundle.load('assets/fonts/Outfit-Medium.ttf');
  final outfitFont500 = pw.Font.ttf(fontOutfit500);

  final fontOutfit300 = await rootBundle.load('assets/fonts/Outfit-Light.ttf');
  final outfitFont300 = pw.Font.ttf(fontOutfit300);

  final fontOutfit400 =
      await rootBundle.load('assets/fonts/Outfit-Regular.ttf');
  final outfitFont400 = pw.Font.ttf(fontOutfit400);

  final fontOutfit600 =
      await rootBundle.load('assets/fonts/Outfit-SemiBold.ttf');
  final outfitFont600 = pw.Font.ttf(fontOutfit600);

  final fontIBM600 =
      await rootBundle.load('assets/fonts/IBMPlexSansArabic-SemiBold.ttf');
  final outIBM600 = pw.Font.ttf(fontIBM600);




  pdf.addPage(
    pw.MultiPage(
      margin: pw.EdgeInsets.zero,
      header: (con) {
        return pw.Container(
          height: 8,
          color: const PdfColor.fromInt(0xFF97BE5A),
        );
      },
      build: (context) => [
        pw.Container(
          color: const PdfColor.fromInt(0xFFFAFAFA),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    child: pw.Image(
                      pw.MemoryImage(leftImageBytes),
                      width: 75,
                      height: 75,
                    ),
                  ),
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('Date and Time: ',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('#000000'),
                              fontSize: 10,
                              font: outfitFont500,
                            )),
                        pw.Text('$date',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('#000000'),
                              fontSize: 10,
                              font: outfitFont300,
                            )),
                      ])
                ],
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Project Name',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#505050'),
                            fontSize: 10,
                            font: outfitFont500,
                          )),
                      pw.SizedBox(width: 10),
                      pw.Text('$realEstateDeveloperName - $companyName',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#989898'),
                            fontSize: 10,
                            font: outfitFont400,
                          )),
                    ],
                  ),
                  pw.SizedBox(width: 15),
                  pw.Container(height: 30, color: PdfColors.grey, width: 1),
                  pw.SizedBox(width: 15),
                  pw.Container(
                    child: pw.Image(
                      pw.MemoryImage(rightImage),
                      width: 50,
                      height: 75,
                    ),
                  ),
                ],
              ),
            ],
          ),
          padding: const pw.EdgeInsets.only(
              left: 25, right: 25, bottom: 30, top: 38),
        ),
        pw.Padding(
          child: pw.SizedBox(height: 20),
          padding: const pw.EdgeInsets.only(left: 25, right: 25),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 25, right: 25),
          child: pw.Center(
            child: pw.Text('Sales Offer',
                style: pw.TextStyle(
                  color: PdfColor.fromHex('#000000'),
                  fontSize: 30,
                  font: outfitFont600,
                )),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 25, right: 25),
          child: pw.SizedBox(height: 20),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 25, right: 25),
          child: pw.SizedBox(height: 20),
        ),
        // Tables
        ...jsonData['tables'].map<pw.Widget>((table) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(left: 25, right: 25),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF97BE5A),
                    // Light green color
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(table['titleEn'],
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#FFFFFF'),
                            fontSize: 14,
                            font: outfitFont600,
                          )),
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text(table['titleAr'],
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('#FFFFFF'),
                              fontSize: 14,
                              font: outIBM600,
                            )),
                      )
                    ],
                  ),
                ),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.white, width: 0),
                  children: [
                    ...table['tableInfo'].map<pw.TableRow>((item) {
                      counter = counter + 1;
                      return pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: counter.isEven
                              ? const PdfColor.fromInt(0xFFFAFBF6)
                              : const PdfColor.fromInt(0xFFFFFFFF),
                        ),
                        verticalAlignment: pw.TableCellVerticalAlignment.middle,
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(item['keyEn'],
                                style: pw.TextStyle(
                                  color: PdfColor.fromHex('#000000'),
                                  fontSize: 12,
                                  font: outfitFont600,
                                )),
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              if (isArabicText(item['value']))
                                pw.Directionality(
                                    textDirection: pw.TextDirection.rtl,
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(8),
                                      child: pw.Text(item['value'],
                                          style: pw.TextStyle(
                                            color: PdfColor.fromHex('#000000'),
                                            fontSize: 12,
                                            font: outIBM600,
                                          )),
                                    ))
                              else
                                pw.Padding(
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text(item['value'],
                                      style: pw.TextStyle(
                                        color: PdfColor.fromHex('#000000'),
                                        fontSize: 12,
                                        font: outfitFont600,
                                      )),
                                ),
                            ],
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Directionality(
                              textDirection: pw.TextDirection.rtl,
                              child: pw.Text(item['keyAr'],
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex('#000000'),
                                    fontSize: 12,
                                    font: outIBM600,
                                  )),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
            ),
          );
        }).toList(),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 25, right: 25),
          child: pw.Divider(color: const PdfColor.fromInt(0xFF97BE5A)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 25, right: 25, top: 30),
          child: pw.Row(children: [
            pw.Text('**',
                style: pw.TextStyle(
                  color: PdfColors.red,
                  fontSize: 10,
                  font: outfitFont600,
                )),
            pw.Text(
                'This Sales Offer is valid only for $offerValidDays days. Price and payment plan are subject to change without prior notice.',
                style: pw.TextStyle(
                  color: PdfColor.fromHex('#000000'),
                  fontSize: 10,
                  font: outfitFont600,
                ))
          ]),
        ),
      ],
      footer:  (con) {
        return pw.Container(
          height: 8,
          color: const PdfColor.fromInt(0xFF97BE5A),
        );
      },
    ),
  );

  final Uint8List bytes = await pdf.save();
  saveAndLaunchFile(bytes.toList(), 'PdfFile', 'Success Download');
}

bool isArabicText(String text) {
  if (text.isEmpty) return false;

  // The Unicode range for Arabic characters is from 0x0600 to 0x06FF
  // Additional Arabic characters can be found in 0x0750-0x077F (Arabic Supplement)
  // and 0x08A0-0x08FF (Arabic Extended-A)
  RegExp arabicRegex = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');

  // Count Arabic characters
  int arabicCharCount = arabicRegex.allMatches(text).length;

  // If more than 50% of the characters are Arabic, consider it Arabic text
  // This threshold can be adjusted based on your needs
  return arabicCharCount > (text.length / 2);
}

Future<Uint8List> urlToUint8List(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception('Failed to load image from URL');
  }
}
