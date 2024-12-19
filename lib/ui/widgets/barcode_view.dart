import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({
    super.key,
    required this.data,
    required this.barcode,
  });

  final String data;
  final Barcode barcode;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: data.isNotEmpty ? BarcodeWidget(barcode: barcode, data: data) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
