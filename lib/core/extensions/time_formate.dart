import 'package:easy_localization/easy_localization.dart';

double timeFormat(String time) {
  return DateFormat("hh:mm:ss").parse(time).minute.ceilToDouble();
}

String timeFullFormat(String time) {
  print(time.runtimeType);

  var formatTime = DateTime.parse("20240629 00:0$time:00");
  return DateFormat.Hms().format(formatTime);
}



String timeFullFormatV3(String time) {
  try {
    var parsedTime = DateFormat("HH:mm:ss").parse(time);
    return _formatTime(parsedTime.hour, parsedTime.minute, parsedTime.second);
  } catch (_) {
    try {
      var parsedTime = DateFormat("HH:mm").parse(time);
      return _formatTime(parsedTime.hour, parsedTime.minute, 0);
    } catch (_) {
      try {
        var parsedTime = DateFormat("HH").parse(time);
        return _formatTime(parsedTime.hour, 0, 0);
      } catch (_) {
        throw FormatException("Invalid time format: $time");
      }
    }
  }
}

String _formatTime(int hours, int minutes, int seconds) {
  List<String> parts = [];

  if (hours > 0) {
    parts.add("$hours ${tr('rate.hours')}");
  }

  if (minutes > 0 || seconds > 0) {
    double decimalMinutes = minutes + (seconds / 60);
    parts.add("${decimalMinutes.toStringAsFixed(1)} ${tr('rate.minute')}");
  }

  return parts.join(" , ");
}


//
//
// String timeFullFormatV2(String time) {
//   try {
//     var parsedTime = DateFormat("HH:mm:ss").parse(time);
//     return _formatTime(parsedTime.hour, parsedTime.minute, parsedTime.second);
//   } catch (_) {
//     try {
//       var parsedTime = DateFormat("HH:mm").parse(time);
//       return _formatTime(parsedTime.hour, parsedTime.minute, 0);
//     } catch (_) {
//       try {
//         var parsedTime = DateFormat("HH").parse(time);
//         return _formatTime(parsedTime.hour, 0, 0);
//       } catch (_) {
//         throw FormatException("Invalid time format: $time");
//       }
//     }
//   }
// }
//
// String _formatTime(int hours, int minutes, int seconds) {
//   List<String> parts = [];
//
//   if (hours > 0) {
//     parts.add("$hours ${tr('rate.hours')}");
//   }
//   if (minutes > 0) {
//     parts.add("$minutes ${tr('rate.minute')}");
//   }
//   if (seconds > 0) {
//     parts.add("$seconds ${tr('rate.secs')}");
//   }
//
//   return parts.join(" , ");
// }

