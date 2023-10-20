// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio_lab_flutter_imc/src/home/models/imc.dart';
import 'package:dio_lab_flutter_imc/src/repositories/storage_repository.dart';

class HomeController {
  HomeController(
    this._imc,
    this._storage,
    this.imcList,
  );

  final StorageRepository _storage;
  List<String> imcList;
  IMC _imc;

  String calculate({
    required double weigth,
    required double heigth,
  }) {
    _imc = _imc.copyWith(
      weigth: weigth,
      heigth: heigth,
    );

    return _imc.calculate();
  }

  Future<List<String>> getList(String key) async {
    return _storage.getList(key);
  }

  Future<void> setList(String key, List<String> list) async {
    await _storage.setList(key, list);
  }
}
