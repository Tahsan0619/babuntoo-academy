# Applink API Configuration Guide

## Quick Setup (5 Minutes)

### Step 1: Get Your Credentials
Contact Applink and receive:
- **API Key**: `your_api_key_here`
- **App ID**: `your_app_id_here`
- **Short Code**: `1234`

### Step 2: Update Configuration
Open `lib/services/applink_api_service.dart` and find:

```dart
class ApplinkApiService {
  static const String baseUrl = 'https://applink.com.bd';
  static const String apiKey = 'YOUR_API_KEY_HERE';
  static const String appId = 'YOUR_APP_ID_HERE';
  static const String defaultShortCode = '1234';
```

Replace with your actual credentials:

```dart
class ApplinkApiService {
  static const String baseUrl = 'https://applink.com.bd';
  static const String apiKey = 'sk_live_abc123xyz789';
  static const String appId = 'app_12345';
  static const String defaultShortCode = '4567';
```

### Step 3: Update Login/Signup Pages
Open `lib/login_page_with_api.dart` and `lib/signup_page_with_api.dart`

Find this line:
```dart
bool useTestMode = false;
```

- Set to `false` for **LIVE MODE** (uses real API)
- Set to `true` for **TEST MODE** (no API calls)

### Step 4: Run the App
```bash
flutter pub get
flutter run
```

---

## Environment-Specific Configuration

### For Development
```dart
// In lib/login_page_with_api.dart
bool useTestMode = true;  // Uses mock responses, no API calls

// In lib/signup_page_with_api.dart
bool useTestMode = true;  // Uses mock responses, no API calls
```

**Benefits:**
- No API quota used
- Instant testing
- No real SMS charges
- Can test without internet
- Perfect for debugging

### For Production
```dart
// In lib/login_page_with_api.dart
bool useTestMode = false;  // Uses real Applink API

// In lib/signup_page_with_api.dart
bool useTestMode = false;  // Uses real Applink API

// In lib/services/applink_api_service.dart
static const String apiKey = 'YOUR_REAL_API_KEY';
static const String appId = 'YOUR_REAL_APP_ID';
static const String defaultShortCode = 'YOUR_REAL_SHORT_CODE';
```

---

## Phone Number Format

### Accepted Formats
✅ `+8801712345678` (with country code)
✅ `8801712345678` (without plus sign)
✅ `01712345678` (local format, converted to +88)

### NOT Accepted
❌ `1712345678` (missing country/area code)
❌ `+880-1712-345-678` (with dashes)
❌ `0088-1712-345-678` (incorrect format)

### Validation Logic
```
If phone starts with "+88" → Use as-is
If phone starts with "88" → Use as-is
Otherwise → Prepend "+88"
```

---

## Testing the Setup

### Test Mode Workflow
```
1. Open app
2. Go to Login page
3. Toggle to "Test Mode"
4. Enter any number (e.g., 01712345678)
5. Click "Send OTP"
6. OTP appears in success message
7. Enter the OTP
8. Click "Verify & Login"
9. Success! You're on Home page
```

### Live Mode Workflow
```
1. Configure real API credentials
2. Toggle to "Live Mode"
3. Enter valid Bangladesh number
4. Click "Send OTP"
5. SMS arrives with OTP
6. Enter OTP
7. Click "Verify & Login"
8. Success! You're on Home page
```

---

## API Endpoint Details

### Base URL
```
https://applink.com.bd
```

### Required Headers
```
Content-Type: application/json
Authorization: Bearer {apiKey}
```

### OTP Request
```
POST /otp/request
{
  "msisdn": "+8801712345678",
  "shortCode": "1234"
}
```

### OTP Verify
```
POST /otp/verify
{
  "msisdn": "+8801712345678",
  "otpCode": "123456",
  "shortCode": "1234"
}
```

---

## Troubleshooting

### Problem: "Failed to send OTP"

**Check these:**
1. Internet connection is working
2. API key is correct in `applink_api_service.dart`
3. Phone number format is valid (starts with +88 or 88)
4. Applink API endpoint is correct (`https://applink.com.bd`)
5. Test mode is OFF for live testing
6. Your Applink account has SMS quota

**Solution:**
```bash
# Test API connectivity
curl -X GET https://applink.com.bd/health

# Check credentials
echo "API Key: $YOUR_API_KEY"
echo "App ID: $YOUR_APP_ID"
echo "Short Code: $YOUR_SHORT_CODE"
```

### Problem: "Invalid OTP"

**Reasons:**
1. OTP is expired (usually 5-10 minutes)
2. OTP entered incorrectly
3. OTP is already used
4. OTP belongs to different phone number

**Solution:**
1. Request a new OTP
2. Use the exact OTP sent via SMS
3. Don't reuse OTPs

### Problem: SMS Not Received

**Check:**
1. Phone number is correct
2. Phone has SMS service active
3. Phone is in a coverage area
4. SMS provider quota is available
5. Check spam folder

**Solution:**
1. Try requesting OTP again
2. Check if phone number is blocked by carrier
3. Contact Applink support if issue persists

### Problem: App Keeps Going to Login

**Reason:**
- Auth state is not saved
- SharedPreferences is empty

**Solution:**
1. Verify successful login (check console logs)
2. Check if `isLoggedIn` is set to true in SharedPreferences
3. Verify token is being saved
4. Check splash screen auth checking logic

---

## API Response Examples

### Successful OTP Request
```json
{
  "success": true,
  "message": "OTP sent successfully",
  "data": {
    "messageId": "msg_123456",
    "sentAt": "2024-12-20T10:30:00Z"
  }
}
```

### Successful OTP Verify
```json
{
  "success": true,
  "message": "OTP verified successfully",
  "data": {
    "token": "eyJhbGc...",
    "userId": "user_123",
    "expiresIn": 86400
  }
}
```

### Error Response
```json
{
  "success": false,
  "error": "Invalid OTP",
  "message": "The OTP provided is incorrect or expired"
}
```

---

## Security Checklist

Before going to production:

- [ ] API key is in environment variables (not hardcoded)
- [ ] Only HTTPS endpoints are used
- [ ] Token expiration is implemented
- [ ] Failed login attempts are logged
- [ ] Rate limiting is enabled
- [ ] Sensitive data is not logged
- [ ] Tokens are cleared on logout
- [ ] CORS headers are configured
- [ ] API key rotation policy is set
- [ ] Monitoring/alerts are enabled

---

## Performance Optimization

### For Faster OTP Delivery
1. Use closest Applink data center
2. Optimize network requests
3. Implement request caching
4. Use connection pooling

### For Better UX
1. Show loading indicators
2. Implement request timeout (30 seconds)
3. Provide clear error messages
4. Allow retry functionality

---

## Monitoring & Logging

### Important Events to Log
```dart
// Login attempt
print('Login attempt for: $phoneNumber');

// OTP request
print('OTP requested for: $phoneNumber');

// OTP verification
print('OTP verification for: $phoneNumber');

// Error
print('Login error: $error');
```

### Metrics to Track
- Total login attempts
- Successful logins
- Failed logins
- OTP delivery success rate
- Average OTP delivery time
- Error frequency

---

## Support

### Applink Support
- Email: support@applink.com.bd
- Phone: +880-XX-XXX-XXXXX
- Portal: https://applink.com.bd/support

### Common Questions
Q: How long is OTP valid?
A: Usually 5-10 minutes (configured by Applink)

Q: How many retries are allowed?
A: Usually 3 attempts (configured by Applink)

Q: Is there a daily limit?
A: Yes, depends on your plan (check with Applink)

Q: Can I use same phone multiple times?
A: Yes, each request generates new OTP

---

## Version Information

- **Applink API Version**: v1.0
- **Compatible with**: Flutter 3.0+
- **Dart Version**: 2.17+
- **Last Updated**: December 2024

---

**Configuration Complete!** 🎉

Your app is now ready to use Applink API for authentication.
