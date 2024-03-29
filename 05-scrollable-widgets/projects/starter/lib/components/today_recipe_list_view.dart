import 'package:flutter/material.dart';

import '../models/explore_recipe.dart';
import '../models/models.dart';
import 'card1.dart';
import 'card2.dart';
import 'card3.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipes of the day 🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            height: 400.0,
            color: Colors.transparent,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return buildCard(recipe);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 16.0,
                );
              },
              itemCount: recipes.length,
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    }

    if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    }

    if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    }

    return Card1(recipe: recipe);
  }
}
