import 'dart:convert';

import 'package:flutter/material.dart';

class Demo {
  final int a;
  final int b;
  Demo({
    this.a,
    this.b,
  });

  Demo copyWith({
    int a,
    int b,
  }) {
    return Demo(
      a: a ?? this.a,
      b: b ?? this.b,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'a': a,
      'b': b,
    };
  }

  factory Demo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Demo(
      a: map['a'],
      b: map['b'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Demo.fromJson(String source) => Demo.fromMap(json.decode(source));

  @override
  String toString() => 'Demo(a: $a, b: $b)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Demo && o.a == a && o.b == b;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode;
}
