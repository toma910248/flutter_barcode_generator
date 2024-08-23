import 'package:barcode_generator/provider/barcode_provider.dart';
import 'package:barcode_generator/ui/barcode_edit_page.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key, required this.index});

  final int index;

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> with RouteAware {
  @override
  void initState() {
    super.initState();

    ScreenBrightness().setScreenBrightness(0.9);
    Provider.of<BarcodeProvider>(context, listen: false).init();
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

      if (barcodeProvider.barcodeItems.isNotEmpty) {
        final item = barcodeProvider.barcodeItems[widget.index];
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: data.isNotEmpty ? BarcodeWidget(barcode: barcode, data: data) : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _onEditTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BarcodeEditPage(index: widget.index),
    ));
  }
}
