import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesState()) {
    on<CategoriesLoaded>(_onLoaded);
  }

  void _onLoaded(
    CategoriesLoaded event,
    Emitter<CategoriesState> emit,
  ) {}
}
