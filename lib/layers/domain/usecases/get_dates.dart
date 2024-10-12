import 'package:either_dart/either.dart';
import 'package:flutter_api_task_clean_architecture/layers/domain/entity/export.dart';

import '../../data/models/export.dart';
import '../../data/repository/ApiRepository/export.dart';

class GetDates {
  DateApiRepositoryImpl ref;
  GetDates({required this.ref});
  Future<Either<ApiError, ApiResult<CalendarDataModel?>>> call() async {
    final response = await ref.date();
    if (response!.code == 200) {
      return Right(ApiResult<CalendarDataModel?>(response.data));
    } else {
      return Left(ApiError(message: "Something went wrong"));
    }
  }
}
