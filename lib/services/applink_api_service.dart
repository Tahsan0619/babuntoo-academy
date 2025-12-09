import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Applink API Service for SMS and Subscription integration
/// Based on OpenAPI specification provided
class ApplinkApiService {
  static const String baseUrl = 'https://api.applink.com'; // Replace with actual API URL
  
  // API Keys and credentials (should be stored securely)
  static const String apiKey = 'YOUR_API_KEY'; // Replace with actual API key
  static const String appId = 'YOUR_APP_ID'; // Replace with actual App ID
  
  // ==================== SMS SERVICES ====================
  
  /// Send SMS to a phone number
  /// 
  /// Parameters:
  /// - [phoneNumber]: Recipient phone number
  /// - [message]: SMS message content
  /// - [msisdn]: Sender MSISDN (optional)
  /// 
  /// Returns: SMS send response with message ID
  static Future<Map<String, dynamic>> sendSMS({
    required String phoneNumber,
    required String message,
    String? msisdn,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sms/send'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'address': phoneNumber,
          'singleMessageBody': message,
          'senderAddress': msisdn ?? 'AppLink',
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('SMS sent successfully: $data');
        }
        return {
          'success': true,
          'data': data,
          'message': 'SMS sent successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to send SMS: ${response.statusCode}',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending SMS: $e');
      }
      return {
        'success': false,
        'error': 'Error sending SMS: $e',
      };
    }
  }

  /// Receive SMS messages
  /// 
  /// Retrieves SMS sent to the web application since the previous invocation
  /// 
  /// Returns: List of received SMS messages
  static Future<Map<String, dynamic>> receiveSMS() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sms/receive'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'SMS retrieved successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to receive SMS: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error receiving SMS: $e');
      }
      return {
        'success': false,
        'error': 'Error receiving SMS: $e',
      };
    }
  }

  /// Get SMS delivery report
  /// 
  /// Returns the delivery status of a previously sent SMS
  /// 
  /// Parameters:
  /// - [messageId]: ID of the SMS message to track
  /// 
  /// Returns: Delivery status information
  static Future<Map<String, dynamic>> getSMSReport({
    required String messageId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sms/report'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'messageId': messageId,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'Report retrieved successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to get report: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting SMS report: $e');
      }
      return {
        'success': false,
        'error': 'Error getting SMS report: $e',
      };
    }
  }

  // ==================== SUBSCRIPTION SERVICES ====================

  /// Subscribe/Unsubscribe user
  /// 
  /// Parameters:
  /// - [msisdn]: User's mobile number
  /// - [subscriptionType]: Type of subscription (e.g., 'DAILY', 'WEEKLY', 'MONTHLY')
  /// - [action]: 'subscribe' or 'unsubscribe'
  /// - [shortCode]: Service short code
  /// 
  /// Returns: Subscription response
  static Future<Map<String, dynamic>> userSubscription({
    required String msisdn,
    required String subscriptionType,
    required String action,
    required String shortCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscription/send'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'msisdn': msisdn,
          'serviceType': subscriptionType,
          'action': action, // 'subscribe' or 'unsubscribe'
          'shortCode': shortCode,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'Subscription ${action}d successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to process subscription: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error processing subscription: $e');
      }
      return {
        'success': false,
        'error': 'Error processing subscription: $e',
      };
    }
  }

  /// Get the number of registered subscribers
  /// 
  /// Parameters:
  /// - [shortCode]: Service short code
  /// - [subscriptionType]: Type of subscription to query
  /// 
  /// Returns: Base size (number of subscribers)
  static Future<Map<String, dynamic>> getBaseSize({
    required String shortCode,
    required String subscriptionType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscription/query-base'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'shortCode': shortCode,
          'serviceType': subscriptionType,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'Base size retrieved successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to get base size: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting base size: $e');
      }
      return {
        'success': false,
        'error': 'Error getting base size: $e',
      };
    }
  }

  /// Get subscriber charging information
  /// 
  /// Parameters:
  /// - [msisdn]: User's mobile number
  /// - [shortCode]: Service short code
  /// 
  /// Returns: Subscriber charging information
  static Future<Map<String, dynamic>> getSubscriberChargingInfo({
    required String msisdn,
    required String shortCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscription/getSubscriberChargingInfo'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'msisdn': msisdn,
          'shortCode': shortCode,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'Charging info retrieved successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to get charging info: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting charging info: $e');
      }
      return {
        'success': false,
        'error': 'Error getting charging info: $e',
      };
    }
  }

  /// Send notification to subscriber
  /// 
  /// Parameters:
  /// - [msisdn]: Recipient's mobile number
  /// - [message]: Notification message
  /// - [shortCode]: Service short code
  /// 
  /// Returns: Notification send response
  static Future<Map<String, dynamic>> sendNotification({
    required String msisdn,
    required String message,
    required String shortCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscription/notify'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'msisdn': msisdn,
          'message': message,
          'shortCode': shortCode,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'Notification sent successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to send notification: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
      return {
        'success': false,
        'error': 'Error sending notification: $e',
      };
    }
  }

  // ==================== OTP SERVICES (For Login) ====================

  /// Request OTP for login verification
  /// 
  /// Parameters:
  /// - [msisdn]: User's mobile number
  /// - [shortCode]: Service short code
  /// 
  /// Returns: OTP request response
  static Future<Map<String, dynamic>> requestOTP({
    required String msisdn,
    required String shortCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/otp/request'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'msisdn': msisdn,
          'shortCode': shortCode,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'OTP sent successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to request OTP: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting OTP: $e');
      }
      return {
        'success': false,
        'error': 'Error requesting OTP: $e',
      };
    }
  }

  /// Verify OTP for login
  /// 
  /// Parameters:
  /// - [msisdn]: User's mobile number
  /// - [otpCode]: OTP code entered by user
  /// - [shortCode]: Service short code
  /// 
  /// Returns: OTP verification response
  static Future<Map<String, dynamic>> verifyOTP({
    required String msisdn,
    required String otpCode,
    required String shortCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/otp/verify'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'msisdn': msisdn,
          'otp': otpCode,
          'shortCode': shortCode,
          'appId': appId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
          'message': 'OTP verified successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to verify OTP: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying OTP: $e');
      }
      return {
        'success': false,
        'error': 'Error verifying OTP: $e',
      };
    }
  }

  // ==================== TEST MODE (No Backend) ====================
  
  /// Test SMS sending (Simulates API without actual backend)
  static Future<Map<String, dynamic>> testSendSMS({
    required String phoneNumber,
    required String message,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Return mock response
    return {
      'success': true,
      'data': {
        'messageId': 'MSG_${DateTime.now().millisecondsSinceEpoch}',
        'address': phoneNumber,
        'message': message,
        'status': 'SUBMITTED',
        'timestamp': DateTime.now().toIso8601String(),
      },
      'message': 'SMS queued for delivery (Test Mode)',
    };
  }

  /// Test subscription (Simulates API without actual backend)
  static Future<Map<String, dynamic>> testSubscription({
    required String msisdn,
    required String action,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Return mock response
    return {
      'success': true,
      'data': {
        'msisdn': msisdn,
        'action': action,
        'status': 'PROCESSED',
        'timestamp': DateTime.now().toIso8601String(),
        'message': 'User ${action}d successfully (Test Mode)',
      },
      'message': 'Subscription processed (Test Mode)',
    };
  }

  /// Test OTP request (Simulates API without actual backend)
  static Future<Map<String, dynamic>> testRequestOTP({
    required String msisdn,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Generate mock OTP
    final mockOTP = '123456'; // In test mode, OTP is always 123456
    
    return {
      'success': true,
      'data': {
        'msisdn': msisdn,
        'otpSent': true,
        'testOTP': mockOTP, // Only for testing
        'timestamp': DateTime.now().toIso8601String(),
      },
      'message': 'OTP sent (Test Mode - OTP: $mockOTP)',
    };
  }

  /// Test OTP verification (Simulates API without actual backend)
  static Future<Map<String, dynamic>> testVerifyOTP({
    required String msisdn,
    required String otpCode,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In test mode, accept any 6-digit code or '123456'
    final isValidOTP = otpCode == '123456' || otpCode.length == 6;
    
    return {
      'success': isValidOTP,
      'data': {
        'msisdn': msisdn,
        'verified': isValidOTP,
        'token': isValidOTP ? 'TEST_TOKEN_${DateTime.now().millisecondsSinceEpoch}' : null,
        'timestamp': DateTime.now().toIso8601String(),
      },
      'message': isValidOTP ? 'OTP verified (Test Mode)' : 'Invalid OTP',
    };
  }
}
