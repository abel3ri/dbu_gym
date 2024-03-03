import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: exerciseProvider.gifBytes.isEmpty
                  ? Center(child: Text("No GIF"))
                  : Image.memory(Uint8List.fromList(exerciseProvider.gifBytes),
                      height: 200),
            ),
            Container(
              child: TextButton(
                  onPressed: () async {
                    await exerciseProvider.convertJpgToPdf();
                  },
                  child: Text("Click")),
            ),
          ],
        ),
      ),
    );
  }
}
