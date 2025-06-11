part of 'dashboard_drawer_view_model.dart';

class DashboardDrawerState extends Equatable {
  const DashboardDrawerState({
    this.isDragging = false,
    this.scale = DashboardDrawerHelper.percentageMinHeight,
    this.overlayOpacity = 0,
  });

  final bool isDragging;
  final double scale;
  final double overlayOpacity;

  DashboardDrawerState copyWith({
    bool? isDragging,
    double? scale,
    double? overlayOpacity,
  }) {
    return DashboardDrawerState(
      isDragging: isDragging ?? this.isDragging,
      scale: scale ?? this.scale,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
    );
  }

  @override
  List<Object> get props => [
        isDragging,
        scale,
        overlayOpacity,
      ];
}
