import 'package:expense_tracker/common/component/button/rounded_button.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/enum/button_state.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/helper/input_formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_selector.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/create_transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateTransactionForm extends HookWidget {
  const CreateTransactionForm({
    this.transaction,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  /// If populated, will edit instead of create.
  final Transaction? transaction;

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<CreateTransactionViewModel>().add(
            const CreateTransactionSubmitted(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final amountController = useTextEditingController(
      text: transaction?.amount.toString(),
    );
    final remarksController = useTextEditingController(
      text: transaction?.remarks,
    );
    final dateController = useTextEditingController(
      text: Formatter.date(transaction?.date ?? DateTime.now()),
    );

    return BlocListener<CreateTransactionViewModel, CreateTransactionState>(
      listenWhen: (_, current) => current.status.isLoaded,
      listener: (context, _) => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: _Form(
                  formKey: _formKey,
                  dateController: dateController,
                  amountController: amountController,
                  remarksController: remarksController,
                ),
              ),
            ),
            BlocSelector<CreateTransactionViewModel, CreateTransactionState,
                bool>(
              selector: (state) => state.status.isLoading,
              builder: (context, isLoading) {
                return RoundedButton(
                  label: transaction != null ? 'Update' : 'Create',
                  state: isLoading ? ButtonState.loading : ButtonState.idle,
                  onPressed: () => _onSubmit(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.formKey,
    required this.dateController,
    required this.amountController,
    required this.remarksController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController dateController;
  final TextEditingController amountController;
  final TextEditingController remarksController;

  Future<void> _onDateTapped(
    BuildContext context,
    TextEditingController dateController,
  ) async {
    final currentDate = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(currentDate.year - 10),
      lastDate: DateTime(currentDate.year + 10),
    );

    if (date == null) return;

    dateController.text = Formatter.date(date);

    if (context.mounted) {
      context.read<CreateTransactionViewModel>().add(
            CreateTransactionDateUpdated(date),
          );
    }
  }

  void _onRemarksUpdated(
    BuildContext context,
    String value,
  ) {
    context.read<CreateTransactionViewModel>().add(
          CreateTransactionRemarksUpdated(value),
        );
  }

  void _onAmountUpdated(
    BuildContext context,
    String value,
  ) {
    final amount = double.tryParse(value) ?? 0;

    context.read<CreateTransactionViewModel>().add(
          CreateTransactionAmountUpdated(amount),
        );
  }

  void _onCategoryChanged(
    BuildContext context,
    TransactionCategoryType category,
  ) {
    context.read<CreateTransactionViewModel>().add(
          CreateTransactionCategoryUpdated(category),
        );
  }

  @override
  Widget build(BuildContext context) {
    final category = context.select(
      (CreateTransactionViewModel viewModel) => viewModel.state.category,
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: TextStyles.labelRegular.copyWith(
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 4),
          CategorySelector(
            category: category,
            onChanged: (category) => _onCategoryChanged(
              context,
              category,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RoundedTextField(
                  controller: amountController,
                  label: 'Amount',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    InputFormatter.decimal,
                  ],
                  validator: _validateAmount,
                  onChanged: (value) => _onAmountUpdated(
                    context,
                    value,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: RoundedTextField(
                  controller: dateController,
                  label: 'Date',
                  readOnly: true,
                  onTap: () => _onDateTapped(
                    context,
                    dateController,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RoundedTextField(
            controller: remarksController,
            label: 'Remarks',
            textInputAction: TextInputAction.done,
            onChanged: (value) => _onRemarksUpdated(
              context,
              value,
            ),
          ),
        ],
      ),
    );
  }

  String? _validateAmount(String? value) {
    if (value?.isEmpty ?? true) return 'Amount is required';

    final amount = double.tryParse(value!);
    if (amount == null) return 'Invalid number format';
    if (amount <= 0) return 'Must be greater than 0';

    return null;
  }
}
