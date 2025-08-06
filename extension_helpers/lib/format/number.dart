part of 'format.dart';

extension ExtNumberFormats on num {
  String get compact => () {
        return NumberFormat.compact().format(this);
      }();
}
