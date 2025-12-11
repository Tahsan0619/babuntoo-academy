import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Applink API Service for SMS and Subscription integration only.
class ApplinkApiService {
  // ================== CONFIG ==================

  /// Applink base URL
  static const String _baseUrl = 'https://api.applink.com.bd/';

  /// Your App ID from Applink dashboard
  static const String appId = 'APP_018675'; // TODO: replace with your real App ID

  /// Your API key from Applink dashboard
  static const String apiKey = '19f0d73f45da48d6d4e02bb30cca4362'; // TODO: replace with your real key

  /// Default API version
  static const String _defaultVersion = '1.0';

  /// Common headers
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  // ================== INTERNAL HELPERS ==================

  static Uri _buildUri(String path) {
    // Ensure no duplicate slashes
    return Uri.parse('$_baseUrl$path');
  }

  static Map<String, dynamic> _successResponse(
      dynamic data, {
        String message = 'OK',
      }) {
    return {
      'success': true,
      'data': data,
      'message': message,
    };
  }

  static Map<String, dynamic> _errorResponse(
      String error, {
        int? statusCode,
        dynamic raw,
      }) {
    return {
      'success': false,
      'error': error,
      'statusCode': statusCode,
      'raw': raw,
    };
  }

  static void _debugLog(String label, dynamic value) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('[$label] $value');
    }
  }

  static String _ensureTel(String msisdn) {
    return msisdn.startsWith('tel') ? msisdn : 'tel$msisdn';
  }

  /// Format timestamp as yyMMddHHmm for subscription notify if needed externally.
  static String formatTimestamp(DateTime dt) {
    final year = dt.year % 100;
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '${year.toString().padLeft(2, '0')}$month$day$hour$minute';
  }

  // =====================================================
  //                     SMS SERVICES
  // =====================================================

  /// Send SMS to one or more destination numbers.
  ///
  /// Per docs:
  /// - endpoint: POST smssend
  /// - required: version, applicationId, password, message, destinationAddresses[]
  /// - optional: sourceAddress, deliveryStatusRequest, encoding, binaryHeader
  static Future<Map<String, dynamic>> sendSMS({
    required List<String> phoneNumbers,
    required String message,
    String sourceAddress = '77000',
    String version = _defaultVersion,
    String deliveryStatusRequest = '1', // "0" or "1"
    String? encoding, // "0", "240", "245"
    String? binaryHeader,
  }) async {
    try {
      final url = _buildUri('smssend');

      final destinationAddresses =
      phoneNumbers.map((p) => _ensureTel(p)).toList();

      final Map<String, dynamic> body = {
        'version': version,
        'applicationId': appId,
        'password': apiKey,
        'message': message,
        'destinationAddresses': destinationAddresses,
        'sourceAddress': sourceAddress,
        'deliveryStatusRequest': deliveryStatusRequest,
      };

      if (encoding != null && encoding.isNotEmpty) {
        body['encoding'] = encoding;
      }
      if (binaryHeader != null && binaryHeader.isNotEmpty) {
        body['binaryHeader'] = binaryHeader;
      }

      _debugLog('SMS SEND URL', url.toString());
      _debugLog('SMS SEND BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog('SMS SEND STATUS', response.statusCode);
      _debugLog('SMS SEND RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: 'SMS sent successfully',
        );
      }

      return _errorResponse(
        'Failed to send SMS. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('SMS SEND ERROR', e.toString());
      return _errorResponse('Error sending SMS: $e');
    }
  }

  /// Receive SMS messages sent to your application (MO).
  ///
  /// Per docs:
  /// - endpoint: POST smsreceive
  /// - required: version, applicationId, sourceAddress, message, requestId, encoding
  static Future<Map<String, dynamic>> receiveSMS({
    required String sourceAddress,
    required String message,
    required String requestId,
    String version = _defaultVersion,
    String encoding = '0', // 0 Text, 240 Flash, 245 Binary
  }) async {
    try {
      final url = _buildUri('smsreceive');

      final Map<String, dynamic> body = {
        'version': version,
        'applicationId': appId,
        'sourceAddress': _ensureTel(sourceAddress),
        'message': message,
        'requestId': requestId,
        'encoding': encoding,
      };

      _debugLog('SMS RECEIVE URL', url.toString());
      _debugLog('SMS RECEIVE BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog('SMS RECEIVE STATUS', response.statusCode);
      _debugLog('SMS RECEIVE RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: 'SMS retrieved successfully',
        );
      }

      return _errorResponse(
        'Failed to receive SMS. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('SMS RECEIVE ERROR', e.toString());
      return _errorResponse('Error receiving SMS: $e');
    }
  }

  /// Get SMS delivery report (normally Applink calls your endpoint as callback).
  ///
  /// Per docs:
  /// - endpoint: POST smsreport
  /// - required: destinationAddress, timeStamp (yyMMddHHmm), requestId, deliveryStatus
  static Future<Map<String, dynamic>> getSMSReport({
    required String destinationAddress,
    required String timeStamp,
    required String requestId,
    required String deliveryStatus,
  }) async {
    try {
      final url = _buildUri('smsreport');

      final Map<String, dynamic> body = {
        'destinationAddress': _ensureTel(destinationAddress),
        'timeStamp': timeStamp,
        'requestId': requestId,
        'deliveryStatus': deliveryStatus,
      };

      _debugLog('SMS REPORT URL', url.toString());
      _debugLog('SMS REPORT BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog('SMS REPORT STATUS', response.statusCode);
      _debugLog('SMS REPORT RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: 'Report retrieved successfully',
        );
      }

      return _errorResponse(
        'Failed to get report. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('SMS REPORT ERROR', e.toString());
      return _errorResponse('Error getting SMS report: $e');
    }
  }

  // =====================================================
  //                 SUBSCRIPTION SERVICES
  // =====================================================

  /// Subscribe / Unsubscribe user.
  ///
  /// Per docs:
  /// - endpoint: POST subscriptionsend
  /// - required: applicationId, password, subscriberId, action (0=unsub, 1=sub)
  static Future<Map<String, dynamic>> userSubscription({
    required String msisdn,
    required bool subscribe,
  }) async {
    try {
      final url = _buildUri('subscriptionsend');

      final Map<String, dynamic> body = {
        'applicationId': appId,
        'password': apiKey,
        'subscriberId': _ensureTel(msisdn),
        'action': subscribe ? '1' : '0',
      };

      _debugLog('USER SUBSCRIPTION URL', url.toString());
      _debugLog('USER SUBSCRIPTION BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog('USER SUBSCRIPTION STATUS', response.statusCode);
      _debugLog('USER SUBSCRIPTION RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: subscribe
              ? 'User subscribed successfully'
              : 'User unsubscribed successfully',
        );
      }

      return _errorResponse(
        'Failed to process subscription. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('USER SUBSCRIPTION ERROR', e.toString());
      return _errorResponse('Error processing subscription: $e');
    }
  }

  /// Get base size (number of registered subscribers).
  ///
  /// Per docs:
  /// - endpoint: POST subscriptionquery-base
  /// - required: applicationId, password
  static Future<Map<String, dynamic>> getBaseSize() async {
    try {
      final url = _buildUri('subscriptionquery-base');

      final Map<String, dynamic> body = {
        'applicationId': appId,
        'password': apiKey,
      };

      _debugLog('BASE SIZE URL', url.toString());
      _debugLog('BASE SIZE BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog('BASE SIZE STATUS', response.statusCode);
      _debugLog('BASE SIZE RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: 'Base size retrieved successfully',
        );
      }

      return _errorResponse(
        'Failed to get base size. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('BASE SIZE ERROR', e.toString());
      return _errorResponse('Error getting base size: $e');
    }
  }

  /// Get subscriber charging information.
  ///
  /// Per docs:
  /// - endpoint: POST subscriptiongetSubscriberChargingInfo
  /// - required: applicationId, password, subscriberIds (max 10)
  static Future<Map<String, dynamic>> getSubscriberChargingInfo({
    required List<String> msisdns,
  }) async {
    try {
      if (msisdns.isEmpty) {
        return _errorResponse('msisdns list cannot be empty');
      }
      if (msisdns.length > 10) {
        return _errorResponse('Maximum 10 MSISDNs allowed per request');
      }

      final url = _buildUri('subscriptiongetSubscriberChargingInfo');

      final subscriberIds =
      msisdns.map((m) => _ensureTel(m)).toList();

      final Map<String, dynamic> body = {
        'applicationId': appId,
        'password': apiKey,
        'subscriberIds': subscriberIds,
      };

      _debugLog('GET SUBSCRIBER CHARGING INFO URL', url.toString());
      _debugLog('GET SUBSCRIBER CHARGING INFO BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog(
          'GET SUBSCRIBER CHARGING INFO STATUS', response.statusCode);
      _debugLog(
          'GET SUBSCRIBER CHARGING INFO RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: 'Charging info retrieved successfully',
        );
      }

      return _errorResponse(
        'Failed to get charging info. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('GET SUBSCRIBER CHARGING INFO ERROR', e.toString());
      return _errorResponse('Error getting charging info: $e');
    }
  }

  /// Send subscription notification to user.
  ///
  /// Per docs:
  /// - endpoint: POST subscriptionnotify
  /// - required: timeStamp(yyMMddHHmm), version, applicationId, password,
  ///   subscriberId, frequency(daily/weekly/monthly/yearly), status
  static Future<Map<String, dynamic>> sendNotification({
    required String msisdn,
    required String frequency, // daily, weekly, monthly, yearly
    required String status, // REGISTERED, UNREGISTERED
    String? timeStamp, // yyMMddHHmm
    String version = _defaultVersion,
  }) async {
    try {
      final url = _buildUri('subscriptionnotify');

      final String ts =
          timeStamp ?? formatTimestamp(DateTime.now().toUtc());

      final Map<String, dynamic> body = {
        'timeStamp': ts,
        'version': version,
        'applicationId': appId,
        'password': apiKey,
        'subscriberId': _ensureTel(msisdn),
        'frequency': frequency,
        'status': status,
      };

      _debugLog('SUBSCRIPTION NOTIFY URL', url.toString());
      _debugLog('SUBSCRIPTION NOTIFY BODY', jsonEncode(body));

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      _debugLog('SUBSCRIPTION NOTIFY STATUS', response.statusCode);
      _debugLog('SUBSCRIPTION NOTIFY RESPONSE', response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _successResponse(
          data,
          message: 'Notification sent successfully',
        );
      }

      return _errorResponse(
        'Failed to send notification. Status: ${response.statusCode}',
        statusCode: response.statusCode,
        raw: response.body,
      );
    } catch (e) {
      _debugLog('SUBSCRIPTION NOTIFY ERROR', e.toString());
      return _errorResponse('Error sending notification: $e');
    }
  }
}
