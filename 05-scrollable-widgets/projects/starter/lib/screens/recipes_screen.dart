import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/recipes_grid_view.dart';
import '../models/models.dart';

class RecipesScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data ?? [];
          return RecipesGridView(recipes: recipes);
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
