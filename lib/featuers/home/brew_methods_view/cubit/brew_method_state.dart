
sealed class BrewMethodState {}

final class BrewMethodInitial extends BrewMethodState {}
final class BrewMethodLoading extends BrewMethodState {}
final class BrewMethodSuccess extends BrewMethodState {}
final class BrewMethodError extends BrewMethodState {}
