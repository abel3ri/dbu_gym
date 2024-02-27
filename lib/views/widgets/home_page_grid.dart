import 'package:dbu_gym/providers/home_page_grid_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
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
          onTap: () {},
          child: Card(
            elevation: 0.8,
            color: category[index]['difficulty'] != null
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
                      category[index]['difficulty']!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  if (categoryName == 'muscle')
                    Text(
                      category[index]['muscleName']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  if (categoryName == "exercise")
                    Text(
                      category[index]['exerciseTypeName']!,
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
