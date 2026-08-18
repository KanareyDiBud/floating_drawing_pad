import 'package:flutter/material.dart';
import 'features/overlay/presentation/widgets/overlay_window.dart';
import 'features/overlay/presentation/pages/home_page.dart';

Future<void> main() async {
  runApp(const ScreenPainter());
}

class ScreenPainter extends StatelessWidget {
  const ScreenPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Drawing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, dynamicSchemeVariant: DynamicSchemeVariant.fidelity, contrastLevel: -0.3),
            useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PainterOverlayWidget(),
  ));
}
