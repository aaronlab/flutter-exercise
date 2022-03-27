import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/models.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExploreScreen();
  }
}

class _ExploreScreen extends State<ExploreScreen> {
  final mockService = MockFooderlichService();
  late ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _checkListViewTopOrBottom();
    });
  }

  /// Check the position of the list view is on the top or bottom.
  void _checkListViewTopOrBottom() {
    if (!_scrollController.position.atEdge) { return; }

    final isTop = _scrollController.position.pixels == 0;

    if (isTop) {
      print('The list view is on the top!');
      return;
    }

    print('The list view is on the bottom!');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: [
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              const SizedBox(height: 16),
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? [])
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
