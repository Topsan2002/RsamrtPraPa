// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rsmart/TypeData/dataRecive.dart';
import 'package:rsmart/TypeData/testdata.dart';
import 'package:rsmart/screen/manage_unit/widged/widgetOtherPay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode/barcode.dart';

//void main() => runApp(const MyApp('Printing Demo'));

class PrintTest extends StatefulWidget {
  const PrintTest({Key? key}) : super(key: key);

  @override
  _PrintTestState createState() => _PrintTestState();
}

class _PrintTestState extends State<PrintTest> {
  PdfDocument doc = new PdfDocument();
  var realId;
  var path;
  var myName;
  var myAge;
  var adminId;
  var waterId;
  var profile_name;
  var profile_tax;
  var profile_address;
  var profile_phone;
  var unit_id;
  var date_now;
  var userName;
  var user_address;
  var id_card;
  var user_tax;
  var date_last;
  var last_unit;
  var now_date;
  var now_unit;
  var unit_use;
  var unit_pay;
  var unit_service;
  var other_name;
  var amont_other;
  var total_pay;
  var admin_name;
  var mon_now;
  var mon_last;
  var meterLast;
  var last_input;
  var last_total;
  var prompay;
  void initState() {
    super.initState();
    _getUserId();
  }

  _getUserId() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    SharedPreferences member = await SharedPreferences.getInstance();

    setState(() {
      path = user.getString('path');
      adminId = user.getString('admin_id');
      //admin_name = user.getString('admin_name');
      waterId = member.getString('water_id');

      peviceData();
      //print('this admin id :'+adminId);
      //print('this water id :'+waterId);
    });
  }

  void peviceData() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_recive.php");
    //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_bill.php");
    var data = {"water_id": '${waterId}', "admin_id": '${adminId}'};
    // print(data);
    var response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
    });

    print(response.body);

    var res = jsonDecode(response.body);
    var mapData = dataReciveFromJson(jsonEncode(res['data']));

    var dataall = mapData.map((e) {
      setState(() {
        realId = e.unidIdReal;
        profile_name = e.profileName;
        profile_tax = e.profileTax;
        profile_address = e.profileAddress;
        profile_phone = e.profilePhone;
        unit_id = e.unitId;
        date_now = e.dateNow;
        userName = e.userName;
        user_address = e.userAddress;
        id_card = e.idCard;
        user_tax = e.userTax;
        date_last = e.lastDate;
        last_unit = e.lastUnit;
        now_date = e.nowDate;
        //now_unit = e.nowDate;
        now_unit = e.nowUnit;
        unit_use = e.unitUse;
        unit_pay = e.unitPay;
        unit_service = e.unitService;
        other_name = e.unitOtherName;
        amont_other = e.unitOtherPay;
        total_pay = e.unitTotalPay;
        admin_name = e.adminName;
        mon_now = e.monNow;
        mon_last = e.monLast;
        meterLast = e.meterLast;
        last_input = e.lastInput;
        last_total = e.lastTotal;
        prompay = e.pormpay;
      });
    });
    print(dataall);
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();

    var data = await rootBundle.load("assets/font/THSarabunNew.ttf");
    var myFont = pw.Font.ttf(data);
    var myStyle = myFont;
    var styleText = pw.TextStyle(font: myStyle, fontSize: 10);
    var styleTable = pw.TextStyle(
      font: myFont,
      fontSize: 8,
      fontBold: myFont,
    );
    var qrCode = pw.BarcodeWidget(
      color: PdfColor.fromHex("#000000"),
      barcode: pw.Barcode.qrCode(),
      data: "http://${path}/confirmpay.php?unit_id=${realId}",
      height: 50,
      width: 50,
    );
    var barCode = pw.BarcodeWidget(
      color: PdfColor.fromHex("#000000"),
      barcode: pw.Barcode.code128(),
      data: "${unit_id}",
      height: 30,
      width: double.infinity,
      textStyle: styleText,
    );
    //chek prompay

    var url = "http://${path}/img/icon/${prompay}";
    var response = await http.get(Uri.parse(url));
    var dataImg = response.bodyBytes;
    var _image = pw.MemoryImage(dataImg);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat(5.4 * PdfPageFormat.cm, 24 * PdfPageFormat.cm,
            marginAll: 0.3 * PdfPageFormat.cm),
        build: (context) => [
          pw.Container(
            child: pw.Center(
              child: pw.Text(
                'ใบแจ้งหนี้ค่าน้ำ',
                style: pw.TextStyle(
                  font: myFont,
                  fontSize: 14,
                  fontBold: myFont,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ),
          pw.Text(
            profile_name,
            style: styleText,
          ),
          pw.Text(
            'เลขประจำตัวผู้เสียภาษี : ' + profile_tax,
            style: styleText,
          ),
          pw.Text(
            profile_address + '      โทร: ' + profile_phone,
            style: styleText,
          ),
          pw.Text(
            '===============================',
            style: styleText,
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'เลขที่ : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  unit_id,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'วันเดือนปี : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  date_now,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'เลขที่ผู้ใช้น้ำ : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  waterId,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'ชื่อ-นามสกุล : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  userName,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'ที่อยู่ : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  user_address,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'เลขบัตรประจำตัว : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  id_card,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'เลขประจำตัวผู้เสียภาษี : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  user_tax,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'อ่านครั้งก่อน : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  date_last,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'เลขมาตรครั้งก่อน : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  last_unit,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'อ่านครั้งนี้ : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  now_date,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'เลขมาตรครั้งนี้ : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  now_unit,
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'จำนวนที่ใช้ไป : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  unit_use + '  ลบ.ม.',
                  style: styleText,
                ),
              ),
            ],
          ),
          pw.Text(
            '===============================',
            style: styleText,
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  date_now + ': ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  'จำนวนเงิน (บาท)',
                  style: styleText,
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'ค่าน้ำ: ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  unit_pay,
                  style: styleText,
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'ค่าบริการ: ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  unit_service,
                  style: styleText,
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'ค่าอื่นๆ : ' + other_name,
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  amont_other,
                  style: styleText,
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  'รวมทั้งสิ้น : ',
                  style: styleText,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  total_pay,
                  style: styleText,
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
          pw.Text(
            '===============================',
            style: styleText,
          ),
          pw.Center(
            child: pw.Text(
              'ผู้แจ้ง ' + admin_name,
              style: pw.TextStyle(
                font: myFont,
                fontSize: 12,
                fontBold: myFont,
              ),
            ),
          ),
          pw.Center(
            child: pw.Text(
              'ผู้ดูแลระบบ/Admin',
              style: pw.TextStyle(
                font: myFont,
                fontSize: 12,
                fontBold: myFont,
              ),
            ),
          ),
          pw.Center(
            child: pw.Text(
              '+++ขอบคุณที่ใข้บริการ กรุณาตรวจสอบเงินทอนทุกครั้ง+++',
              style: styleTable,
            ),
          ),
          pw.Text(
            'ค่าน้ำย้อนหลัง 2 เดือน',
            style: pw.TextStyle(
              font: myFont,
              fontSize: 10,
              fontBold: myFont,
            ),
          ),
          pw.Table(
            border: pw.TableBorder.all(),
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: <pw.TableRow>[
              pw.TableRow(
                children: [
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        'เดือน',
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        'เลขมิเตอร์',
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        'จำนวนหน่วย',
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        'จำนวนเงิน',
                        style: styleTable,
                      ),
                    ),
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 3),
                    width: 20,
                    child: pw.Text(
                      mon_now,
                      style: styleTable,
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        last_unit,
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        unit_use,
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        total_pay,
                        style: styleTable,
                      ),
                    ),
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 3),
                    width: 20,
                    child: pw.Text(
                      mon_last,
                      style: styleTable,
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        meterLast,
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        last_input,
                        style: styleTable,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 20,
                    child: pw.Center(
                      child: pw.Text(
                        last_total,
                        style: styleTable,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Column(children: [
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Text(
                      'สแกนชำระเงิน',
                      style: styleText,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Text(
                      'แจ้งชำระเงิน',
                      style: styleText,
                    ),
                  ),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Image(
                      _image,
                      width: 60,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: qrCode,
                  ),
                ),
              ],
            ),
          ]),
          pw.SizedBox(
            height: 10,
          ),
          barCode,
        ],
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[400], title: Text('ปริ้นใบแจ้งค่าน้ำ')),
      body: admin_name == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PdfPreview(
              build: (format) => _generatePdf(format, 'test'),
            ),
    );
  }
}
