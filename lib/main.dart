import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:meu_patrimonio/config/dependencies.dart';
import 'package:meu_patrimonio/data/local/objectbox.dart';
import 'package:meu_patrimonio/ui/app_widget.dart';
import 'package:provider/provider.dart';

late ObjectBox objectbox;

Future<void> main() async {
  Logger.root.level = Level.ALL;

  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}
