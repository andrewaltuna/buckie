part of 'categories_view_model.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesRequested extends CategoriesEvent {
  const CategoriesRequested(this.month);

  final TransactionMonth month;

  @override
  List<Object> get props => [month];
}
