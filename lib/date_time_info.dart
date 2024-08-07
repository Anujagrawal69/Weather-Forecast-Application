import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInfo extends StatefulWidget {
  const DateTimeInfo({super.key, required this.noww});
  final DateTime noww;

  @override
  State<DateTimeInfo> createState() => _DateTimeInfoState();
}

class _DateTimeInfoState extends State<DateTimeInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat("h:mm a").format(widget.noww),
          style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 238, 237, 237),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          '|  ${DateFormat('EEEE').format(widget.noww)}, ${DateFormat('d').format(widget.noww)} ${DateFormat('MMMM').format(widget.noww)}',
          style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 238, 237, 237),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
