import 'dart:async';

const fastReTouchThreshold = Duration(milliseconds: 300);
Timer? touchTimer;
int? pendingPage;
