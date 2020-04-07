import 'package:daily_prophet_flutter/core/stores/common_store.dart';

class BaseStore {
  bool isLoading = false;
  bool isFirst = true;
  CommonStore commonStore = CommonStore();
}
