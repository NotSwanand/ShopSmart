import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan(); // No need to specify options
      debugPrint("Scanned Value: ${result.rawContent}"); // Debug output

      if (result.rawContent.isNotEmpty) {
        Navigator.pop(context, result.rawContent);
      } else {
        Navigator.pop(context, null);
      }
    } catch (e) {
      debugPrint("Scan error: $e");
      Navigator.pop(context, null);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, scanBarcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
