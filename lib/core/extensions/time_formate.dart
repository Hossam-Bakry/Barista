import 'package:easy_localization/easy_localization.dart';

double timeFormat(String time) {
  return DateFormat("hh:mm:ss").parse(time).minute.ceilToDouble();
}
