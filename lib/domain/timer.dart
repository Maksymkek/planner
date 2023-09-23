// ignore_for_file: await_only_futures, unnecessary_late

import 'dart:async';

import 'package:flutter/cupertino.dart';

final class AppTimer {
  AppTimer._() {
    _timer = Timer.periodic(const Duration(seconds: 5), _notify);
  }

  final List<Future<void> Function(Timer)> _callbacks = [];

  static late final AppTimer _appTimer = AppTimer._();
  late Timer _timer;

  Future<void> _notify(Timer timer) async {
    for (final callBack in _callbacks) {
      await callBack(timer);
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timer = Timer.periodic(const Duration(seconds: 5), _notify);
    } else if (state == AppLifecycleState.paused) {
      _timer.cancel();
    }
  }

  void addListener(Future<void> Function(Timer) listener) {
    _callbacks.add(listener);
  }

  void removeListener(Future<void> Function(Timer) listener) {
    _callbacks.remove(listener);
  }

  static AppTimer instance() {
    return _appTimer;
  }
}
