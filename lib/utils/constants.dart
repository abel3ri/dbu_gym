import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

final List<Map<String, dynamic>> carouselContent = [
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

final Map<String, List<Map<String, dynamic>>> pricingContent = {
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

Map<String, Map<String, List<String>>> workoutSessionContent = {
  "monWedFri": {
    "program1": [
      "Monday morning: 06:00 AM - 07:30 AM",
      "Wednesday morning: 06:00 AM - 07:30 AM",
      "Friday morning: 06:00 AM - 07:30 AM",
    ],
    "program2": [
      "Monday afternoon: 04:00 PM - 05:30 PM",
      "Wednesday afternoon: 04:00 PM - 05:30 PM",
      "Friday afternoon: 04:00 PM - 05:30 PM",
    ],
    "program3": [
      "Monday afternoon: 06:00 PM - 07:30 PM",
      "Wednesday afternoon: 06:00 PM - 07:30 PM",
      "Friday afternoon: 06:00 PM - 07:30 PM",
    ],
  },
  "TueThuSat:": {
    "program1": [
      "Tuesday morning: 06:00 AM - 07:30 AM",
      "Thursday morning: 06:00 AM - 07:30 AM",
      "Saturday morning: 06:00 AM - 07:30 AM",
    ],
    "program2": [
      "Tuesday afternoon: 04:00 PM - 05:30 PM",
      "Thursday afternoon: 04:00 PM - 05:30 PM",
      "Saturday afternoon: 04:00 PM - 05:30 PM",
    ],
    "program3": [
      "Tuesday afternoon: 06:00 PM - 07:30 PM",
      "Thursday afternoon: 06:00 PM - 07:30 PM",
      "Saturday afternoon: 06:00 PM - 07:30 PM",
    ],
  },
};

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
