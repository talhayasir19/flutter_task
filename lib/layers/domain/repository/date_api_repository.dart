import '../../../config/constants/export.dart';
import '../../data/datasource/network/dio_api.dart';

abstract class DateApiRepository {
  DioApiImpl dioApiImpl;
  DateApiRepository({required this.dioApiImpl});
  Future<DateApiResponse> date();
}
