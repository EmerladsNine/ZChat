import 'dart:collection';

class QueueNotifier<T> {
  final _listeners =  Queue<void Function(T)>();

  void notify(T value) {
    if(_listeners.isEmpty) return;
    final listener = _listeners.removeFirst();
    listener(value);
  }

  void listen(void Function(T) fn) {
    _listeners.add(fn);
  }

  void clearListeners()
  {
    _listeners.clear();
  }
}