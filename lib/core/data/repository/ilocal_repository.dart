abstract class ILocalRepository {
  Future<void> setFailedAttemptCount(int value);

  Future<void> setSuccessfulAttemptCount(int value);

  int getFailedAttemptCount();

  int getSuccessfulAttemptCount();
}
