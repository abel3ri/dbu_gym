import "package:dio/dio.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

const List<Map<String, dynamic>> carouselContent = [
  {
    "headline": "Manage Your Fitness Subscription Plan.",
    "image_path": "assets/images/fitness3.png",
  },
  {
    "headline": "Achieve Your Fitness Goals With Us.",
    "image_path": "assets/images/fitness1.png",
  },
  {
    "headline": "Explore Our Variety Of Gym Equipments.",
    "image_path": "assets/images/fitness2.png",
  },
];

const Map<String, List<Map<String, dynamic>>> pricingContent = {
  "1-3Days": [
    {
      "workoutType": "Strength Training",
      "imagePath": "assets/images/pricing_page_image_1.png",
      "insidersPrice": "250 ETB/month",
      "outsidersPrice": "300 ETB/month",
      "noWorkingDays": "3 Days/week",
    },
    {
      "workoutType": "Aerobics Training",
      "imagePath": "assets/images/pricing_page_image_3.png",
      "insidersPrice": "300 ETB/month",
      "outsidersPrice": "350 ETB/month",
      "noWorkingDays": "3 Days/week",
    },
    {
      "workoutType": "Cardio Training",
      "imagePath": "assets/images/pricing_page_image_2.png",
      "insidersPrice": "300 ETB/month",
      "outsidersPrice": "350 ETB/month",
      "noWorkingDays": "3 Days/week",
    },
  ],
  "4-6Days": [
    {
      "workoutType": "Strength Training",
      "insidersPrice": "400 ETB/month",
      "outsidersPrice": "500 ETB/month",
      "imagePath": [
        "assets/images/pricing_page_image_1.png",
      ],
      "noWorkingDays": "6 Days/week",
    },
    {
      "workoutType": "Aerobics & Cardio",
      "insidersPrice": "500 ETB/month",
      "outsidersPrice": "600 ETB/month",
      "imagePath": [
        "assets/images/pricing_page_image_3.png",
        "assets/images/pricing_page_image_2.png",
      ],
      "noWorkingDays": "6 Days/week",
    },
    {
      "workoutType": "Cardio & Strength",
      "insidersPrice": "500 ETB/month",
      "outsidersPrice": "600 ETB/month",
      "imagePath": [
        "assets/images/pricing_page_image_2.png",
        "assets/images/pricing_page_image_1.png",
      ],
      "noWorkingDays": "6 Days/week",
    },
  ]
};

const Map<String, Map<String, List<String>>> workoutSessionContent = {
  "monWedFri": {
    "program 1": [
      "Mon morning: 06:00 AM - 07:30 AM",
      "Wed morning: 06:00 AM - 07:30 AM",
      "Fri morning: 06:00 AM - 07:30 AM",
    ],
    "program 2": [
      "Mon afternoon: 04:00 PM - 05:30 PM",
      "Wed afternoon: 04:00 PM - 05:30 PM",
      "Fri afternoon: 04:00 PM - 05:30 PM",
    ],
    "program 3": [
      "Mon afternoon: 06:00 PM - 07:30 PM",
      "Wed afternoon: 06:00 PM - 07:30 PM",
      "Fri afternoon: 06:00 PM - 07:30 PM",
    ],
  },
  "tueThuSat": {
    "program 1": [
      "Tue morning: 06:00 AM - 07:30 AM",
      "Thu morning: 06:00 AM - 07:30 AM",
      "Sat morning: 06:00 AM - 07:30 AM",
    ],
    "program 2": [
      "Tue afternoon: 04:00 PM - 05:30 PM",
      "Thu afternoon: 04:00 PM - 05:30 PM",
      "Sat afternoon: 04:00 PM - 05:30 PM",
    ],
    "program 3": [
      "Tue afternoon: 06:00 PM - 07:30 PM",
      "Thu afternoon: 06:00 PM - 07:30 PM",
      "Sat afternoon: 06:00 PM - 07:30 PM",
    ],
  }
};

const List<Map<String, String>> muscleGroupCategories = [
  {
    "name": "Abdominals",
    "imagePath": "assets/images/grid_images/muscles/abdominals.png",
  },
  {
    "name": "Biceps",
    "imagePath": "assets/images/grid_images/muscles/biceps.png",
  },
  {
    "name": "Calves",
    "imagePath": "assets/images/grid_images/muscles/calves.png",
  },
  {
    "name": "Chest",
    "imagePath": "assets/images/grid_images/muscles/chest.png",
  },
  {
    "name": "Middle Back",
    "imagePath": "assets/images/grid_images/muscles/middle_back.png",
  },
  {
    "name": "Shoulders",
    "imagePath": "assets/images/grid_images/muscles/shoulders.png",
  },
  {
    "name": "Triceps",
    "imagePath": "assets/images/grid_images/muscles/triceps.png",
  },
  {
    "name": "Quadriceps",
    "imagePath": "assets/images/grid_images/muscles/quadriceps.png",
  },
  {
    "name": "Traps",
    "imagePath": "assets/images/grid_images/muscles/traps.png",
  },
  {
    "name": "Forearms",
    "imagePath": "assets/images/grid_images/muscles/forearms.png",
  },
  {
    "name": "Lower Back",
    "imagePath": "assets/images/grid_images/muscles/lower_back.png",
  },
  {
    "name": "Hamstrings",
    "imagePath": "assets/images/grid_images/muscles/hamstrings.png",
  },
];

const List<Map<String, String>> difficultyCategories = [
  {
    "name": "Beginner",
  },
  {
    "name": "Intermediate",
  },
  {
    "name": "Expert",
  },
];
const List<Color> difficultyCategoryColors = [
  Colors.green,
  Colors.yellow,
  Colors.red,
];
const List<Map<String, String>> equipmentTypeCategories = [
  {
    "name": "Dumbbells",
    "imagePath": "assets/images/grid_images/equipments/dumbbell.png",
  },
  {
    "name": "EZ-bar",
    "imagePath": "assets/images/grid_images/equipments/ez_bar.png",
  },
  {
    "name": "Machine",
    "imagePath": "assets/images/grid_images/equipments/machine.png",
  },
  {
    "name": "Barbell",
    "imagePath": "assets/images/grid_images/equipments/barbell.png",
  },
  {
    "name": "Foam Roll",
    "imagePath": "assets/images/grid_images/equipments/foam_roll.png",
  },
  {
    "name": "Chest Press",
    "imagePath": "assets/images/grid_images/equipments/chest_press_machine.png",
  },
  {
    "name": "Kettle Bell",
    "imagePath": "assets/images/grid_images/equipments/kettlebells.png",
  },
  {
    "name": "Medicine Ball",
    "imagePath": "assets/images/grid_images/equipments/medicine_ball.png",
  },
  {
    "name": "Exercise Ball",
    "imagePath": "assets/images/grid_images/equipments/exercise_ball.png",
  },
  {
    "name": "Bench",
    "imagePath": "assets/images/grid_images/equipments/bench.png",
  },
  {
    "name": "Bands",
    "imagePath": "assets/images/grid_images/equipments/bands.png",
  },
];

const exerciseAPIUrl = "https://work-out-api1.p.rapidapi.com/search";
final dio = Dio();
Options options = Options(
  headers: {
    'X-RapidAPI-Key': dotenv.env["API_KEY"],
    'X-RapidAPI-Host': dotenv.env["API_HOST"],
  },
);

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;
