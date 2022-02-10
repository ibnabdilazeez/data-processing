import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart totals.dart <fileName.csv>');
    exit(1);
  }
  final fileName = args.first;
  final lines = File(fileName).readAsLinesSync();
  final totalDurationByTag = <String, double>{};
  lines.removeAt(0);
  var totalDuration = 0.0;
  for (var line in lines) {
    final values = line.split(',');
    final durationString = values[3].replaceAll('"', '');
    final duration = double.parse(durationString);
    //print(durationString);
    final tag = values[5].replaceAll('"', '');
    final previousTotalDuration = totalDurationByTag[tag];
    if (previousTotalDuration == null) {
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = (previousTotalDuration + duration);
    }
    totalDuration += duration;
  }
  for (var entry in totalDurationByTag.entries) {
    final formattedDuration = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'unallocated' : entry.key;
    print('$tag: ${formattedDuration}h');
  }
  print('Total time spent: ${totalDuration.toStringAsFixed(1)}h');
}
