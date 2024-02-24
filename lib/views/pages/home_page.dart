import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final userId = auth.currentUser!.uid;

    return AppZoomDrawer(
      appBarActions: [],
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
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // mainAxisSpacing: 8,
                          // crossAxisSpacing: 4,
                        ),
                        itemCount: exerciseCategories.length,
                        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0.8,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    exerciseCategories[index]['imagePath']!,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    exerciseCategories[index]['exerciseName']!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              await auth.signOut();
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
