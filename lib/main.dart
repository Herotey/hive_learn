import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project_tests/book.dart';
import 'package:hive_project_tests/model.dart';
import 'package:hive_project_tests/screen.dart';

Box? box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  box = await Hive.openBox<Employee>('booksbox');
  Hive.registerAdapter(ImfoEmployee());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyBooks(),
    );
  }
}
