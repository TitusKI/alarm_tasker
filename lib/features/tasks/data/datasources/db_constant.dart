import 'package:hive/hive.dart';

abstract class ConstantLocalDataSource {
  // cache taskId
  Future<void> cacheTaskId(String taskId);
  String? getTaskId();
  // clear taskId
  Future<void> clearTaskId();
}

class ConstantLocalDataSourceImpl implements ConstantLocalDataSource {
  final Box _box;

  ConstantLocalDataSourceImpl(this._box);

  @override
  Future<void> cacheTaskId(String taskId) async {
    await clearTaskId();
    return _box.put("taskId", taskId);
  }

  @override
  String? getTaskId() {
    return _box.get("taskId");
  }

  @override
  Future<void> clearTaskId() {
    return _box.delete("taskId");
  }
}
