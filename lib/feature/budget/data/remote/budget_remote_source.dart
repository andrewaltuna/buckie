import 'package:expense_tracker/feature/budget/data/model/input/create_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/remote/budget_remote_source_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetRemoteSource implements BudgetRemoteSourceInterface {
  const BudgetRemoteSource(this._supabaseClient);

  static const _table = 'monthly_budgets';

  final SupabaseClient _supabaseClient;

  @override
  Future<int> getLatestBudget() async {
    final result = await _supabaseClient
        .from(_table)
        .select(_budgetFullOutput)
        .order('month', ascending: false)
        .limit(1);

    return result.first['budget'] as int;
  }

  @override
  Future<int> getBudget(TransactionMonth month) async {
    final result = await _supabaseClient
        .from(_table)
        .select(_budgetFullOutput)
        .eq('month', month);

    return result.first['budget'] as int;
  }

  @override
  Future<void> setBudget(CreateBudgetInput input) async {
    await _supabaseClient.from(_table).upsert(
          input.toJson(),
          onConflict: 'user_id, month',
        );
  }
}

const _budgetFullOutput = '''
    id, 
    month, 
    budget
  ''';
