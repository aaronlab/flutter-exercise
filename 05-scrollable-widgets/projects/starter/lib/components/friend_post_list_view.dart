import 'package:flutter/material.dart';
import 'components.dart';
import '../models/models.dart';

class FriendListPostListView extends StatelessWidget {
  final List<Post> friendPosts;

  const FriendListPostListView({Key? key, required this.friendPosts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
            /// Whether this is the primary scroll view
            /// associated with the parent
            primary: false,

            /// How the scroll view should respond to user input.
            /// https://api.flutter.dev/flutter/widgets/ScrollPhysics-class.html
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final post = friendPosts[index];
              return FriendPostTitle(post: post);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: friendPosts.length,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
