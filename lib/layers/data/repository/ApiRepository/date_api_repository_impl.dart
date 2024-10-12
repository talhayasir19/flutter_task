import 'package:flutter_api_task_clean_architecture/layers/data/datasource/network/dio_api.dart';

import '../../../../config/constants/export.dart';
import '../../../domain/repository/date_api_repository.dart';
import '../../models/export.dart';

class DateApiRepositoryImpl extends DateApiRepository {
  DateApiRepositoryImpl({required super.dioApiImpl});
  @override
  Future<DateApiResponse?> date() async {
    final response = await dioApiImpl.request<CalendarDataModel>(
      endpoint: ApiEndpoints.dateEndPoint,
      fromJsonT: CalendarDataModel.fromJson,
      httpRequestType: HttpRequestType.get,
    );

    return response;
  }
}
