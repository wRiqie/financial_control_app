import 'package:financial_control_app/app/data/models/travel_day_model.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';

class TravelDayRepository {
  final _db = DatabaseProvider.db;
  final _table = DatabaseProvider.travelDayTable;

  Future<int> save(TravelDayModel data) => _db.save(data: data, table: _table);

  Future<List<TravelDayModel>> getTravelDays(String travelId,
          {int limit = 10, int offset = 0}) =>
      _db.getTravelDays(travelId, limit, offset);

  Future<TravelDayModel?> getTravelDayById(int id) => _db.getTravelDayById(id);
}
