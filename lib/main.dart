import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:barcode_generator/provider/barcode_provider.dart';
import 'package:barcode_generator/ui/barcode_list_page.dart';
import 'package:barcode_generator/ui/barcode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => BarcodeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterShortcuts _flutterShortcuts = FlutterShortcuts();
  BarcodePage? _actionBarcodePage;

  @override
  void initState() {
    super.initState();
    _flutterShortcuts.initialize(debug: false);
    _flutterShortcuts.listenAction((String incomingAction) {
      final uri = Uri.parse(incomingAction);
      final label = uri.queryParameters['label'];
      final barcodeType = uri.queryParameters['barcodeType'];
      final data = uri.queryParameters['data'];

      if (label != null && barcodeType != null && data != null) {
        setState(() {
          final type = BarcodeTypeEnum.values.firstWhere((element) => element.value == barcodeType);
          _actionBarcodePage = BarcodePage(
            title: label,
            barcode: type.getBarcode,
            date: data,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Generator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: _actionBarcodePage ?? const BarcodeListPage(),
    );
  }
}
