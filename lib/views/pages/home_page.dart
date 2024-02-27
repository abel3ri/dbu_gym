import 'package:dbu_gym/providers/home_page_grid_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/app_drawer.dart';
import 'package:dbu_gym/views/widgets/home_page_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<HomePageGridProvider>(context);

    return AppZoomDrawer(
      title: Text("DBU Gym"),
      appBarActions: [
        PopupMenuButton(
          elevation: 0,
          onSelected: (value) {
            // print(value);
            Provider.of<HomePageGridProvider>(context, listen: false)
                .changeCategory(value);
          },
          initialValue: categoryProvider.selectedCategory,
          padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "muscle",
              child: Text("Categorize by muscle group"),
            ),
            PopupMenuItem(
              value: "equipment",
              child: Text("Categorize by equipment type"),
            ),
            PopupMenuItem(
              value: "difficulty",
              child: Text("Categorize by difficulty"),
            ),
          ],
        ),
      ],
      mainScreen: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(child: Center(child: Text("Workouts"))),
                    Tab(child: Center(child: Text("Calculate BMI"))),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      HomePageGrid(
                        category: categoryProvider.selectedCategory == "muscle"
                            ? muscleGroupCategories
                            : categoryProvider.selectedCategory == "equipment"
                                ? equipmentTypeCategories
                                : difficultyCategories,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              await auth.signOut();
                              GoRouter.of(context)
                                  .pushReplacementNamed("splash");
                            },
                            child: Text("Sign out")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
