import 'dart:math';

import 'package:expense_tracker/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_drawer_state.dart';

class DashboardDrawerViewModel extends Cubit<DashboardDrawerState> {
  DashboardDrawerViewModel() : super(const DashboardDrawerState());

  void updateOverlayOpacity(double drawerSize) {
    final remainingSpace = 1 - drawerSize;
    const sizeClamp = 1 - DashboardDrawerHelper.percentageMinHeight;

    final value = 1 - (min(remainingSpace, sizeClamp) / sizeClamp);

    emit(state.copyWith(overlayOpacity: value));
  }
}
