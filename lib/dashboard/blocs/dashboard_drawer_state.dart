part of 'dashboard_drawer_cubit.dart';

class DashboardDrawerState extends Equatable {
  const DashboardDrawerState({
    this.overlayOpacity = 0,
  });

  final double overlayOpacity;

  DashboardDrawerState copyWith({
    double? overlayOpacity,
  }) {
    return DashboardDrawerState(
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
    );
  }

  @override
  List<Object> get props => [
        overlayOpacity,
      ];
}
