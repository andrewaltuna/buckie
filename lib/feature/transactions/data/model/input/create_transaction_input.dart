class CreateTransactionInput {
  const CreateTransactionInput({
    required this.amount,
    required this.remarks,
    required this.date,
    required this.categoryId,
  });

  final double amount;
  final String? remarks;
  final DateTime date;
  final String categoryId;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'remarks': remarks == '' ? null : remarks,
      'category_id': categoryId,
      'date': date.toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
