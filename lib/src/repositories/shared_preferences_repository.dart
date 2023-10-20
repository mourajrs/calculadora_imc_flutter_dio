import 'package:shared_preferences/shared_preferences.dart';

import 'storage_repository.dart';

class SharedRepository implements StorageRepository {
  @override
  Future<List<String>> getList(String key) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getStringList(key) ?? <String>[];
  }

  @override
  Future<bool> setList(String key, List<String> list) async {
    final storage = await SharedPreferences.getInstance();
    return await storage.setStringList('imcList', list);
  }
}
