import 'package:flutter/foundation.dart';

import 'stores/account_store.dart';
import 'stores/project_store.dart';

class ApplicationState extends ChangeNotifier with AccountStore, ProjectStore {}
