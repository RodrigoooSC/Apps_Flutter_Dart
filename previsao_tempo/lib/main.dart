import 'package:flutter/material.dart';
import 'package:previsao_tempo/screens/home.dart';
import 'package:previsao_tempo/theme/theme.dart';

void main() {
  runApp(const PrevisaoTempo());
}

class PrevisaoTempo extends StatelessWidget {
  const PrevisaoTempo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      title: 'Previsão do Tempo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
