import 'package:flutter/material.dart';
class ColumnTime extends StatelessWidget {
  final String label;
  final IconData icon;
  final String day;
  final String time;
  ColumnTime({this.label="BEDTIME",this.icon= Icons.king_bed,this.day='Tomorrow',this.time='01:40'});
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.white.withOpacity(0.8),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8)),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2,bottom: 4),
          child: Text(
            time,
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          day,
          style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8)),
        )
      ],
    );
  }
}
