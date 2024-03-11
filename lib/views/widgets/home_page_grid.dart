import 'package:dbu_gym/providers/exercises_provider.dart';
import 'package:dbu_gym/providers/home_page_grid_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePageGrid extends StatelessWidget {
  List<Map<String, String>> category;
  HomePageGrid({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final categoryName =
        Provider.of<HomePageGridProvider>(context, listen: false)
            .selectedCategory;

    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: category.length,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<ExercisesProvider>(context, listen: false)
                .setSearchParamter = category[index]['name']!.toLowerCase();

            Provider.of<ExercisesProvider>(context, listen: false)
                .setCategoryName = categoryName;

            Provider.of<ExercisesProvider>(context, listen: false)
                .getExercises();

            GoRouter.of(context).pushNamed("exercise-category");
          },
          child: Card(
            elevation: 1,
            surfaceTintColor: Colors.transparent,
            color: categoryName == "difficulty"
                ? difficultyCategoryColors[index].darken(20)
                : Theme.of(context).colorScheme.background.darken(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (categoryName != "difficulty")
                    Image.asset(
                      category[index]['imagePath']!,
                      fit: BoxFit.cover,
                    )
                  else
                    Text(
                      category[index]['name']!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  if (categoryName != "difficulty")
                    Text(
                      category[index]['name']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
