import 'package:easy_localization/easy_localization.dart';

double timeFormat(String time) {
  return DateFormat("hh:mm:ss").parse(time).minute.ceilToDouble();
}

String timeFullFormat(String time) {
  print(time.runtimeType);
  var formatTime = DateTime.parse("20240629 00:0$time:00");
  return DateFormat.Hms().format(formatTime);
}
