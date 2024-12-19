import 'package:barcode_generator/provider/barcode_provider.dart';
import 'package:barcode_generator/ui/barcode_edit_page.dart';
import 'package:barcode_generator/ui/widgets/barcode_view.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BarcodeItemPage extends StatefulWidget {
  const BarcodeItemPage({super.key, required this.index});

  final int index;

  @override
  State<BarcodeItemPage> createState() => _BarcodeItemPageState();
}

class _BarcodeItemPageState extends State<BarcodeItemPage> with RouteAware {
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
    return Consumer<BarcodeProvider>(builder: (context, barcodeProvider, child) {
      String title = "";
      Barcode barcode = Barcode.code39();
      String data = "";

      if (barcodeProvider.getLength() > widget.index) {
        final item = barcodeProvider.get(widget.index);
        title = item.label;
        barcode = item.barcodeType.getBarcode;
        data = item.data;
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          actions: [IconButton(onPressed: _onEditTap, icon: const Icon(Icons.edit))],
        ),
        body: BarcodeView(data: data, barcode: barcode),
      );
    });
  }

  void _onEditTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BarcodeEditPage(index: widget.index),
    ));
  }
}
