import 'package:expense_tracker/common/extension/json_extension.dart';
import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/remote/budget_remote_source_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetRemoteSource implements BudgetRemoteSourceInterface {
  const BudgetRemoteSource(this._supabaseClient);

  static const _table = 'budgets';

  final SupabaseClient _supabaseClient;

  @override
  Future<double?> getLatestBudget() async {
    final result = await _supabaseClient
        .from(_table)
        .select(_budgetFullOutput)
        .order('month', ascending: false)
        .limit(1);

    return result.firstOrNull?.tryParseDouble('budget');
  }

  @override
  Future<double?> getBudget(TransactionMonth month) async {
    final result = await _supabaseClient
        .from(_table)
        .select(_budgetFullOutput)
        .eq('month', month.toDateTime());

    return result.firstOrNull?.tryParseDouble('budget');
  }

  @override
  Future<void> setBudget(SetBudgetInput input) async {
    try {
      if (input.amount == null) {
        await _supabaseClient.from(_table).delete().eq(
              'month',
              input.month.toDateTime(),
            );
      } else {
        await _supabaseClient.from(_table).upsert(
              input.toJson(),
              onConflict: 'user_id, month',
            );
      }
    } catch (error) {
      print(error);

      rethrow;
    }
  }
}

const _budgetFullOutput = '''
    id, 
    month, 
    budget
  ''';
