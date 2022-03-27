import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../models/models.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const Center(
            child: Text('Show TodayRecipeListView'),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      },
    );
  }
}
