import 'package:deux_mille_quarante_huit/const/colors.dart';
import 'package:deux_mille_quarante_huit/widgets/board_widget.dart';
import 'package:deux_mille_quarante_huit/widgets/score_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/score_model.dart';

void main() {
  // Force portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(ChangeNotifierProvider(
          create: (context) => ScoreModel(), child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game by Liam',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: color0,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '2048 by Liam'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.white,
                child: const ScoreWidget(best: false),
              ),
              Container(
                color: Colors.white,
                child: const ScoreWidget(best: true),
              ),
            ],
          ),
          const BoardWidget(),
        ],
      ),
    );
  }
}
