import 'package:flutter/material.dart';

class TutorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Ilham Maman',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'RM12/hour',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Maths',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Banjar, west java',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80'),
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
