import 'package:dbu_gym/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Center(child: Text("Workouts")),
                  ),
                  Tab(
                    child: Center(child: Text("Calculate BMI")),
                  ),
                  Tab(
                    child: Center(child: Text("Subscription")),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: TextButton(
                          onPressed: () async {
                            await auth.signOut();
                          },
                          child: Text("Sign out")),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () async {
                            await auth.signOut();
                          },
                          child: Text("Sign out")),
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
    );
  }
}
