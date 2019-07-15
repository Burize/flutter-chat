import 'package:flutter_chat/shared/utils/types.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

typedef T TConstructorMethod<T>();

class DI {
  static Injector _injector = Injector.getInjector('Deps');
  static List<Dependency> _deps = [];

  static clearDeps() {
    _injector.dispose();
    _deps.clear();
    _injector = Injector.getInjector('Deps');
  }

  static makeDependency<T>(TConstructorMethod<T> constructor) {
    final dependency = Dependency(T, constructor, isSingleton: true);
    if (!_deps.contains(dependency)) {
      _deps.add(dependency);
      _injector.map<T>((i) => constructor(), isSingleton: true);
      _injector.get<T>();
    }
  }

  static T get<T>() {
    final instances = _injector.getAll<T>();

    if (instances.length >= 1) {
      return instances.elementAt(0);
    }

    for (final dep in _deps) {
      if (dep.type == T) {
        _injector.map<T>((i) => dep.constructor(),
            isSingleton: dep.isSingleton);
        return _injector.get<T>();
      }
    }

    throw InjectorException(
        "Can\'t find dependency and constructor from type: ${typeOf<T>()}");
  }
}

class Dependency {
  Type type;
  TConstructorMethod constructor;
  bool isSingleton = false;
  Dependency(this.type, this.constructor, {this.isSingleton});
}
