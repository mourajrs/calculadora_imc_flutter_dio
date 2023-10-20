import 'package:dio_lab_flutter_imc/src/repositories/storage_repository.dart';
import 'package:hive/hive.dart';

class HiveRepository implements StorageRepository {
  @override
  Future<List<String>> getList(String key) async {
    final storage = await Hive.openBox<List<String>>(key);
    return storage.get(key) ?? <String>[];
  }

  @override
  Future<void> setList(String key, List<String> list) async {
    final storage = await Hive.openBox<List<String>>(key);
    storage.put(key, list);
  }
}
