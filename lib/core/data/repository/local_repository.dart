import 'package:injectable/injectable.dart';
import 'package:match5/core/data/repository/ilocal_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kFailedAttemptCount = "failedAttemptCount";
const String __kSuccessfulAttemptCount = "successfulAttemptCount";

@Injectable(as: ILocalRepository)
class LocalRepository extends ILocalRepository {
  final SharedPreferences _sharedPreferences;

  LocalRepository(this._sharedPreferences);

  @override
  int getFailedAttemptCount() {
    return _sharedPreferences.getInt(_kFailedAttemptCount) ?? 0;
  }

  @override
  int getSuccessfulAttemptCount() {
    return _sharedPreferences.getInt(__kSuccessfulAttemptCount) ?? 0;
  }

  @override
  Future<void> setFailedAttemptCount(int value) async {
    await _sharedPreferences.setInt(_kFailedAttemptCount, value);
  }

  @override
  Future<void> setSuccessfulAttemptCount(int value) async {
    await _sharedPreferences.setInt(__kSuccessfulAttemptCount, value);
  }
}
