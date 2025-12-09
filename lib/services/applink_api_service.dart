import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Applink API Service for SMS and Subscription integration
/// Based on OpenAPI specification provided
class ApplinkApiService {
  // API Configuration - Update with your credentials from Applink
  static const String baseUrl = 'https://applink.com.bd'; // Applink API endpoint
  static const String apiKey = '19f0d73f45da48d6d4e02bb30cca4362'; // Replace with actual API key from Applink
  static const String appId = 'APP_018675'; // Replace with your App ID from Applink
  
  // Default short code for SMS/Subscription services
  static const String defaultShortCode = '21213'; // Replace with your short code
  
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
        },
        body: jsonEncode({
          'version': '1.0',
          'applicationId': appId,
          'password': apiKey,
          'message': message,
          'destinationAddresses': [
            phoneNumber.startsWith('tel:') ? phoneNumber : 'tel:$phoneNumber'
          ],
          'sourceAddress': msisdn ?? '77000',
          'deliveryStatusRequest': '1',
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
        },
        body: jsonEncode({
          'version': '1.0',
          'applicationId': appId,
          'sourceAddress': 'tel:+8801234567890', // Placeholder
          'message': '',
          'requestId': 'APP_REQUEST',
          'encoding': '0',
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
        },
        body: jsonEncode({
          'destinationAddress': 'tel:+8801234567890',
          'timeStamp': '20240101000000',
          'requestId': messageId,
          'deliveryStatus': 'DELIVERED',
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
        },
        body: jsonEncode({
          'applicationId': appId,
          'password': apiKey,
          'subscriberId': msisdn.startsWith('tel:') ? msisdn : 'tel:$msisdn',
          'action': action == 'subscribe' ? '1' : '0', // 1 for subscribe, 0 for unsubscribe
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
        },
        body: jsonEncode({
          'applicationId': appId,
          'password': apiKey,
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
        },
        body: jsonEncode({
          'applicationId': appId,
          'password': apiKey,
          'subscriberIds': [
            msisdn.startsWith('tel:') ? msisdn : 'tel:$msisdn'
          ],
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
        },
        body: jsonEncode({
          'version': '1.0',
          'applicationId': appId,
          'password': apiKey,
          'subscriberId': msisdn.startsWith('tel:') ? msisdn : 'tel:$msisdn',
          'message': message,
          'frequency': 'daily',
          'status': 'REGISTERED',
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
      // Ensure msisdn is in correct format
      final subscriberId = msisdn.startsWith('tel:') ? msisdn : 'tel:$msisdn';
      
      final url = '$baseUrl/otp/request';
      final body = {
        'applicationId': appId,
        'password': apiKey,
        'subscriberId': subscriberId,
      };
      
      if (kDebugMode) {
        print('=== OTP REQUEST ===');
        print('URL: $url');
        print('Body: ${jsonEncode(body)}');
      }
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));

      if (kDebugMode) {
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
      }

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
          'error': 'Failed to request OTP: ${response.statusCode} - ${response.body}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('=== OTP REQUEST ERROR ===');
        print('Error: $e');
        print('Error type: ${e.runtimeType}');
      }
      return {
        'success': false,
        'error': 'Network Error: $e\n\nMake sure:\n1. Your internet is working\n2. API Key is correct\n3. App ID is correct',
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
      // Ensure msisdn is in correct format
      final subscriberId = msisdn.startsWith('tel:') ? msisdn : 'tel:$msisdn';
      
      final url = '$baseUrl/otp/verify';
      final body = {
        'applicationId': appId,
        'password': apiKey,
        'referenceNo': otpCode,
        'otp': otpCode,
        'sourceAddress': subscriberId,
      };
      
      if (kDebugMode) {
        print('=== OTP VERIFY ===');
        print('URL: $url');
        print('Body: ${jsonEncode(body)}');
      }
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));

      if (kDebugMode) {
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
      }

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
          'error': 'OTP verification failed: ${response.statusCode} - ${response.body}',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('=== OTP VERIFY ERROR ===');
        print('Error: $e');
        print('Error type: ${e.runtimeType}');
      }
      return {
        'success': false,
        'error': 'Network Error: $e',
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
