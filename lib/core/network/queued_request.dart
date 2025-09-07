import 'dart:async';

import 'package:dio/dio.dart';

class QueuedRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;

  QueuedRequest({required this.requestOptions, required this.completer});
}
