// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('browser')
import 'package:test/test.dart';
import 'package:web_uri/web_uri.dart';

void main() {
  test('should parse a URI', () {
    final uri = WebUri.parse('https://google.com/test?search=Hello');
    expect(uri.scheme, 'https');
    expect(uri.host, 'google.com');
    expect(uri.path, '/test');
    expect(uri.queryParameters, {'search': 'Hello'});
  });
}
