import 'dart:io';

import 'package:twitter_clone/core/utils/custom_proxy_http_override.dart';

/// Allows you to set and enable a proxy for your app
class CustomProxy {
  /// Initializer
  CustomProxy(
      {required this.ipAddress,
      required this.port,
      this.allowBadCertificates = false});

  /// A string representing an IP address for the proxy server
  final String ipAddress;

  /// The port number for the proxy server
  /// Can be null if port is default.
  final int? port;

  /// Set this to true
  /// - Warning: Setting this to true in production apps can be dangerous. Use with care!
  bool allowBadCertificates;

  /// Initializer from string
  /// Note: Uses static method, rather than named init to allow final properties.
  static CustomProxy? fromString({required String proxy}) {
    // Check if valid
    if (proxy == '') {
      assert(
          false, 'Proxy string passed to CustomProxy.fromString() is invalid.');
      return null;
    }

    // Build and return
    final List<String> proxyParts = proxy.split(':');
    final String ipAddress = proxyParts[0];
    final int? port =
        proxyParts.isNotEmpty ? int.tryParse(proxyParts[1]) : null;
    return CustomProxy(
      ipAddress: ipAddress,
      port: port,
    );
  }

  /// Enable the proxy
  void enable() {
    HttpOverrides.global = CustomProxyHttpOverride.withProxy(toString());
  }

  /// Disable the proxy
  void disable() {
    HttpOverrides.global = null;
  }

  @override
  String toString() {
    String proxy = ipAddress;
    if (port != null) {
      proxy += ':$port';
    }
    return proxy;
  }
}
