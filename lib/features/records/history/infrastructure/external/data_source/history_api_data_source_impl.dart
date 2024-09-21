import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/domain/external/data_source/history_external_data_source.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/dto/get_record_history_response_dto.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/mappers/record_history_mapper.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';

class HistoryApiDataSourceImpl implements HistoryExternalDataSource {
  @override
  Future<List<Record>> getHistory({int page = 0}) async {
    try {
      final response = await AppHttpSingleton().get(
        '/emotional-records',
        params: {
          'page': page,
        },
      );
      final List<GetRecordHistoryResponseDto> dto = (response.data as List)
          .map((e) => GetRecordHistoryResponseDto.fromJson(e))
          .toList();
      return RecordHistoryMapper.fromGetRecordHistoryResponseDto(dto);
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<DailyRecord>> getDailyHistory({int page = 0}) {
    // TODO: implement getDailyHistory
    throw UnimplementedError();
  }

  @override
  Future<List<TrascendentalRecord>> getTrascendentalHistory({int page = 0}) {
    // TODO: implement getWeeklyHistory
    throw UnimplementedError();
  }
}
