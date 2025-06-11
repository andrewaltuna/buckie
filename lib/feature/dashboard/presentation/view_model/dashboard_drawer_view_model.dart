import 'dart:math';

import 'package:expense_tracker/feature/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_drawer_state.dart';

class DashboardDrawerViewModel extends Cubit<DashboardDrawerState> {
  DashboardDrawerViewModel() : super(const DashboardDrawerState());

  void onDrag(double scale) {
    if (DashboardDrawerHelper.exceedsConstraints(scale)) return;

    emit(
      state.copyWith(
        isDragging: true,
        scale: scale,
        overlayOpacity: _calculateOpacity(scale),
      ),
    );
  }

  void onDragEnd() {
    final scale = state.scale > DashboardDrawerHelper.percentageHeightMidpoint
        ? DashboardDrawerHelper.percentageMaxHeight
        : DashboardDrawerHelper.percentageMinHeight;

    emit(
      state.copyWith(
        isDragging: false,
        scale: scale,
        overlayOpacity: _calculateOpacity(scale),
      ),
    );
  }

  double _calculateOpacity(double scale) {
    final remainingSpace = 1 - scale;
    const sizeClamp = 1 - DashboardDrawerHelper.percentageMinHeight;

    return 1 - (min(remainingSpace, sizeClamp) / sizeClamp);
  }
}
