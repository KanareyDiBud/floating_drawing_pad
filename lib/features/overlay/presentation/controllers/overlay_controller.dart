import 'package:flutter/cupertino.dart';
import 'package:screendraw/features/overlay/domain/entities/app_overlay_position.dart';
import 'package:screendraw/features/overlay/domain/repositories/overlay_repository.dart';

class OverlayController extends ChangeNotifier {
  final OverlayRepository _repository;

  OverlayController(this._repository);

  int _currentWidth = 0;
  int _currentHeight = 0;
  bool _isDragEnabled = true;
  bool _isDark = false;


  int get currentWidth => _currentWidth;
  int get currentHeight => _currentHeight;
  bool get isDragEnabled => _isDragEnabled;
  bool get isDark => _isDark;

  Future<bool> isPermissionGranted() async {
    return await _repository.isPermissionGranted();
  }

  Future<bool?> requestPermission() async {
    return await _repository.requestPermission();
  }

  Future<AppOverlayPosition> getPosition() async {
    return await _repository.getPosition();
  }

  Future<void> showOverlay(int width, int height, bool theme) async {
    _currentWidth = width;
    _currentHeight = height;
    _isDragEnabled = true;
    _isDark = theme;
    //print(width);
    //print(height);
    await _repository.showOverlay(width, height);
    notifyListeners();
  }

  Future<void> changeDragMode(int width, int height, bool enableDrag) async {
    print('ww ${width} hh ${height}');
    _isDragEnabled = enableDrag;
    await _repository.resizeOverlay(width, height, enableDrag);
    notifyListeners();
  }

  Future<bool?> closeOverlay() async {
    return await _repository.closeOverlay();
  }

}