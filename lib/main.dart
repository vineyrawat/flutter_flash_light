import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEnabled = false;
  bool isTorchAvailable = false;

  @override
  void initState() {
    super.initState();
    TorchLight.isTorchAvailable().then((value) async {
      setState(() {
        isTorchAvailable = value;
      });
      if (value) {
        await TorchLight.disableTorch();
      }
    });
  }

  void handleTorch() async {
    if (isEnabled) {
      await TorchLight.disableTorch();
      setState(() {
        isEnabled = false;
      });
    } else {
      await TorchLight.enableTorch();
      setState(() {
        isEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                iconSize: 50,
                enableFeedback: true,
                color: isEnabled ? Colors.amber : null,
                onPressed: () => handleTorch(),
                icon: Icon(isEnabled
                    ? Icons.flash_off_rounded
                    : Icons.flash_on_rounded))
          ],
        ),
      ),
    );
  }
}
