import 'package:equatable/equatable.dart';

class RecipeRateData extends Equatable {
  final List<RecipeRateResponse> rateList;

  const RecipeRateData({required this.rateList});

  @override
  // TODO: implement props
  List<Object?> get props => [
        rateList,
      ];
}

class RecipeRateResponse extends Equatable {
  final int id;
  final int rate;
  final String comment;

  RecipeRateResponse({
    required this.id,
    required this.rate,
    required this.comment,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        rate,
        comment,
      ];
}
