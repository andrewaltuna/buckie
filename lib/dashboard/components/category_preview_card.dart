import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryPreviewCard extends StatelessWidget {
  const CategoryPreviewCard({
    super.key,
    required this.category,
  });

  final BudgetCategory category;

  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  Color changeColorSaturation(Color color, double saturation) =>
      HSLColor.fromColor(color).withSaturation(saturation).toColor();

  Color changeColorHue(Color color, double hue) {
    final currentHue = HSLColor.fromColor(color).hue;
    return HSLColor.fromColor(color).withHue(currentHue + hue).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
        // gradient: LinearGradient(
        //   tileMode: TileMode.clamp,
        //   // begin: Alignment.bottomLeft,
        //   // end: Alignment.topRight,
        //   colors: [
        //     // category.color,
        //     // category.color,
        //     Colors.blueGrey,
        //     Colors.blueGrey,
        //     // category.color.withOpacity(0.3),
        //     // Colors.white,
        //   ],
        // ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.white.withOpacity(0.8),
              color: category.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              category.icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${category.amountRemainingDisplay} LEFT',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.fontSubtitle,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: LinearProgressIndicator(
                          value: category.percentageSpent,
                          minHeight: 15,
                          color: category.color,
                          backgroundColor: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${category.percentageSpentDisplay}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
