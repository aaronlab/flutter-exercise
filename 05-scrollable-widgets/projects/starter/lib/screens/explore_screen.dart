import 'package:flutter/material.dart';
import '../components/friend_post_list_view.dart';
import '../components/components.dart';
import '../api/mock_fooderlich_service.dart';
import '../models/explore_data.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        /// When the connection state is `done`...
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          final friendPosts = snapshot.data?.friendPosts ?? [];

          return ListView(
            children: [
              TodayRecipeListView(recipes: recipes),
              const SizedBox(
                height: 16,
              ),
              FriendListPostListView(friendPosts: friendPosts),
            ],
          );
        }

        /// Otherwise, it's still being loaded...
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
