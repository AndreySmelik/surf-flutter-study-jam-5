import 'package:flutter/material.dart';
import 'package:meme_generator/models/image_button_model.dart';
import 'package:meme_generator/models/image_model.dart';
import 'package:meme_generator/models/meme_model.dart';
import 'package:meme_generator/screen/meme_generator_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MemeModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => ImageModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => ImageButtonModel(),
    ),
  ], child: const MyApp()));
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MemeGeneratorDemotivator(),
    );
  }
}
