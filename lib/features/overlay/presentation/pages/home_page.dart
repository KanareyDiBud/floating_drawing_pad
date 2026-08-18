import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:screendraw/features/overlay/data/repositories/overlay_repository_impl.dart';
import 'package:screendraw/features/overlay/data/service/overlay_service.dart';
import 'package:screendraw/features/overlay/domain/entities/app_overlay_position.dart';
import 'package:screendraw/features/overlay/presentation/widgets/permission_alert.dart';
import '../controllers/overlay_controller.dart';

const List<Widget> themes = <Widget>[
  Icon(Icons.sunny),
  Icon(Icons.nightlight),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final OverlayController _overlayController;

  final List<bool> _selectedTheme = <bool>[true,false];

  @override
  void initState() {
    super.initState();
    final overlayService = OverlayService();
    final overlayRepository = OverlayRepositoryImpl(overlayService);

    _overlayController = OverlayController(overlayRepository);

  }

  @override
  void dispose() {
    super.dispose();
    _overlayController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ratio = mediaQuery.devicePixelRatio;
    final size = mediaQuery.size;

    final width = (size.width * ratio * 0.8).toInt();
    final height = (size.height * ratio * 0.25).toInt();



    Future<void> openOverlay(bool theme) async {
      bool isPermission = await _overlayController.isPermissionGranted();
      if (!isPermission) {
        showPermissionAlert(context, _overlayController.requestPermission);
        return;
      }

      if (await FlutterOverlayWindow.isActive()) {
        FlutterOverlayWindow.closeOverlay();
      } else {
        await FlutterOverlayWindow.shareData({
          'width': width,
          'height': height,
          'topbarheight': (40 * ratio).toInt(),
          'theme': theme,
        });

        await _overlayController.showOverlay(width, height, theme);
        AppOverlayPosition pos = await _overlayController.getPosition();
        //print("-- X ${pos.x} Y ${pos.y}");
      }



    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Floating Drawing Pad',
              style: TextStyle(
                fontSize: 32,
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ToggleButtons(
                //   onPressed: (int index) async {
                //     setState(() {
                //       for (int i = 0; i < _selectedTheme.length; i++) {
                //         _selectedTheme[i] = i == index;
                //       }
                //
                //     });
                //     await FlutterOverlayWindow.shareData({
                //       'theme': _selectedTheme[1],
                //     });
                //   },
                //   children: themes,
                //   isSelected: _selectedTheme,
                //   borderRadius: BorderRadius.all(Radius.circular(48)),
                //   selectedBorderColor: _selectedTheme[0] ? Colors.blue.shade300 : Colors.grey.shade700,
                //   selectedColor: _selectedTheme[0] ? Colors.yellow.shade700 : Colors.grey.shade900,
                //   fillColor: _selectedTheme[0] ? Colors.blue.shade500 : Colors.grey.shade500,
                // ),
                // const SizedBox(width: 12,),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FilledButton(
                    onPressed: () => openOverlay(_selectedTheme[1]),
                    child: Text('Open Overlay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
