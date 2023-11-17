import 'package:flutter/material.dart';
import 'package:mysql_flutter_2/screen/data_table_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MySQL tutorial 2',
      home: DataTableDemo(),
    );
  }
}
