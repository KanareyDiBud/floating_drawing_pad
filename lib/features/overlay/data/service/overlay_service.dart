import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:screendraw/features/overlay/domain/entities/app_overlay_position.dart';

class OverlayService {
  Future<bool> isPermissionGranted() async {
    return await FlutterOverlayWindow.isPermissionGranted();
  }

  Future<bool?> requestPermission() async {
    return await FlutterOverlayWindow.requestPermission();
  }

  Future<void> showOverlay(int width, int height) async {
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      width: width,
      height: height,
    );
  }

  Future<AppOverlayPosition> getPosition() async {
    OverlayPosition pos = await FlutterOverlayWindow.getOverlayPosition();
    return AppOverlayPosition(x: pos.x, y: pos.y);
  }


  Future<void> resizeOverlay(int width, int height, bool enableDrag) {
    return FlutterOverlayWindow.resizeOverlay(width, height, enableDrag);
  }

  Future<bool?> closeOverlay() async {
    return FlutterOverlayWindow.closeOverlay();
  }

}