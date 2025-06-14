import 'package:easy_localization/easy_localization.dart';

double timeFormat(String time) {
  return DateFormat("hh:mm:ss").parse(time).minute.ceilToDouble();
}

// String timeFullFormat(String time) {
//   print(time.runtimeType);
//
//   var formatTime = DateTime.parse("20240629 00:0$time:00");
//   return DateFormat.Hms().format(formatTime);
// }
String timeFullFormat(String time) {
  var formatTimes = time.split(':');

  DateTime dateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    int.tryParse(formatTimes.isNotEmpty ? formatTimes[0] : "0") ?? 0,
    int.tryParse(formatTimes.length > 1 ? formatTimes[1] : "0") ?? 0,
    int.tryParse(formatTimes.length > 2 ? formatTimes[2] : "0") ?? 0,
  );
  print("time amr ${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
  return dateTime.toString();

}

String parseTimeFromController(String time) {
  // Split the time from the controller text
  var formatTimes = time.split(':');

  // Create a DateTime object with the parsed values
  DateTime dateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    int.tryParse(formatTimes.isNotEmpty ? formatTimes[0] : "0") ?? 0,
    int.tryParse(formatTimes.length > 1 ? formatTimes[1] : "0") ?? 0,
    int.tryParse(formatTimes.length > 2 ? formatTimes[2] : "0") ?? 0,
  );

  // Print the time for debugging
  print("time amr ${dateTime.hour}:${dateTime.minute}:${dateTime.second}");

  // Return the DateTime as a string
  return dateTime.toString();
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

String timeFormatV4(String time) {
  var formatTimes = time.split(':');
  print("convert time: $time");
  print("format times: $formatTimes");

  String timeFormat = "";
  if (formatTimes.isNotEmpty && formatTimes[0] != "00") {
    timeFormat = "${formatTimes[0]}Hrs ";
    print("format time1: $timeFormat");
  }

  if (formatTimes.length > 1 && formatTimes[1] != "00") {
    timeFormat += "${formatTimes[1]}Mins ";
    print("format time2: $timeFormat");
  }

  if (formatTimes.length > 2 && formatTimes[2] != "00") {
    timeFormat += ":${formatTimes[2]}Secs ";
    print("format time3: $timeFormat");
  }

  return timeFormat;
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
