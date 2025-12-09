# Babuntoo Academy - Authentication System Documentation

## Overview
Babuntoo Academy now features a complete OTP-based authentication system powered by **Applink API**. This document explains how the authentication works, how to use it, and how to integrate it with your own Applink credentials.

## Authentication Flow

### System Architecture
```
Splash Screen
    ↓
Check Auth Status (SharedPreferences)
    ├─ If Logged In → Home Page
    └─ If Not Logged In → Login Page
```

### Login Flow
```
Phone Number Input
    ↓
Request OTP (Applink API)
    ↓
Enter OTP Code
    ↓
Verify OTP (Applink API)
    ↓
Save Token & User Data (SharedPreferences)
    ↓
Navigate to Home Page
```

### Signup Flow
```
Phone Number Input
    ↓
Full Name Input
    ↓
Request OTP (Applink API)
    ↓
Enter OTP Code
    ↓
Subscription Preference
    ↓
Verify OTP & Create Account
    ↓
Subscribe (if selected)
    ↓
Save User Data & Token
    ↓
Navigate to Home Page
```

## Key Files

### Authentication Pages
- **`lib/login_page_with_api.dart`** - OTP-based login page
- **`lib/signup_page_with_api.dart`** - OTP-based signup page with subscription
- **`lib/splash_screen.dart`** - Startup screen with auth state checking

### Services
- **`lib/services/applink_api_service.dart`** - Complete Applink API integration
  - SMS operations (send, receive, reports)
  - OTP operations (request, verify)
  - Subscription management
  - Test modes for development

### Configuration
- **`lib/main.dart`** - Updated routing with auth-aware pages
- **`lib/home_page.dart`** - Home page with logout and profile features

## Setup Instructions

### 1. Get Applink API Credentials
Contact Applink to obtain:
- API Key
- App ID  
- Short Code

Example:
```
API Key: your_api_key_here
App ID: your_app_id_here
Short Code: 1234
```

### 2. Configure API Service
Update `lib/services/applink_api_service.dart`:

```dart
class ApplinkApiService {
  static const String baseUrl = 'https://applink.com.bd';
  static const String apiKey = 'YOUR_API_KEY_HERE';
  static const String appId = 'YOUR_APP_ID_HERE';
  static const String defaultShortCode = '1234'; // Your short code
}
```

### 3. Verify Dependencies
Ensure `pubspec.yaml` has:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
  shared_preferences: ^2.2.2
  provider: ^6.1.0
```

### 4. Run the App
```bash
flutter pub get
flutter run
```

## Features

### Login Page (`LoginPageWithAPI`)
- ✅ Phone number input with validation
- ✅ OTP request functionality
- ✅ OTP verification
- ✅ Secure token storage
- ✅ Auto-redirect to home on success
- ✅ Test mode for development (no real API calls)
- ✅ Error handling and user feedback
- ✅ Sign up link

**Phone Format Supported:**
- `+8801234567890` (with country code)
- `8801234567890` (without + sign)

### Signup Page (`SignupPageWithAPI`)
- ✅ Full name input
- ✅ Phone number input
- ✅ OTP verification
- ✅ Subscription preference toggle
- ✅ Automatic subscription handling
- ✅ User data persistence
- ✅ Test mode for development
- ✅ Back to login link

### Splash Screen
- ✅ Animated logo display
- ✅ Auth state checking
- ✅ Smart routing based on login status
- ✅ Fallback to login on errors

### Home Page Features
- ✅ User profile view (name, phone, subscription status)
- ✅ Logout functionality
- ✅ Profile access from menu
- ✅ Welcome dialog with app information
- ✅ Theme toggle (light/dark mode)

## Data Storage

### SharedPreferences Keys
```dart
'isLoggedIn'       → bool (login state)
'userPhone'        → String (user's phone number)
'userToken'        → String (API token)
'userName'         → String (user's full name)
'userSubscribed'   → bool (subscription status)
```

### Logout
When user logs out, all data is cleared:
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.clear(); // Clears all stored data
```

## Testing

### Test Mode (Development)
Both login and signup pages include a **Test Mode** toggle. When enabled:
- No actual API calls are made
- Mock responses are returned instantly
- OTP is displayed in the success message
- Perfect for development and testing

**To Enable Test Mode:**
1. On login/signup page, toggle the switch to "Test Mode"
2. Enter any phone number
3. OTP will be shown in the response

**Toggle in Code:**
```dart
bool useTestMode = true; // Set to true for development
```

### Real API Testing
1. Set `useTestMode = false` in login/signup pages
2. Ensure API credentials are configured in `ApplinkApiService`
3. Enter a valid Bangladeshi phone number
4. OTP will be sent via SMS
5. Enter the OTP received

## API Methods

### Applink API Service Methods

**OTP Operations:**
```dart
// Request OTP
ApplinkApiService.requestOTP(
  msisdn: '+8801234567890',
  shortCode: '1234'
)

// Verify OTP
ApplinkApiService.verifyOTP(
  msisdn: '+8801234567890',
  otpCode: '123456',
  shortCode: '1234'
)
```

**SMS Operations:**
```dart
// Send SMS
ApplinkApiService.sendSMS(
  phoneNumber: '+8801234567890',
  message: 'Welcome to Babuntoo Academy!'
)

// Receive SMS
ApplinkApiService.receiveSMS()

// Get SMS Report
ApplinkApiService.getSMSReport()
```

**Subscription Operations:**
```dart
// User Subscription
ApplinkApiService.userSubscription(
  msisdn: '+8801234567890',
  subscriptionType: 'DAILY',
  action: 'subscribe', // or 'unsubscribe'
  shortCode: '1234'
)

// Get Base Size
ApplinkApiService.getBaseSize()

// Get Subscriber Charging Info
ApplinkApiService.getSubscriberChargingInfo(msisdn: '+8801234567890')
```

## Error Handling

Both pages handle errors gracefully:

1. **Network Errors** - Displayed as error messages
2. **Invalid OTP** - Clear error feedback
3. **Missing Fields** - Validation before API calls
4. **API Failures** - User-friendly error messages

Example error scenarios:
```
"Please enter phone number"
"Phone must start with +88 or 88"
"Please enter OTP"
"Invalid OTP"
"Failed to send OTP"
"Error: Network connection failed"
```

## Routing

### Updated Routes
```dart
'/splash'    → SplashScreen (initial)
'/login'     → LoginPageWithAPI
'/signup'    → SignupPageWithAPI
'/home'      → HomePage
'/...'       → Other feature pages
```

### Routing Logic
- **On App Start:** Splash Screen checks auth state
- **If Logged In:** Routes to `/home`
- **If Not Logged In:** Routes to `/login`
- **On Signup Success:** Auto-routes to `/home`
- **On Login Success:** Auto-routes to `/home`
- **On Logout:** Clears data and routes to `/login`

## Security Considerations

### Token Storage
- Tokens are stored in `SharedPreferences` (standard for Flutter)
- For production, consider using `flutter_secure_storage` for encrypted storage

**To use secure storage:**
```yaml
dependencies:
  flutter_secure_storage: ^9.2.2
```

### Password Security
- No passwords used (OTP-based is more secure)
- OTP verified on backend before token issuance
- Tokens should have expiration times

### Best Practices
1. ✅ Always validate phone numbers client-side
2. ✅ Use HTTPS for API calls
3. ✅ Never log sensitive data
4. ✅ Clear data on logout
5. ✅ Implement token refresh logic for production
6. ✅ Add rate limiting to prevent brute force attacks

## Troubleshooting

### Issue: OTP Not Received
**Solution:**
- Check phone number format (must start with +88 or 88)
- Verify Applink API credentials in service
- Check if short code is correct
- Ensure SMS provider quota is available

### Issue: "Failed to send OTP"
**Solution:**
- Check internet connection
- Verify API endpoint is correct (`https://applink.com.bd`)
- Check if API key is valid
- Review Applink API documentation

### Issue: Cannot Login to Home Page
**Solution:**
- Check if token is being saved to SharedPreferences
- Verify home page route exists in main.dart
- Check SplashScreen auth checking logic
- Clear app data and try again

### Issue: Test Mode Not Working
**Solution:**
- Verify toggle is set to "Test Mode"
- Check if `useTestMode` is `true` in code
- Ensure test methods are implemented in ApplinkApiService
- Try refreshing the page

## Future Enhancements

- [ ] Token refresh mechanism
- [ ] Biometric login support
- [ ] Password-based login option
- [ ] Social login integration
- [ ] Email-based OTP option
- [ ] Account recovery flows
- [ ] Two-factor authentication
- [ ] Session management
- [ ] Login history tracking

## Support

For issues with:
- **Applink API**: Contact Applink support
- **Flutter Implementation**: Check `APPLINK_API_INTEGRATION.md`
- **General Bugs**: Create issues on GitHub

## Version History

### v1.0 (Current)
- ✅ Complete OTP-based login system
- ✅ User registration with signup
- ✅ Auth state management with SplashScreen
- ✅ User profile display
- ✅ Logout functionality
- ✅ Test mode for development
- ✅ Secure token storage

---

**Last Updated:** December 2024  
**Maintained By:** Babuntoo Academy Team
