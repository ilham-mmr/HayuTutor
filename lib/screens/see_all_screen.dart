import 'package:flutapp/models/tutors.dart';
import 'package:flutapp/widgets/favorite_badge.dart';
import 'package:flutapp/widgets/tutor_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tutors'),
        actions: [FavoriteBadge()],
      ),
      body: SafeArea(
        child: Consumer<TutorProvider>(
          builder: (context, tutor, _) => FutureBuilder(
            future: tutor.getCardTutors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data;
              return Column(
                children: data
                    .map<Widget>((tutorItem) => TutorCard(
                          tutor: tutorItem,
                          showButton: true,
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
