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

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
