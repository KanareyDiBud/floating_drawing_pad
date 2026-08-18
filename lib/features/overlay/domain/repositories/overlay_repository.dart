import 'package:screendraw/features/overlay/domain/entities/app_overlay_position.dart';

abstract class OverlayRepository {
  Stream<Map<String, dynamic>> get overlayDataStream;
  Future<void> updateTheme(bool isDark);
  Future<void> updateOverlayState(Map<String, dynamic> data);
  Future<bool> isPermissionGranted();
  Future<bool?> requestPermission();
  Future<void> showOverlay(int width, int height);
  Future<bool?> closeOverlay();
  Future<void> resizeOverlay(int width, int height, bool enableDrag);
  Future<AppOverlayPosition> getPosition();
}