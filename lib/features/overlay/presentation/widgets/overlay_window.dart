import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:screendraw/features/overlay/data/service/overlay_service.dart';
import 'package:screendraw/features/overlay/data/repositories/overlay_repository_impl.dart';
import 'package:screendraw/features/overlay/domain/entities/app_overlay_position.dart';
import '../controllers/overlay_controller.dart';
import '../controllers/painter_controller.dart';
import 'overlay_painter.dart';

class PainterOverlayWidget extends StatefulWidget {
  const PainterOverlayWidget({super.key});

  @override
  State<PainterOverlayWidget> createState() => _PainterOverlayWidgetState();
}

class _PainterOverlayWidgetState extends State<PainterOverlayWidget> {
  late final OverlayController _overlayController;
  late final PainterController _painterController;

  int currentWidth = 0;
  int currentHeight = 0;
  bool isMinimized = false;
  int topbarHeight = 0;
  bool theme = true;


  @override
  void initState() {
    super.initState();

    _painterController = PainterController();

    final overlayService = OverlayService();
    final overlayRepository = OverlayRepositoryImpl(overlayService);

    _overlayController = OverlayController(overlayRepository);


    FlutterOverlayWindow.overlayListener.listen((event) {
      currentWidth = event['width'] ?? currentWidth;
      currentHeight = event['height'] ?? currentHeight;
      topbarHeight = event['topbarheight'] ?? topbarHeight;
      theme = event['theme'] ?? theme;
    });

  }

  @override
  void dispose() {
    super.dispose();
    _overlayController.dispose();
    _painterController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
      listenable: _overlayController,
      builder: (context, child) {return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  width: 40,
                  color: !_overlayController.isDark ? Color(0xff2150da): Color(0xff1e1e20),
                ),
              ),
              GestureDetector(
                onTap: () {setState(() {
                  isMinimized = !isMinimized;
                  if (isMinimized) {
                    _overlayController.changeDragMode(currentWidth, topbarHeight, true);
                  } else {
                    _overlayController.changeDragMode(currentWidth, currentHeight, true);
                  }

                });},
                child: Container(
                  height: 40,
                  width: 40,
                  color: Color(0xff3e66ec),
                  child: Icon(Icons.minimize),
                ),
              ),
              GestureDetector(
                onTap: () => _painterController.clearCanvas(),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Color(0xff456ef3),
                  child: Icon(Icons.delete),
                ),
              ),
              GestureDetector(
                onTap: () => _overlayController.closeOverlay(),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Color(0xffd35233),
                  child: Icon(Icons.close),
                ),
              )
            ],
          ),
          if (!isMinimized)
          Expanded(
            flex: 1,
            child:
              ListenableBuilder(
                listenable: _painterController,
                builder: (context, child) {
                  return GestureDetector(
                      onPanStart: (details) async {

                        await _overlayController.changeDragMode(currentWidth, currentHeight, false);
                        _painterController.addPoints(details.localPosition);
                        final AppOverlayPosition pos = await _overlayController.getPosition();
                        //print("-- X ${pos.x} Y ${pos.y}");
                      },
                      onPanUpdate: (details) {
                        _painterController.addPoints(details.localPosition);
                      },
                      onPanEnd: (details) async {

                        await _overlayController.changeDragMode(currentWidth, currentHeight, true);
                        _painterController.addPoints(null);
                        //print(_overlayController.isDragEnabled);
                        final AppOverlayPosition pos = await _overlayController.getPosition();
                        //print("-- X ${pos.x} Y ${pos.y}");
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              //color: Color(0xffebe9d8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    //border: Border.all(color: Color(0xffebe9d8), width: 4)
                                    border: Border.symmetric(vertical: BorderSide(
                                        color: Color(0xffebe9d8), width: 3),
                                        horizontal: BorderSide(
                                            color: Color(0xffebe9d8), width: 5))
                                ),
                              child: CustomPaint(
                                painter: OverlayPainter(_painterController.points),
                                size: Size.infinite,
                              ),
                            ),
                          )
                        ],
                      ),

                  );
                }
              ),
          ),
        ],
      );
      }
    );
  }
}
