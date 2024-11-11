import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:barcode_generator/provider/barcode_provider.dart';
import 'package:barcode_generator/ui/barcode_edit_page.dart';
import 'package:barcode_generator/ui/barcode_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class BarcodeListPage extends StatefulWidget {
  const BarcodeListPage({super.key});

  @override
  State<BarcodeListPage> createState() => _BarcodeListPageState();
}

class _BarcodeListPageState extends State<BarcodeListPage> {
  BarcodeProvider? _barcodeProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<BarcodeProvider>(
      builder: (BuildContext context, BarcodeProvider provider, Widget? child) {
        _barcodeProvider = provider;
        final items = provider.getAll();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Barcode Generator"),
          ),
          body: Center(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) => _buildItem(index, items[index]),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              padding: const EdgeInsets.only(bottom: 100),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _onAddTap,
            tooltip: 'Increment',
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildItem(int index, BarcodeItem item) {
    return Slidable(
      dragStartBehavior: DragStartBehavior.start,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (context) => _onItemDeleteTap(index),
          ),
        ],
      ),
      child: ListTile(
        title: Text(item.label),
        onTap: () => _onItemTap(index),
      ),
    );
  }

  _onItemTap(int index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BarcodePage(index: index),
    ));
  }

  _onItemDeleteTap(int index) {
    _barcodeProvider?.remove(index);
  }

  _onAddTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const BarcodeEditPage(),
    ));
  }
}
