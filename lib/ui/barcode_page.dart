import 'package:barcode_generator/ui/widgets/barcode_view.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BarcodePage extends StatefulWidget {
  final String title;
  final Barcode barcode;
  final String date;

  const BarcodePage({super.key, required this.title, required this.barcode, required this.date});

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> with RouteAware {
  @override
  void initState() {
    super.initState();
    ScreenBrightness().setScreenBrightness(0.9);
  }

  @override
  void dispose() {
    super.dispose();
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BarcodeView(data: widget.date, barcode: widget.barcode),
    );
  }
}
