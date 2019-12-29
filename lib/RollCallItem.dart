import 'package:flutter/material.dart';
import 'package:my_flutter_app/RollCall.dart';

class RollCallItem extends StatelessWidget {
  final RollCall rollCall;
  RollCallItem(this.rollCall);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: rollCall);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 12),
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  "https://via.placeholder.com/150",
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    rollCall.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    rollCall.typeName,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(153, 153, 153, 1)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.check_circle),
              onPressed: () {},
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: rollCall.statusKey == 0
                    ? Color.fromRGBO(255, 191, 0, 1)
                    : rollCall.statusKey == 1 ? Colors.blue : Colors.green,
              ),
              padding: EdgeInsets.all(2),
              width: 50,
              child: Text(
                rollCall.statusName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
