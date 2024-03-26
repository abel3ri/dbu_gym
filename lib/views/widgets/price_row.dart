import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PriceRow extends StatelessWidget {
  int index;
  String title;
  String workoutDays;

  PriceRow({
    super.key,
    required this.workoutDays,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final priceProvider = Provider.of<PricingProvider>(context);

    /// check what the workoutDays is to remove code redundancy
    Map<String, dynamic>? price = priceProvider.priceData != null
        ? (workoutDays == '1-3Days'
            ? priceProvider.priceData![0]['1-3Days']![this.index]
            : priceProvider.priceData![1]['4-6Days']![this.index])
        : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          this.title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          price == null
              ? "Loading..."
              // check if the title is Price for insiders/Price for ousiders and display price accordingly
              : this.title == "Price for Insiders"
                  ? price['insidersPrice']!
                  : price['outsidersPrice']!,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }
}
