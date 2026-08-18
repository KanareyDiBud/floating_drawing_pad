import 'package:flutter/cupertino.dart';

class PainterController extends ChangeNotifier {
  final List<Offset?> _points = [];
  List<Offset?> get points => List.unmodifiable(_points);

  void addPoints(Offset? point) {
    _points.add(point);
    notifyListeners();
  }

  void clearCanvas() {
    _points.clear();
    notifyListeners();
  }

}