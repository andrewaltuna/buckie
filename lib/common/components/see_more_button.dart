import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Pressed'),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'See more',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
