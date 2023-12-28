import 'package:financial_control_app/app/data/models/travel_model.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';

class TravelRepository {
  final _db = DatabaseProvider.db;
  final _table = DatabaseProvider.travelTable;

  Future<int> saveTravel(TravelModel data) =>
      _db.save(data: data, table: _table);

  Future<List<TravelModel>> getTravels({int limit = 10, int offset = 0}) =>
      _db.getTravels(limit, offset);
}
