part of 'food_scan_cubit.dart';

sealed class FoodScanState extends Equatable {
  const FoodScanState();

  @override
  List<Object?> get props => [];
}

final class FoodScanInitial extends FoodScanState {
  const FoodScanInitial();
}

final class FoodScanLoading extends FoodScanState {
  const FoodScanLoading();
}

final class FoodScanSuccess extends FoodScanState {
  const FoodScanSuccess({
    required this.analysis,
    required this.imagePath,
  });

  final FoodAnalysisModel analysis;
  final String imagePath;

  @override
  List<Object?> get props => [analysis, imagePath];
}

final class FoodScanFailure extends FoodScanState {
  const FoodScanFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

