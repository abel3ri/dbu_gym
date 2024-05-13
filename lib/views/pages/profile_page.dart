import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/user_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/profile_page_row.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GymUser user = Provider.of<UserProvider>(context).user!;
    final fullName = "${user.firstName.capitalize} ${user.lastName.capitalize}";
    final gymEndDate = user.gymEndDate;
    final gymStartDate = user.gymStartDate;
    final email = user.email.length >= 15
        ? '${user.email.split("@")[0].substring(0, 7)}...@${user.email.split("@")[1]}'
        : user.email;
    final numWorkoutDays = user.numWorkoutDays;
    final workoutPlan = user.subscribedWorkoutType;
    final profileImageUrl = user.profileImageUrl;
    final phoneNumber = user.phoneNumber;
    final createdAt = user.createdAt;
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
      body: LayoutBuilder(
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
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                  ),
                  SizedBox(width: constraints.maxWidth * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          SizedBox(width: constraints.maxWidth * 0.01),
                          if (auth.currentUser!.emailVerified)
                            Icon(
                              Icons.verified,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        ],
                      ),
                      SizedBox(width: constraints.maxWidth * 0.04),
                      SizedBox(height: constraints.maxHeight * 0.004),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            email,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(" | "),
                          Text(
                            phoneNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight * 0.004),
                      Text(
                        "Joined ${DateFormat.yMMMd("en-US").format(createdAt)}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: auth.currentUser!.emailVerified
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                        ),
                        child: Text(
                          auth.currentUser!.emailVerified
                              ? "E-mail verified"
                              : "E-mail not verified",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 10,
                                  ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: constraints.maxHeight * 0.04),
              Container(
                width: constraints.maxWidth,
                child: Card(
                  color: Theme.of(context).colorScheme.background.darken(5),
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
                  color: Theme.of(context).colorScheme.background.darken(5),
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
                        // Since 4-6 Strength has on image only display it as 1-3 images are displayed
                        if (numWorkoutDays == 'oneThree' ||
                            workoutPlan == 'strength') ...[
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Image.asset(
                            'assets/images/${workoutPlan}.png',
                            width: constraints.maxWidth * 0.9,
                            height: constraints.maxHeight * 0.35,
                          ),
                        ],
                        // show image row only if workout days == 4-6 and not stregth plan
                        if (numWorkoutDays == 'fourSix' &&
                            workoutPlan != 'strength') ...[
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Image.asset(
                                  'assets/images/${workoutPlan.split("_")[0]}.png',
                                  // aerobics asset image is a bir large, so check if the plan has aerobics and render different image width size
                                  width: workoutPlan.split("_")[0] == 'aerobics'
                                      ? constraints.maxWidth * 0.3
                                      : constraints.maxWidth * 0.35,
                                  height: constraints.maxHeight * 0.35,
                                ),
                              ),
                              Center(
                                child: Text("&"),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  'assets/images/${workoutPlan.split("_")[1]}.png',
                                  width: constraints.maxWidth * 0.35,
                                  height: constraints.maxHeight * 0.35,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: constraints.maxHeight * 0.04),
                        ProfilePageRow(
                          title: "Workout Plan Type",
                          data: workoutPlan.replaceAll("_", " & ").capitalize,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
