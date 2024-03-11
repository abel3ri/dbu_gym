import 'package:dbu_gym/controllers/user_controller.dart';
import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/utils/extension.dart';
import 'package:dbu_gym/views/widgets/profile_page_row.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            // color: Colors.grey.shade200,
          ),
        ),
        title: Text("Profile"),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final GymUser user = (snapshot.data!.asRight as GymUser);
            final fullName =
                "${user.firstName.capitalize} ${user.lastName.capitalize}";
            final gymEndDate = user.gymEndDate;
            final gymStartDate = user.gymStartDate;
            final email = user.email;
            final numWorkoutDays = user.numWorkoutDays;
            final workoutPlan = user.subscribedWorkoutType;
            final profileImageUrl = user.profileImageUrl;
            return LayoutBuilder(
              builder: (context, constraints) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.03,
                  vertical: constraints.maxHeight * 0.02,
                ),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: snapshot.hasData
                                ? NetworkImage(profileImageUrl)
                                : null,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.06),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName.length > 15
                                  ? fullName.substring(0, 13) + "..."
                                  : fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.04),
                            Text(
                              email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.04),
                    Container(
                      width: constraints.maxWidth,
                      child: Card(
                        color:
                            Theme.of(context).colorScheme.background.darken(5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.02,
                            horizontal: constraints.maxWidth * 0.04,
                          ),
                          child: Column(
                            children: [
                              ProfilePageRow(
                                title: "Gym Start Date",
                                data: DateFormat.yMMMd("en-US").format(
                                  DateTime.parse(gymStartDate),
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.04),
                              ProfilePageRow(
                                title: "Gym End Date",
                                data: DateFormat.yMMMd("en-US").format(
                                  DateTime.parse(gymEndDate),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth,
                      child: Card(
                        color:
                            Theme.of(context).colorScheme.background.darken(5),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.02,
                            horizontal: constraints.maxWidth * 0.04,
                          ),
                          child: Column(
                            children: [
                              ProfilePageRow(
                                  title: "Number of Workout Days",
                                  data: numWorkoutDays == 'oneThree'
                                      ? "1-3 Days"
                                      : "4-6 Days"),
                              if (numWorkoutDays == 'oneThree') ...[
                                SizedBox(height: constraints.maxHeight * 0.02),
                                Image.asset(
                                  'assets/images/${workoutPlan}.png',
                                  width: constraints.maxWidth * 0.9,
                                  height: constraints.maxHeight * 0.35,
                                ),
                              ],
                              if (numWorkoutDays == 'fourSix') ...[
                                SizedBox(height: constraints.maxHeight * 0.02),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/${workoutPlan.split("_")[0]}.png',
                                      // aerobics asset image is a bir large, so check if the plan has aerobics and render different image width size
                                      width: workoutPlan.split("_")[0] ==
                                              'aerobics'
                                          ? constraints.maxWidth * 0.3
                                          : constraints.maxWidth * 0.35,
                                      height: constraints.maxHeight * 0.35,
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.14,
                                      child: Center(
                                        child: Text(
                                          "&",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/${workoutPlan.split("_")[1]}.png',
                                      width: constraints.maxWidth * 0.35,
                                      height: constraints.maxHeight * 0.35,
                                    ),
                                  ],
                                ),
                              ],
                              SizedBox(height: constraints.maxHeight * 0.04),
                              ProfilePageRow(
                                title: "Workout Plan Type",
                                data: workoutPlan
                                    .replaceAll("_", " & ")
                                    .capitalize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
