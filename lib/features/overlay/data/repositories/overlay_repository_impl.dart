import 'dart:ui';

import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:screendraw/features/overlay/domain/entities/app_overlay_position.dart';

import '../service/overlay_service.dart';
import '../../domain/repositories/overlay_repository.dart';

class OverlayRepositoryImpl implements OverlayRepository {
  final OverlayService _overlayService;
  OverlayRepositoryImpl(this._overlayService);

  double get _pixelRatio => PlatformDispatcher.instance.views.first.devicePixelRatio;

  @override
  Stream<Map<String, dynamic>> get overlayDataStream {
    return FlutterOverlayWindow.overlayListener.map((event) {
      if (event is Map) {
        return Map<String, dynamic>.from(event);
      }
      return <String, dynamic>{};
    });
  }

  @override
  Future<void> updateOverlayState(Map<String, dynamic> data) async {
    await FlutterOverlayWindow.shareData(data);
  }

  @override
  Future<void> updateTheme(bool isDark) {
    throw UnimplementedError();
  }

  @override
  Future<void> resizeOverlay(int width, int height, bool enableDrag) {
    width = (width/_pixelRatio).round();
    height = (height/_pixelRatio).round();
    return _overlayService.resizeOverlay(width, height, enableDrag);
  }

  @override
  Future<bool> isPermissionGranted() {
    return _overlayService.isPermissionGranted();
  }

  @override
  Future<bool?> requestPermission() {
    return _overlayService.requestPermission();
  }

  @override
  Future<AppOverlayPosition> getPosition() {
    return _overlayService.getPosition();
  }

  @override
  Future<void> showOverlay(int width, int height) {
    return _overlayService.showOverlay(width, height);
  }

  @override
  Future<bool?> closeOverlay() {
    return _overlayService.closeOverlay();
  }
}
