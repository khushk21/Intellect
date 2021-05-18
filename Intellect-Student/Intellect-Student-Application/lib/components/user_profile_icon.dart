import 'package:flutter/material.dart';

class UserProfileIcon extends StatelessWidget {
  const UserProfileIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            Icons.person,
            size: 40,
          ),
          radius: 40.0,
        ),
        title: Row(
          children: [
            Text(
              "Username",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'ConcertOne',
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Text(
              'LV 2',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15.0,
                fontFamily: 'ConcertOne',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              value: 0.7,
            ),
            SizedBox(width: 10),
            Text(
              '70/100',
              style: TextStyle(fontFamily: 'ConcertOne'),
            ),
          ],
        ),
      ),
    );
  }
}
