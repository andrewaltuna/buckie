import 'package:equatable/equatable.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

class Category extends Equatable {
  const Category({
    required this.details,
    required this.transactions,
  });

  final CategoryDetails details;
  final List<Transaction> transactions;

  double get expense => transactions.fold(
        0,
        (previous, transaction) => previous + transaction.amount,
      );

  @override
  List<Object?> get props => [
        details,
        expense,
      ];
}

// enum CategoryType {
//   clothing('Clothing'),
//   date('Date'),
//   education('Education'),
//   entertainment('Entertainment'),
//   food('Food'),
//   gift('Gift'),
//   groceries('Groceries'),
//   health('Health'),
//   transport('Transport'),
//   travel('Travel'),
//   utilities('Utilities'),
//   other('Other');

//   const CategoryType(this.label);

//   final String label;

//   IconData get icon => switch (this) {
//         CategoryType.clothing => Icons.checkroom,
//         CategoryType.date => Icons.favorite,
//         CategoryType.education => Icons.school,
//         CategoryType.entertainment => Icons.movie,
//         CategoryType.food => Icons.restaurant,
//         CategoryType.gift => Icons.card_giftcard,
//         CategoryType.groceries => Icons.shopping_cart,
//         CategoryType.health => Icons.medical_services,
//         CategoryType.transport => Icons.directions_car,
//         CategoryType.travel => Icons.flight,
//         CategoryType.utilities => Icons.build,
//         CategoryType.other => Icons.category,
//       };

//   Color get color => switch (this) {
//         CategoryType.date => const Color(0xFFE63946), // Coral Red
//         CategoryType.clothing => const Color(0xFFB667F1), // Vibrant Purple
//         CategoryType.education => const Color(0xFF4CC9F0), // Light Blue
//         CategoryType.entertainment => const Color(0xFFF72585), // Hot Pink
//         CategoryType.food => const Color(0xFFFF9F1C), // Warm Orange
//         CategoryType.gift => const Color(0xFFE63946), // Coral Red
//         CategoryType.groceries => const Color(0xFF2EC4B6), // Turquoise
//         CategoryType.health => const Color(0xFFFF006B), // Deep Pink
//         CategoryType.transport => const Color(0xFF00B4D8), // Cyan
//         CategoryType.travel => const Color(0xFF06D6A0), // Mint
//         CategoryType.utilities => const Color(0xFF7D8597), // Steel Gray
//         CategoryType.other => const Color(0xFF6B7280), // Cool Gray
//       };
// }
