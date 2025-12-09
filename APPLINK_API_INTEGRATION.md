# Applink API Integration Guide

This document explains the Applink API integration in Babuntoo Academy, including SMS and Subscription services.

## Overview

The Applink API service provides the following capabilities:

### 📱 SMS Services
- **Send SMS**: Send text messages to phone numbers
- **Receive SMS**: Retrieve incoming SMS messages
- **SMS Reports**: Track delivery status of sent messages

### 💳 Subscription Services
- **User Subscription**: Subscribe/unsubscribe users to services
- **Base Size**: Query number of registered subscribers
- **Subscriber Notifications**: Send notifications to subscribed users
- **Charging Info**: Get subscriber billing information

### 🔐 OTP Services
- **Request OTP**: Send one-time password to user's phone
- **Verify OTP**: Validate OTP for login/authentication

## Project Structure

```
lib/
├── services/
│   └── applink_api_service.dart          # Main API service
│
└── login_page_with_api.dart              # Demo login page with API integration
```

## Files Added/Modified

### 1. **applink_api_service.dart**
Main service class for all Applink API operations.

**Location**: `lib/services/applink_api_service.dart`

**Key Methods**:

#### SMS Methods
```dart
// Send SMS
ApplinkApiService.sendSMS(
  phoneNumber: '+8801234567890',
  message: 'Hello World',
)

// Receive SMS
ApplinkApiService.receiveSMS()

// Get SMS Report
ApplinkApiService.getSMSReport(messageId: 'MSG_123456')
```

#### Subscription Methods
```dart
// Subscribe user
ApplinkApiService.userSubscription(
  msisdn: '+8801234567890',
  subscriptionType: 'DAILY',
  action: 'subscribe',
  shortCode: '1234',
)

// Get base size
ApplinkApiService.getBaseSize(
  shortCode: '1234',
  subscriptionType: 'DAILY',
)

// Send notification
ApplinkApiService.sendNotification(
  msisdn: '+8801234567890',
  message: 'Notification text',
  shortCode: '1234',
)

// Get charging info
ApplinkApiService.getSubscriberChargingInfo(
  msisdn: '+8801234567890',
  shortCode: '1234',
)
```

#### OTP Methods
```dart
// Request OTP
ApplinkApiService.requestOTP(
  msisdn: '+8801234567890',
  shortCode: '1234',
)

// Verify OTP
ApplinkApiService.verifyOTP(
  msisdn: '+8801234567890',
  otpCode: '123456',
  shortCode: '1234',
)
```

#### Test Methods (No Backend Required)
```dart
// Test SMS without actual API
ApplinkApiService.testSendSMS(
  phoneNumber: '+8801234567890',
  message: 'Test message',
)

// Test subscription without actual API
ApplinkApiService.testSubscription(
  msisdn: '+8801234567890',
  action: 'subscribe',
)

// Test OTP without actual API
ApplinkApiService.testRequestOTP(msisdn: '+8801234567890')
ApplinkApiService.testVerifyOTP(
  msisdn: '+8801234567890',
  otpCode: '123456',
)
```

### 2. **login_page_with_api.dart**
Demo login page showcasing API integration.

**Location**: `lib/login_page_with_api.dart`

**Features**:
- OTP-based login
- SMS sending test
- Subscription management test
- Toggle between test mode and production
- Error and success messaging

## Configuration

### API Credentials

Update the following in `applink_api_service.dart`:

```dart
static const String baseUrl = 'https://api.applink.com'; // Your API endpoint
static const String apiKey = 'YOUR_API_KEY'; // Your API key
static const String appId = 'YOUR_APP_ID'; // Your app ID
```

### API Request Headers

All requests include:
```json
{
  "Content-Type": "application/json;charset=utf-8",
  "Authorization": "Bearer YOUR_API_KEY"
}
```

## Usage Examples

### Example 1: OTP-Based Login

```dart
// Step 1: Request OTP
final otpResponse = await ApplinkApiService.requestOTP(
  msisdn: userPhone,
  shortCode: '1234',
);

if (otpResponse['success']) {
  // Show OTP input dialog
}

// Step 2: Verify OTP
final verifyResponse = await ApplinkApiService.verifyOTP(
  msisdn: userPhone,
  otpCode: enteredOTP,
  shortCode: '1234',
);

if (verifyResponse['success']) {
  // Login successful
  // Use token from verifyResponse['data']['token']
}
```

### Example 2: Send Welcome SMS

```dart
final smsResponse = await ApplinkApiService.sendSMS(
  phoneNumber: userPhone,
  message: 'Welcome to Babuntoo Academy!',
  msisdn: 'AppLink', // Sender ID
);

if (smsResponse['success']) {
  print('SMS sent: ${smsResponse['data']['messageId']}');
}
```

### Example 3: Manage User Subscription

```dart
// Subscribe
final subscribeResponse = await ApplinkApiService.userSubscription(
  msisdn: userPhone,
  subscriptionType: 'DAILY',
  action: 'subscribe',
  shortCode: '1234',
);

if (subscribeResponse['success']) {
  print('User subscribed');
}

// Get base size
final baseSizeResponse = await ApplinkApiService.getBaseSize(
  shortCode: '1234',
  subscriptionType: 'DAILY',
);

if (baseSizeResponse['success']) {
  final subscriberCount = baseSizeResponse['data']['baseSize'];
  print('Total subscribers: $subscriberCount');
}
```

### Example 4: Send Notification to Subscriber

```dart
final notifyResponse = await ApplinkApiService.sendNotification(
  msisdn: userPhone,
  message: 'New course available!',
  shortCode: '1234',
);

if (notifyResponse['success']) {
  print('Notification sent');
}
```

## Test Mode vs Production

### Test Mode (Development)
- **No actual API calls** required
- **Simulates network delays** (1-2 seconds)
- **Mock responses** with realistic data
- **Default OTP**: `123456`
- **Any 6-digit code** is accepted as valid OTP

### Production Mode
- **Real API calls** to Applink servers
- **Requires valid API credentials**
- **Real SMS and subscription processing**
- **Actual charging** (if applicable)

### Toggle in Code
```dart
bool useTestMode = true; // Set to false for production

// Use test methods
if (useTestMode) {
  await ApplinkApiService.testSendSMS(...);
} else {
  await ApplinkApiService.sendSMS(...);
}
```

## API Response Format

### Success Response
```json
{
  "success": true,
  "data": {
    // API-specific data
  },
  "message": "Operation successful"
}
```

### Error Response
```json
{
  "success": false,
  "error": "Error description",
  "statusCode": 400
}
```

## Integration Steps

### Step 1: Update Configuration
1. Open `lib/services/applink_api_service.dart`
2. Update API credentials:
   ```dart
   static const String baseUrl = 'your_api_url';
   static const String apiKey = 'your_api_key';
   static const String appId = 'your_app_id';
   ```

### Step 2: Add to Login Page
Replace or update your existing login page:

```dart
import 'package:babuntoo_academy/login_page_with_api.dart';

// In your navigation:
'/login': (context) => const LoginPageWithAPI(),
```

### Step 3: Test with Demo Page
1. Run app: `flutter run`
2. Navigate to Login with API page
3. Toggle test mode on/off
4. Test SMS, OTP, and subscription features

### Step 4: Production Setup
1. Get API credentials from Applink
2. Update configuration
3. Set `useTestMode = false`
4. Handle real API responses

## Error Handling

The service returns consistent error responses:

```dart
final response = await ApplinkApiService.sendSMS(...);

if (!response['success']) {
  print('Error: ${response['error']}');
  print('Status Code: ${response['statusCode']}');
}
```

Common errors:
- **Invalid Phone Number**: Check format
- **Invalid OTP**: Verify OTP code
- **API Authentication**: Check API key and App ID
- **Network Error**: Check internet connection
- **Invalid MSISDN**: Use correct phone format

## Security Considerations

1. **Never hardcode API keys** in production code
2. **Use environment variables** for credentials
3. **Store API keys** in secure configuration files
4. **Encrypt** sensitive data in transit
5. **Validate** all user inputs before sending to API
6. **Use HTTPS** for all API calls (already configured)
7. **Handle** tokens securely (use secure storage)

## Performance Tips

1. **Cache** frequently used data
2. **Implement** request timeouts
3. **Use** async/await properly
4. **Implement** retry logic for failed requests
5. **Monitor** API response times
6. **Batch** multiple SMS sends when possible

## Troubleshooting

### SMS not sending?
- Verify phone number format: `+8801234567890`
- Check API key and App ID
- Ensure internet connection
- Check SMS balance in Applink account

### OTP not received?
- Verify phone number is correct
- Check SMS settings in app
- Ensure user has network connection
- Check Applink account status

### API credentials not working?
- Verify credentials are correct
- Check API endpoint URL
- Ensure API key is active
- Contact Applink support

### Test mode not working?
- Check internet connection (still needed for test delays)
- Verify phone number format
- Clear app cache: `flutter clean`
- Rebuild app: `flutter pub get && flutter run`

## API Endpoints Reference

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/sms/send` | POST | Send SMS |
| `/sms/receive` | POST | Receive SMS |
| `/sms/report` | POST | Get delivery report |
| `/subscription/send` | POST | Subscribe/Unsubscribe |
| `/subscription/query-base` | POST | Get base size |
| `/subscription/getSubscriberChargingInfo` | POST | Get charging info |
| `/subscription/notify` | POST | Send notification |
| `/otp/request` | POST | Request OTP |
| `/otp/verify` | POST | Verify OTP |

## Next Steps

1. ✅ API service created
2. ✅ Demo login page created
3. ⏳ Configure with actual API credentials
4. ⏳ Integrate into existing login page
5. ⏳ Test with real phone numbers
6. ⏳ Deploy to production

## Support

For issues or questions:
- Check Applink API documentation
- Review error messages in console
- Enable verbose logging: `flutter run --verbose`
- Contact Applink support: support@applink.com

## References

- [Applink API Documentation](https://api.applink.com/docs)
- [OpenAPI Specification](./openapi.json)
- [Flutter HTTP Package](https://pub.dev/packages/http)

---

**Last Updated**: December 9, 2025

**Version**: 1.0

**Status**: Ready for Integration
