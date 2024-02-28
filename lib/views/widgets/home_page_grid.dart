import 'package:dbu_gym/controllers/exercise_controller.dart';
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: category.length,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            BuildContext? dialogContext;
            showDialog(
              context: context,
              builder: (context) {
                dialogContext = context;
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  alignment: Alignment.center,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              },
            );

            final res = await ExerciseController(
              categoryName: categoryName,
              parameter: category[index]['name']!,
            ).getExercise();
            // print(res);
            res.fold((l) => print(l), (r) {
              GoRouter.of(dialogContext!).pop();
              GoRouter.of(context).pushNamed("exercise-category");
            });
          },
          child: Card(
            elevation: 0.8,
            color: categoryName == "difficulty"
                ? difficultyCategoryColors[index].darken(20)
                : null,
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
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  if (categoryName == 'muscle')
                    Text(
                      category[index]['name']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  if (categoryName == "equipment")
                    Text(
                      category[index]['name']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
