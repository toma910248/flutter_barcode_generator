import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:barcode_generator/provider/barcode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarcodeEditPage extends StatefulWidget {
  const BarcodeEditPage({super.key, this.index});

  final int? index;

  @override
  State<BarcodeEditPage> createState() => _BarcodeEditPageState();
}

class _BarcodeEditPageState extends State<BarcodeEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllerLabel = TextEditingController();
  final _controllerData = TextEditingController();
  BarcodeType _barcodeType = BarcodeType.code39;

  @override
  void initState() {
    super.initState();

    final index = widget.index;
    if (index != null) {
      final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
      final barcodeItem = barcodeProvider.get(index);
      _barcodeType = barcodeItem.barcodeType;
      _controllerLabel.text = barcodeItem.label;
      _controllerData.text = barcodeItem.data;
    }
  }

  @override
  void dispose() {
    _controllerLabel.dispose();
    _controllerData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 10.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_barcodeType.value),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controllerLabel,
                decoration: InputDecoration(
                  labelText: 'Label',
                  suffixIcon: IconButton(
                    onPressed: _controllerLabel.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  errorMaxLines: 3,
                ),
                validator: (String? value) => (value != null && value.isEmpty) ? '"Label" fields is required.' : null,
              ),
              const SizedBox(height: spacing),
              TextFormField(
                controller: _controllerData,
                decoration: InputDecoration(
                  labelText: 'Data',
                  suffixIcon: IconButton(
                    onPressed: _controllerData.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  errorMaxLines: 3,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return '"Data" fields is required.';
                  try {
                    _barcodeType.getBarcode.verify(value);
                  } catch (e) {
                    return e.toString();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _onSaveTap,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveTap() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
      var barcodeItem = BarcodeItem(_barcodeType, _controllerLabel.text, _controllerData.text);
      if (widget.index != null) {
        barcodeProvider.update(widget.index!, barcodeItem);
      } else {
        barcodeProvider.add(barcodeItem);
      }

      Navigator.pop(context);
    }
  }
}
