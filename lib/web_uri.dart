// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

/// A lightweight alternative to [Uri] that only works in the browser.
///
/// Instead of using the full RFC implementation of [Uri], a minimal subset of
/// the APIs are present and mostly implemented using an in-memory `<a>`
/// element. The following APIs throw [UnsupportedError] as a result:
/// - [authority]
/// - [data]
/// - [normalizePath]
/// - [replace]
/// - [resolve]
/// - [resolveUri]
/// - [toFilePath]
class WebUri implements Uri {
  static T _notSupported<T>() {
    throw new UnsupportedError('Not supported in WebUri');
  }

  final AnchorElement _anchor;

  /// Parses [uri] into a [WebUri] instance.
  static WebUri parse(String uri) => new WebUri._(new AnchorElement(href: uri));

  const WebUri._(this._anchor);

  @override
  bool operator ==(Object o) => o is WebUri && _anchor.href == o._anchor.href;

  @override
  int get hashCode => _anchor.href.hashCode;

  @override
  String get authority => _notSupported();

  @override
  UriData get data => _notSupported();

  @override
  String get fragment => _anchor.hash;

  @override
  bool get hasAbsolutePath => path.startsWith('/');

  @override
  bool get hasAuthority => false;

  @override
  bool get hasEmptyPath => path.isEmpty;

  @override
  bool get hasFragment => fragment.isNotEmpty;

  @override
  bool get hasPort => port != null;

  @override
  bool get hasQuery => query.isNotEmpty;

  @override
  bool get hasScheme => scheme.isNotEmpty;

  @override
  String get host => _anchor.host;

  @override
  bool get isAbsolute => hasScheme && !hasFragment;

  @override
  bool isScheme(String scheme) => this.scheme == scheme;

  @override
  Uri normalizePath() => _notSupported();

  @override
  String get origin => _anchor.origin;

  @override
  String get path => _anchor.pathname;

  @override
  List<String> get pathSegments => path.split('/');

  @override
  int get port => int.parse(_anchor.port, onError: (_) => null);

  @override
  String get query => _anchor.search.substring(1);

  @override
  Map<String, String> get queryParameters {
    if (query.isEmpty) {
      return const {};
    }
    final result = <String, String>{};
    for (final key in query.split('&')) {
      final pair = key.split('=');
      result[pair[0]] = pair[1];
    }
    return result;
  }

  @override
  Map<String, List<String>> get queryParametersAll {
    if (query.isEmpty) {
      return const {};
    }
    final result = <String, List<String>>{};
    for (final key in query.split('&')) {
      final pair = key.split('=');
      result.putIfAbsent(pair[0], () => []).add(pair[1]);
    }
    return result;
  }

  @override
  Uri removeFragment() => new WebUri._(_anchor
    ..clone(false)
    ..hash = '');

  @override
  Uri replace({
    String scheme,
    String userInfo,
    String host,
    int port,
    String path,
    Iterable<String> pathSegments,
    String query,
    Map<String, dynamic> queryParameters,
    String fragment,
  }) =>
      _notSupported();

  @override
  Uri resolve(String reference) => _notSupported();

  @override
  Uri resolveUri(Uri reference) => _notSupported();

  @override
  String get scheme {
    var scheme = _anchor.protocol;
    if (scheme[scheme.length - 1] == ':') {
      scheme = scheme.substring(0, scheme.length - 1);
    }
    return scheme;
  }

  @override
  String toFilePath({bool windows}) => _notSupported();

  @override
  String get userInfo => _anchor.username;

  @override
  String toString() => '${_anchor.href}';
}
